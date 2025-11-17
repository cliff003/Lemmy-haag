# HAAG Badge System Reference

## Available Badges

**12 Total Badges** across 4 main categories:

### Research Badges
| Badge | Icon | Color | Description |
|-------|------|-------|-------------|
| **Research Pioneer** | 🔬 | Green (#2c7a3f) | Started 5+ research discussions |
| **Data Analyst** | 📊 | Blue (#3498db) | Posted 10+ data analysis insights |
| **Field Expert** | 🌲 | Green (#27ae60) | Shared field research experiences |
| **Progress Tracker** | 📈 | Orange (#ff6b35) | Research progress tracking specialist |

### Technology Badges
| Badge | Icon | Color | Description |
|-------|------|-------|-------------|
| **Tech Innovator** | 💡 | Orange (#f39c12) | Contributed technology solutions |
| **ML Specialist** | 🤖 | Purple (#8e44ad) | Machine learning expertise |
| **Gamification Expert** | 🎮 | Purple (#9b59b6) | Gamification and engagement specialist |

### Community Badges
| Badge | Icon | Color | Description |
|-------|------|-------|-------------|
| **Community Builder** | 🤝 | Red (#e74c3c) | Active in 5+ communities |
| **Mentor** | 🎓 | Dark Gray (#34495e) | Helped 20+ researchers |

### Special Badges
| Badge | Icon | Color | Description |
|-------|------|-------|-------------|
| **Conservation Hero** | 🦋 | Teal (#1abc9c) | Made significant conservation impact |

### Special Badges
| Badge | Icon | Color | Description |
|-------|------|-------|-------------|
| **HAAG Admin** | 👑 | Dark Red (#8B0000) | HAAG platform administrator |
| **PhD Student** | 🐊 | Orange (#FF6B00) | PhD student in conservation/ecology |

## Current Badge Assignments

### User: dima
**Specialization**: Research Progress Tracking  
**Level**: Expert | **Points**: 650 | **Posts**: 0

**Badges**:
- 🔬 Research Pioneer (150 pts)
- 📈 Progress Tracker (150 pts)
- 📊 Data Analyst (150 pts)
- 🎓 Mentor (200 pts)

---

### User: leyang
**Specialization**: Gamification & Engagement  
**Level**: Expert | **Points**: 700 | **Posts**: 0

**Badges**:
- 🎮 Gamification Expert (200 pts)
- 💡 Tech Innovator (150 pts)
- 🤝 Community Builder (150 pts)
- 🤖 ML Specialist (200 pts)

---

### User: jamesthesnake
**Specialization**: Conservation Technology & Administration  
**Level**: Admin | **Points**: 1200 | **Posts**: 0

**Badges**:
- 🔬 Research Pioneer (150 pts)
- 💡 Tech Innovator (150 pts)
- 🦋 Conservation Hero (250 pts)
- 🌲 Field Expert (150 pts)
- 👑 HAAG Admin (500 pts)

---

### User: charlie
**Specialization**: PhD Student - Gator Research  
**Level**: PhD Student | **Points**: 650 | **Posts**: 0

**Badges**:
- 🐊 PhD Student (500 pts)
- 🔬 Research Pioneer (150 pts)

---

## How to View Badges

### Live Badge System (Database-Driven)

Once Docker is running, badges are stored in PostgreSQL and served via the Badge API:

1. **Custom Frontend** (http://localhost:3000)
   - View all researchers with their badges
   - See live leaderboard with real karma calculations
   - Browse researcher profiles with badge displays

2. **Badge API Endpoints** (http://localhost:3001):
   ```bash
   # Get all 12 badges
   curl http://localhost:3001/api/badges
   
   # Get user's earned badges
   curl http://localhost:3001/api/badges/user/username
   
   # Get karma breakdown
   curl http://localhost:3001/api/badges/karma/username
   
   # Get leaderboard (top 20 users by karma)
   curl http://localhost:3001/api/badges/leaderboard
   
   # View badge profile page in browser
   http://localhost:3001/u/username
   ```

3. **Database Queries**:
   ```bash
   # Connect to PostgreSQL
   docker compose exec postgres psql -U lemmy -d lemmy
   
   # View all badges
   SELECT id, name, icon, category, points FROM badge ORDER BY category;
   
   # View user badges
   SELECT * FROM user_badge_details WHERE username = 'username';
   
   # View karma rankings
   SELECT * FROM user_karma ORDER BY total_karma DESC;
   ```

### Static Badge Data (Fallback)

Badge definitions are also available in JavaScript files for offline viewing:
- `badge-inline.js` - Static badge definitions
- `enhanced-frontend-with-badges.html` - Frontend with hardcoded data

## Badge Categories

The system organizes badges into these categories:
- **research** - Research contributions and scientific work (4 badges)
- **community** - Community building and engagement (3 badges)
- **technology** - Technical contributions and innovations (3 badges)
- **conservation** - Conservation impact and field work (included in research)
- **admin** - Platform administration (1 badge)
- **academic** - Academic achievements (1 badge)

## Karma System

Total karma is calculated automatically using the formula:
```
Total Karma = Sum(Badge Points) + (Post Count × 50) + Post Upvotes + Comment Upvotes
```

Each badge has its own point value based on difficulty and prestige:

### Badge Point Values:
- **HAAG Admin**: 500 points (highest prestige)
- **PhD Student**: 500 points (highest prestige)
- **Conservation Hero**: 250 points
- **ML Specialist**: 200 points
- **Gamification Expert**: 200 points
- **Mentor**: 200 points
- **Research Pioneer**: 150 points
- **Data Analyst**: 150 points
- **Field Expert**: 150 points
- **Progress Tracker**: 150 points
- **Tech Innovator**: 150 points
- **Community Builder**: 150 points

### Example Calculation:
User with Research Pioneer (150), Data Analyst (150), Mentor (200), plus 15 posts, 100 post upvotes, 50 comment upvotes:
- Badge points: 150 + 150 + 200 = 500
- Post bonus: 15 × 50 = 750
- Post upvotes: 100
- Comment upvotes: 50  
- **Total karma: 1400**

The karma view (`user_karma`) updates automatically when users receive upvotes or earn badges.

## Adding New Badges

### Method 1: Using SQL (Recommended)

1. **Create a new badge**:
   ```bash
   docker compose exec postgres psql -U lemmy -d lemmy
   ```
   
   ```sql
   INSERT INTO badge (name, description, icon, color, category, criteria, points, active)
   VALUES (
     'New Badge Name',
     'Detailed description of what this badge represents',
     '🎯',  -- Choose an emoji
     '#FF5733',  -- Hex color code
     'research',  -- Category: research, technology, community, special, admin, academic
     'How to earn this badge',
     100,  -- Karma points value (typically 100-500)
     true
   );
   ```

2. **Award the badge to a user**:
   ```sql
   INSERT INTO user_badge (person_id, badge_id, reason, progress)
   SELECT p.id, b.id, 'Achievement unlocked!', 100
   FROM person p, badge b
   WHERE p.name = 'username' AND b.name = 'New Badge Name';
   ```

### Method 2: Using Badge API

```bash
# Award an existing badge via POST request
curl -X POST http://localhost:3001/api/badges/award \
  -H "Content-Type: application/json" \
  -d '{
    "username": "targetuser",
    "badge_name": "Research Pioneer",
    "awarded_by": "admin",
    "reason": "Exceptional contributions"
  }'
```

### Updating Static Files (Optional)

If you want badges to appear in offline/static HTML views, also update:

**`badge-inline.js`**:
```javascript
'new-badge-id': { 
  name: 'Badge Name', 
  icon: '🎯', 
  color: '#FF5733' 
}
```

**User assignments**:
```javascript
'username': ['badge-id-1', 'badge-id-2', 'new-badge-id']
```

## Files Containing Badge Data

- `badge-inline.js` - Static badge definitions (lines 65-100)
- `badge-injection-dynamic.js` - Dynamic backend-driven version
- `badge-api.js` - REST API for badge management
- `enhanced-frontend-with-badges.html` - Frontend with badge displays
- Database tables: `badge`, `user_badge`, views: `user_badge_details`, `user_karma`
