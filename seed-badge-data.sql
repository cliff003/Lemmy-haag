-- HAAG Badge System Initial Data
-- Seeds the database with the 12 default badges
--
-- USAGE:
--   Method 1 - PowerShell:
--   Get-Content seed-badge-data.sql | docker compose exec -T postgres psql -U lemmy -d lemmy
--
--   Method 2 - Copy and execute:
--   docker cp seed-badge-data.sql lemmy-haag-postgres-1:/tmp/
--   docker compose exec postgres psql -U lemmy -d lemmy -f /tmp/seed-badge-data.sql
--
-- PREREQUISITES:
--   - init-badge-schema.sql must be run first
--   - PostgreSQL container must be running
--
-- This script populates 12 badges across 6 categories:
--   - Research (4): Research Pioneer, Data Analyst, Field Expert, Progress Tracker
--   - Technology (3): Tech Innovator, ML Specialist, Gamification Expert
--   - Community (2): Community Builder, Mentor
--   - Special (1): Conservation Hero
--   - Admin (1): HAAG Admin
--   - Academic (1): PhD Student

-- Clear existing badges (optional - only if re-running)
-- DELETE FROM badge;

-- ============================================================================
-- INSERT ALL BADGES IN ONE STATEMENT
-- ============================================================================
INSERT INTO badge (name, description, icon, color, category, criteria, points) VALUES
-- Research Category
('Research Pioneer', 'Started 5+ research discussions and actively contributes to scientific discourse', '🔬', '#2c7a3f', 'research', 'Create at least 5 research-related posts or discussions', 150),
('Data Analyst', 'Posted 10+ data analysis insights and shares analytical expertise', '📊', '#3498db', 'research', 'Share 10+ data analysis posts or detailed analytical comments', 80),
('Field Expert', 'Shared valuable field research experiences and practical knowledge', '🌲', '#27ae60', 'research', 'Post about field research experiences or provide field expertise', 80),
('Progress Tracker', 'Specializes in tracking and documenting research progress effectively', '📈', '#ff6b35', 'research', 'Consistently track and share research progress updates', 40),

-- Technology Category
('Tech Innovator', 'Contributed innovative technology solutions to conservation challenges', '💡', '#f39c12', 'technology', 'Share technological innovations or solutions', 100),
('ML Specialist', 'Demonstrates machine learning and AI expertise in conservation applications', '🤖', '#8e44ad', 'technology', 'Contribute ML/AI related content or solutions', 100),
('Gamification Expert', 'Expert in gamification systems and user engagement strategies', '🎮', '#9b59b6', 'technology', 'Demonstrate expertise in gamification and engagement design', 60),

-- Community Category
('Community Builder', 'Actively engaged in 5+ communities and fosters collaboration', '🤝', '#e74c3c', 'community', 'Active participation in at least 5 different communities', 60),
('Mentor', 'Helped 20+ researchers through guidance and knowledge sharing', '🎓', '#34495e', 'community', 'Provide helpful responses to at least 20 questions or requests', 40),

-- Special Category
('Conservation Hero', 'Made significant contributions to conservation efforts and outcomes', '🦋', '#1abc9c', 'special', 'Demonstrate exceptional conservation impact', 120),

-- Admin Category
('HAAG Admin', 'Administrator of the HAAG Conservation Technology Network', '👑', '#8B0000', 'admin', 'Granted to platform administrators', 500),

-- Academic Category
('PhD Student', 'Doctoral student contributing to conservation research', '🐊', '#FF6B00', 'academic', 'Verified PhD student status', 200);

-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================
-- Run this to verify all badges were inserted correctly:
-- SELECT id, name, icon, category, points FROM badge ORDER BY category, name;
