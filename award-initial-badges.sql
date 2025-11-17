-- HAAG Badge System - Award Initial Badges to Users
-- This script awards badges to the founding users based on their contributions
--
-- USAGE:
--   Get-Content award-initial-badges.sql | docker compose exec -T postgres psql -U lemmy -d lemmy
--   OR:
--   docker cp award-initial-badges.sql lemmy-haag-postgres-1:/tmp/
--   docker compose exec postgres psql -U lemmy -d lemmy -f /tmp/award-initial-badges.sql
--
-- PREREQUISITES:
--   1. init-badge-schema.sql has been run (tables created)
--   2. seed-badge-data.sql has been run (badges populated)
--   3. Users have been created in Lemmy (via web UI or admin CLI)
--
-- IMPORTANT: This script will only work AFTER you create user accounts.
-- If users don't exist, the INSERT statements will silently do nothing (ON CONFLICT).
--
-- To verify users exist first, run:
--   SELECT id, name FROM person WHERE name IN ('dima', 'leyang', 'jamesthesnake', 'charlie');

-- ============================================================================
-- HELPER: Get user and badge IDs
-- ============================================================================
-- Note: Run this after init-badge-schema.sql and seed-badge-data.sql

-- ============================================================================
-- AWARD BADGES TO: dima
-- Specialization: Research Progress Tracking
-- Badges: Research Pioneer, Data Analyst, Progress Tracker, Mentor
-- ============================================================================
INSERT INTO user_badge (person_id, badge_id, awarded_at, reason, progress)
SELECT 
    p.id,
    b.id,
    CURRENT_TIMESTAMP,
    'Founding member - Research Progress Tracking specialist',
    100
FROM person p
CROSS JOIN badge b
WHERE p.name = 'dima' 
AND b.name IN ('Research Pioneer', 'Data Analyst', 'Progress Tracker', 'Mentor')
ON CONFLICT (person_id, badge_id) DO NOTHING;

-- ============================================================================
-- AWARD BADGES TO: leyang
-- Specialization: Gamification & Engagement
-- Badges: Gamification Expert, Tech Innovator, Community Builder, ML Specialist
-- ============================================================================
INSERT INTO user_badge (person_id, badge_id, awarded_at, reason, progress)
SELECT 
    p.id,
    b.id,
    CURRENT_TIMESTAMP,
    'Founding member - Gamification & Engagement specialist',
    100
FROM person p
CROSS JOIN badge b
WHERE p.name = 'leyang'
AND b.name IN ('Gamification Expert', 'Tech Innovator', 'Community Builder', 'ML Specialist')
ON CONFLICT (person_id, badge_id) DO NOTHING;

-- ============================================================================
-- AWARD BADGES TO: jamesthesnake
-- Specialization: Conservation Technology & Administration
-- Badges: Research Pioneer, Tech Innovator, Conservation Hero, Field Expert, HAAG Admin
-- ============================================================================
INSERT INTO user_badge (person_id, badge_id, awarded_at, reason, progress)
SELECT 
    p.id,
    b.id,
    CURRENT_TIMESTAMP,
    'Founding member - Platform administrator and conservation technology expert',
    100
FROM person p
CROSS JOIN badge b
WHERE p.name = 'jamesthesnake'
AND b.name IN ('Research Pioneer', 'Tech Innovator', 'Conservation Hero', 'Field Expert', 'HAAG Admin')
ON CONFLICT (person_id, badge_id) DO NOTHING;

-- ============================================================================
-- AWARD BADGES TO: charlie
-- Specialization: PhD Student - Gator Research
-- Badges: PhD Student, Research Pioneer
-- ============================================================================
INSERT INTO user_badge (person_id, badge_id, awarded_at, reason, progress)
SELECT 
    p.id,
    b.id,
    CURRENT_TIMESTAMP,
    'PhD student conducting gator research',
    100
FROM person p
CROSS JOIN badge b
WHERE p.name = 'charlie'
AND b.name IN ('PhD Student', 'Research Pioneer')
ON CONFLICT (person_id, badge_id) DO NOTHING;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
-- Check which users have badges:
-- SELECT 
--     p.name as username,
--     COUNT(ub.id) as badge_count,
--     STRING_AGG(b.name, ', ') as badges
-- FROM person p
-- LEFT JOIN user_badge ub ON p.id = ub.person_id
-- LEFT JOIN badge b ON ub.badge_id = b.id
-- GROUP BY p.name
-- ORDER BY badge_count DESC;

-- View all badge awards:
-- SELECT * FROM user_badge_details ORDER BY awarded_at DESC;

-- Check karma for all users:
-- SELECT * FROM user_karma ORDER BY total_karma DESC;
