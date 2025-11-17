-- Update badge point values to match the original karma system
-- Based on charlie having 680 points total from PhD Student + Research Pioneer + posts

UPDATE badge SET points = 500 WHERE name = 'PhD Student';

-- Verify the update
SELECT name, points, category FROM badge ORDER BY points DESC, name;
