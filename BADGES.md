# HAAG Badge System Reference

## Available Badges

**30 Total Badges** across 6 main categories:

### Academic Badges
| Badge | Icon | Color | Points | Description | Origin |
|---|---|---|---|---|---|
| **CS8903 Researcher** | 🎓 | #2980b9 | 50 | Researcher enrolled in CS8903 Special Problems. | New |
| **CS6999 Researcher** | 🎯 | #f1c40f | 50 | Researcher enrolled in CS6999 Master's Project. | New |
| **Volunteer Researcher** | 🤲 | #1abc9c | 50 | Researcher contributing without course credit. | New |

### Research Badges
| Badge | Icon | Color | Points | Description | Origin |
|---|---|---|---|---|---|
| **Contributor (Lvl I)** | 🗣️ | #a5d6a7 | 40 | Posted 10+ research contributions. | New |
| **Active Voice (Lvl II)** | 📢 | #66bb6a | 100 | Posted 30+ research contributions. | New |
| **Prolific Debater (Lvl III)** | 🗯️ | #43a047 | 250 | Posted 75+ research contributions. | New |
| **Research Pillar (Lvl IV)** | 🏛️ | #1b5e20 | 500 | Posted 150+ research contributions. | New |
| **Reader (Lvl I)** | 👓 | #e1bee7 | 40 | Participated in 3 paper discussions. | New |
| **Presenter (Lvl II)** | 🎙️ | #ab47bc | 120 | Presented a paper to the club. | New |
| **Session Chair (Lvl III)** | ⚖️ | #8e24aa | 300 | Led or moderated 3+ paper sessions. | New |
| **Curriculum Director (Lvl IV)** | 📚 | #4a148c | 600 | Organized full semester paper schedule. | New |
| **Research Pioneer** | 🔬 | #2c7a3f | 150 | Started 5+ distinct research discussions. | Existing |
| **Data Analyst** | 📊 | #3498db | 80 | Posted 10+ data analysis insights. | Existing |
| **Field Expert** | 🌲 | #27ae60 | 80 | Shared significant field research experiences. | Existing |
| **Progress Tracker** | 📈 | #ff6b35 | 40 | Specialist in tracking research progress. | Existing |

### Technology Badges
| Badge | Icon | Color | Points | Description | Origin |
|---|---|---|---|---|---|
| **Code Artisan** | ⚒️ | #34495e | 100 | Writes efficient, hand-crafted code (No AI). | New |
| **Prompt Alchemist** | 🔮 | #9b59b6 | 60 | Mastery of Generative AI prompting. | New |
| **Vibe Coder** | 🌊 | #00bcd4 | 60 | Rapid prototyping using AI tools (Flow State). | New |
| **Tech Innovator** | 💡 | #f39c12 | 100 | Contributed novel technology solutions. | Existing |
| **ML Specialist** | 🤖 | #8e44ad | 100 | Demonstrated machine learning expertise. | Existing |
| **Gamification Expert** | 🎮 | #9b59b6 | 60 | Specialist in engagement and gamification. | Existing |

### Community Badges
| Badge | Icon | Color | Points | Description | Origin |
|---|---|---|---|---|---|
| **New Recruit (Lvl I)** | 🌱 | #b2dfdb | 20 | Active member for > 1 month. | New |
| **Semester Survivor (Lvl II)** | ⚓ | #4db6ac | 100 | Active member for > 1 semester (4 months). | New |
| **Yearling (Lvl III)** | 📆 | #009688 | 250 | Active member for > 1 year. | New |
| **HAAG Legacy (Lvl IV)** | 🦕 | #004d40 | 500 | Active member for > 2 years. | New |
| **Community Builder** | 🤝 | #e74c3c | 60 | Active participant in 5+ sub-communities. | Existing |
| **Mentor** | 🎓 | #34495e | 40 | Helped 20+ researchers with queries. | Existing |

### Special Badges
| Badge | Icon | Color | Points | Description | Origin |
|---|---|---|---|---|---|
| **PhD Student** | 🐊 | #FF6B00 | 200 | Verified doctoral student in conservation/ecology. | Existing |
| **Conservation Hero** | 🦋 | #1abc9c | 120 | Made significant real-world conservation impact. | Existing |

