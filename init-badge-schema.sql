-- HAAG Badge System Database Schema
-- Creates tables and views for the badge/gamification system
--
-- USAGE:
--   docker compose exec -T postgres psql -U lemmy -d lemmy < init-badge-schema.sql
--   OR copy to container and run:
--   docker cp init-badge-schema.sql lemmy-haag-postgres-1:/tmp/
--   docker compose exec postgres psql -U lemmy -d lemmy -f /tmp/init-badge-schema.sql
--
-- This script creates:
--   - badge table (stores 12 badge definitions)
--   - user_badge table (tracks badge awards to users)
--   - user_badge_details view (denormalized join for queries)
--   - user_karma view (automatic karma calculation)
--   - Indexes and triggers for performance
--
-- After running this, run seed-badge-data.sql to populate badges

-- ============================================================================
-- BADGE TABLE: Stores badge definitions
-- ============================================================================
CREATE TABLE IF NOT EXISTS badge (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    icon VARCHAR(10) NOT NULL,
    color VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL CHECK (category IN ('research', 'technology', 'community', 'special', 'admin', 'academic')),
    criteria TEXT,
    points INTEGER DEFAULT 100,
    active BOOLEAN DEFAULT true,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_badge_category ON badge(category);
CREATE INDEX IF NOT EXISTS idx_badge_active ON badge(active);

-- ============================================================================
-- USER_BADGE TABLE: Tracks badge awards to users
-- ============================================================================
CREATE TABLE IF NOT EXISTS user_badge (
    id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES person(id) ON DELETE CASCADE,
    badge_id INTEGER NOT NULL REFERENCES badge(id) ON DELETE CASCADE,
    awarded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    awarded_by INTEGER REFERENCES person(id),
    reason TEXT,
    progress INTEGER DEFAULT 100 CHECK (progress >= 0 AND progress <= 100),
    UNIQUE(person_id, badge_id)
);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_user_badge_person ON user_badge(person_id);
CREATE INDEX IF NOT EXISTS idx_user_badge_badge ON user_badge(badge_id);
CREATE INDEX IF NOT EXISTS idx_user_badge_awarded_at ON user_badge(awarded_at);

-- ============================================================================
-- USER_BADGE_DETAILS VIEW: Combines user and badge information
-- ============================================================================
CREATE OR REPLACE VIEW user_badge_details AS
SELECT 
    p.name as username,
    p.display_name,
    b.name as badge_name,
    b.description as badge_description,
    b.icon as badge_icon,
    b.color as badge_color,
    b.category as badge_category,
    b.points as badge_points,
    ub.awarded_at,
    ub.progress,
    ub.reason
FROM user_badge ub
JOIN person p ON ub.person_id = p.id
JOIN badge b ON ub.badge_id = b.id
WHERE b.active = true
ORDER BY ub.awarded_at DESC;

-- ============================================================================
-- USER_KARMA VIEW: Calculates user karma from posts and comments
-- ============================================================================
CREATE OR REPLACE VIEW user_karma AS
SELECT 
    p.name as username,
    p.display_name,
    COALESCE(SUM(pc.score), 0) as post_upvotes,
    COALESCE(SUM(cc.score), 0) as comment_upvotes,
    COALESCE(SUM(b.points), 0) as badge_bonus,
    COALESCE(SUM(pc.score), 0) + COALESCE(SUM(cc.score), 0) + COALESCE(SUM(b.points), 0) as total_karma
FROM person p
LEFT JOIN post po ON p.id = po.creator_id
LEFT JOIN post_aggregates pc ON po.id = pc.post_id
LEFT JOIN comment c ON p.id = c.creator_id
LEFT JOIN comment_aggregates cc ON c.id = cc.comment_id
LEFT JOIN user_badge ub ON p.id = ub.person_id
LEFT JOIN badge b ON ub.badge_id = b.id
WHERE p.deleted = false
GROUP BY p.id, p.name, p.display_name;

-- ============================================================================
-- TRIGGER: Update badge table's updated timestamp
-- ============================================================================
CREATE OR REPLACE FUNCTION update_badge_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_badge_timestamp ON badge;
CREATE TRIGGER trigger_update_badge_timestamp
    BEFORE UPDATE ON badge
    FOR EACH ROW
    EXECUTE FUNCTION update_badge_timestamp();

-- ============================================================================
-- COMMENTS
-- ============================================================================
COMMENT ON TABLE badge IS 'Stores all available badges in the HAAG system';
COMMENT ON TABLE user_badge IS 'Tracks which badges have been awarded to which users';
COMMENT ON VIEW user_badge_details IS 'Denormalized view combining user and badge data for easy querying';
COMMENT ON VIEW user_karma IS 'Calculates total karma for each user based on post/comment scores and badges';
