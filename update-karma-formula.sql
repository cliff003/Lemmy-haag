-- Update karma calculation to match the original point system
-- Original points: dima=1250, leyang=1100, jamesthesnake=950, charlie=680
-- This suggests: Badge Points + (Posts × Post Weight) + (Comments × Comment Weight)

CREATE OR REPLACE VIEW user_karma AS
SELECT 
    p.name AS username,
    p.display_name,
    COALESCE(COUNT(DISTINCT po.id), 0) AS post_count,
    COALESCE(COUNT(DISTINCT c.id), 0) AS comment_count,
    COALESCE(SUM(DISTINCT pc.score), 0) AS post_upvotes,
    COALESCE(SUM(DISTINCT cc.score), 0) AS comment_upvotes,
    COALESCE(SUM(b.points), 0) AS badge_bonus,
    -- Original formula: Badge Points + (Posts × 50) + Post Upvotes + Comment Upvotes
    COALESCE(SUM(b.points), 0) + 
    (COALESCE(COUNT(DISTINCT po.id), 0) * 50) +
    COALESCE(SUM(DISTINCT pc.score), 0) + 
    COALESCE(SUM(DISTINCT cc.score), 0) AS total_karma
FROM person p
LEFT JOIN post po ON p.id = po.creator_id
LEFT JOIN post_aggregates pc ON po.id = pc.post_id
LEFT JOIN comment c ON p.id = c.creator_id
LEFT JOIN comment_aggregates cc ON c.id = cc.comment_id
LEFT JOIN user_badge ub ON p.id = ub.person_id
LEFT JOIN badge b ON ub.badge_id = b.id
WHERE p.deleted = false
GROUP BY p.id, p.name, p.display_name;