### Admin Badges
| Badge | Icon | Color | Points | Description | Origin |
|---|---|---|---|---|---|
| **HAAG Admin** | 👑 | #8B0000 | 500 | Administrator of the HAAG platform. | Existing |

## Current Badge Assignments

### User: dima
**Specialization**: Research Progress Tracking  
**Level**: Expert | **Points**: 310 | **Posts**: 0

**Badges**:
- 🔬 Research Pioneer (150 pts)
- 📊 Data Analyst (80 pts)
- 📈 Progress Tracker (40 pts)
- 🎓 Mentor (40 pts)

---

### User: leyang
**Specialization**: Gamification & Engagement  
**Level**: Expert | **Points**: 320 | **Posts**: 0

**Badges**:
- 💡 Tech Innovator (100 pts)
- 🤖 ML Specialist (100 pts)
- 🤝 Community Builder (60 pts)
- 🎮 Gamification Expert (60 pts)

---

### User: jamesthesnake
**Specialization**: Conservation Technology & Administration  
**Level**: Admin | **Points**: 950 | **Posts**: 0

**Badges**:
- 👑 HAAG Admin (500 pts)
- 🔬 Research Pioneer (150 pts)
- 🦋 Conservation Hero (120 pts)
- 💡 Tech Innovator (100 pts)
- 🌲 Field Expert (80 pts)

---

### User: charlie
**Specialization**: PhD Student - Gator Research  
**Level**: PhD Student | **Points**: 350 | **Posts**: 0

**Badges**:
- 🐊 PhD Student (200 pts)
- 🔬 Research Pioneer (150 pts)

---

### User: haag_tester
**Specialization**: Academic Research  
**Level**: Intermediate | **Points**: 270 | **Posts**: 0

**Badges**:
- 🎓 CS8903 Researcher (50 pts)
- 📢 Active Voice (Lvl II) (100 pts)
- ⚒️ Code Artisan (100 pts)
- 🌱 New Recruit (Lvl I) (20 pts)

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
- **research** - Research contributions and scientific work (12 badges)
- **technology** - Technical contributions and innovations (6 badges)
- **community** - Community building and engagement (6 badges)
- **academic** - Academic achievements (3 badges)
- **special** - Special recognition (2 badges)
- **admin** - Platform administration (1 badge)

## Karma System

Total karma is calculated automatically using the formula:
```
Total Karma = Sum(Badge Points) + (Post Count × 50) + Post Upvotes + Comment Upvotes
```

Each badge has its own point value based on difficulty and prestige:

### Badge Point Values:
- **Curriculum Director (Lvl IV)**: 600 points
- **HAAG Admin**, **HAAG Legacy (Lvl IV)**, **Research Pillar (Lvl IV)**: 500 points
- **Session Chair (Lvl III)**: 300 points
- **Yearling (Lvl III)**, **Prolific Debater (Lvl III)**: 250 points
- **PhD Student**: 200 points
- **Research Pioneer**: 150 points
- **Conservation Hero**, **Presenter (Lvl II)**: 120 points
- **Semester Survivor (Lvl II)**, **Active Voice (Lvl II)**, **Code Artisan**, **Tech Innovator**, **ML Specialist**: 100 points
- **Data Analyst**, **Field Expert**: 80 points
- **Community Builder**, **Gamification Expert**, **Prompt Alchemist**, **Vibe Coder**: 60 points
- **CS8903 Researcher**, **CS6999 Researcher**, **Volunteer Researcher**: 50 points
- **Mentor**, **Progress Tracker**, **Contributor (Lvl I)**, **Reader (Lvl I)**: 40 points
- **New Recruit (Lvl I)**: 20 points

### Example Calculation:
User with Research Pioneer (150), Data Analyst (80), Mentor (40), plus 15 posts, 100 post upvotes, 50 comment upvotes:
- Badge points: 150 + 80 + 40 = 270
- Post bonus: 15 × 50 = 750
- Post upvotes: 100
- Comment upvotes: 50  
- **Total karma: 1170**

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
