# HAAG - Conservation Technology Network

A gamified research collaboration platform built on Lemmy, designed for conservation technology researchers, wildlife biologists, and conservation scientists.

## Recent Updates (November 2025)

### Badge System Implementation
- ✅ **Complete Badge Infrastructure**: Created PostgreSQL schema with `badge`, `user_badge`, `user_badge_details`, and `user_karma` views
- ✅ **30 Active Badges**: Implemented weighted point system (20-600 points) across 6 categories
- ✅ **Badge API**: REST API on port 3001 with endpoints for badges, user profiles, karma calculation, and leaderboards
- ✅ **Frontend Integration**: Added badge displays to custom frontend with live leaderboard and user profile badges
- ✅ **Example Users**: Created 4 demo users (dima, leyang, jamesthesnake, charlie) with assigned badges
- ✅ **Karma Formula**: `Total Karma = Sum(Badge Points) + (Post Count × 50) + Post Upvotes + Comment Upvotes`

### Badge Point Values
Redesigned badge point system to reflect difficulty and prestige:
- **Curriculum Director (Lvl IV)**: 600 points
- **HAAG Admin, Research Pillar (Lvl IV)**: 500 points
- **Session Chair (Lvl III)**: 300 points
- **Yearling (Lvl III), Prolific Debater (Lvl III)**: 250 points
- **PhD Student**: 200 points
- **Research Pioneer**: 150 points
- **Conservation Hero, Presenter (Lvl II)**: 120 points
- **Semester Survivor (Lvl II), Active Voice (Lvl II), Code Artisan**: 100 points
- **Data Analyst, Field Expert**: 80 points
- **Community Builder, Gamification Expert**: 60 points
- **CS8903/CS6999 Researcher**: 50 points
- **Mentor, Progress Tracker**: 40 points
- **New Recruit (Lvl I)**: 20 points

### Database Schema
- Created automated badge tracking system
- Implemented real-time karma calculation views
- Added foreign key relationships between users and badges
- Included progress tracking and award timestamps

## Overview

HAAG (Herpetology and Amphibian Action Group) is a customized Lemmy instance that adds gamification, badge systems, and enhanced user profiles to foster scientific collaboration in conservation technology. The platform features multiple frontend options and a comprehensive achievement system to encourage community engagement.

## Features

### 🏆 Gamification & Badge System
- **30 Active Badges**: Including tiered progression for Research (Lvl I-IV) and Community (Lvl I-IV) engagement.
- **Badge Categories**: Research (12), Technology (6), Community (6), Special (2), Admin (1), Academic (3)
- **Karma Tracking**: Real-time calculation: Sum(Badge Points) + (Post Count × 50) + Post Upvotes + Comment Upvotes
- **Leaderboard**: Live rankings based on total karma and achievements
- **Progress Tracking**: Visual indicators for badge progress and completion status

### 🎨 Multiple Frontend Options
1. **Custom Enhanced Frontend** (Port 3000)
   - Research-focused design with conservation themes
   - Integrated badge displays and user profiles
   - Leaderboard and featured researchers
   - Conservation-specific tag system
   
2. **Alexandrite UI** (Ports 80/443)
   - Modern, clean alternative Lemmy interface
   - Enhanced navigation and responsiveness
   
3. **Standard Lemmy UI** (Ports 8080/8443)
   - Traditional Lemmy interface
   - Badge injection via client-side scripts

### 🔬 Research-Oriented Features
- **Conservation Tags**: Pre-configured tags for camera-traps, machine-learning, acoustic-monitoring, wildlife-tracking, etc.
- **Researcher Profiles**: Specialized profiles showing expertise areas and contributions
- **Community Specialization**: Topic-specific communities for different conservation domains

## Architecture

### Services
- **Lemmy Backend** (v0.19.12) - Core federated forum engine
- **PostgreSQL** - Database with custom views for badge and karma systems
- **Badge API** - Node.js/Express REST API for gamification features
- **Pictrs** - Image hosting and processing service
- **Nginx** - Reverse proxy with SSL/TLS support
- **Postfix** - Email relay for notifications

### Technology Stack
- **Backend**: Rust (Lemmy), Node.js (Badge API)
- **Database**: PostgreSQL 17 with auto-upgrade
- **Frontend**: React (Lemmy-UI), Vanilla JS (Custom Frontend), Alexandrite
- **Infrastructure**: Docker Compose
- **Proxy**: Nginx with custom injection scripts

## Installation

### Prerequisites
- Docker Desktop for Windows/Mac or Docker Engine for Linux
- Docker Compose (v2.0+)
- At least 4GB RAM available
- Ports 80, 443, 3000, 8080, 8443 available

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/jamesthesnakegatech/Lemmy-haag.git
   cd Lemmy-haag
   ```

2. **Generate SSL certificates**
   ```bash
   # Linux/Mac
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout key.pem -out cert.pem \
     -config openssl.conf -subj "/CN=localhost"
   
   # Windows PowerShell
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout key.pem -out cert.pem -config openssl.conf -subj "/CN=localhost"
   ```

3. **Start all services**
   ```bash
   # Docker Compose v2 (recommended)
   docker compose up -d
   
   # Docker Compose v1
   docker-compose up -d
   ```

4. **Wait for services to initialize** (2-3 minutes for first run)
   ```bash
   docker compose logs -f
   ```

5. **Access the platform**
   - Custom Frontend: http://localhost:3000
   - Alexandrite UI: http://localhost or https://localhost:443
   - Standard Lemmy UI: http://localhost:8080 or https://localhost:8443

6. **Create admin account**
   - Visit any frontend URL
   - Click "Sign Up" and create your admin account
   - This will be the instance administrator

## Configuration

### Environment Variables
Key environment variables are configured in `docker-compose.yml`:
- `LEMMY_UI_LEMMY_EXTERNAL_HOST`: External hostname (default: 134.199.214.141)
- `POSTGRES_PASSWORD`: Database password (default: changeme123)
- `PICTRS__SERVER__API_KEY`: Image service API key (default: changeme123)

### Custom Configuration Files
- `lemmy.hjson` - Lemmy server configuration
- `nginx_internal.conf` - Nginx config for standard Lemmy UI
- `nginx_alexandrite.conf` - Nginx config for Alexandrite frontend
- `docker-compose.yml` - Service orchestration

### Changing the Hostname
If deploying to a custom domain:
1. Update `LEMMY_UI_LEMMY_EXTERNAL_HOST` in `docker-compose.yml`
2. Update `hostname` in `lemmy.hjson`
3. Update API_BASE in `enhanced-frontend-with-badges.html`
4. Regenerate SSL certificates for your domain

## Badge API Endpoints

The Badge API runs on port 3001 and provides real-time badge and karma data:

### Available Endpoints
- `GET /health` - API health check (returns status and timestamp)
- `GET /api/badges` - Get all 30 available badges with icons, colors, and categories
- `GET /api/badges/user/:username` - Get earned badges for a specific user
- `GET /api/badges/stats/:username` - Get badge statistics by category
- `GET /api/badges/karma/:username` - Get karma breakdown (posts, comments, badges)
- `GET /api/badges/leaderboard` - Get top 20 users ranked by total karma
- `POST /api/badges/award` - Award a badge to a user (admin only)
- `GET /u/:username` - Badge profile display page

### Example Response
```json
// GET /api/badges/karma/testuser
{
  "username": "testuser",
  "post_upvotes": "0",
  "comment_upvotes": "0",
  "badge_bonus": "150",
  "total_karma": "150"
}
```

## Database Schema

### Database Setup
The badge system uses PostgreSQL 17 with custom tables and views. The database schema includes:

### Custom Tables
- **`badge`** - Badge definitions with 30 active badges
  - Columns: id, name, description, icon (emoji), color (hex), category, criteria, points, active, created, updated
  - Indexes: category, active status
  - Constraint: unique badge names

- **`user_badge`** - User-badge associations
  - Columns: id, person_id (FK), badge_id (FK), awarded_at, awarded_by, reason, progress
  - Indexes: person_id, badge_id, awarded_at
  - Constraint: unique (person_id, badge_id) - prevents duplicate awards

### Custom Views
- **`user_badge_details`** - Denormalized view joining users and badges
  - Returns: username, display_name, badge details, awarded_at, progress, reason
  - Used by: Badge API for user badge queries

- **`user_karma`** - Aggregated karma calculation view
  - Formula: `total_karma = sum(badge.points) + (post_count × 50) + post_upvotes + comment_upvotes`
  - Badge points range from 20 (New Recruit) to 600 (Curriculum Director)
  - Returns: username, display_name, post_count, comment_count, post_upvotes, comment_upvotes, badge_bonus, total_karma
  - Automatically updates when posts/comments/badges change

### Database Management
```bash
# Connect to PostgreSQL
docker compose exec postgres psql -U lemmy -d lemmy

# View all badges
SELECT id, name, icon, category, points FROM badge ORDER BY category;

# Check user karma
SELECT * FROM user_karma ORDER BY total_karma DESC;

# Award a badge manually
INSERT INTO user_badge (person_id, badge_id, reason)
SELECT p.id, b.id, 'Manual award'
FROM person p, badge b
WHERE p.name = 'username' AND b.name = 'Badge Name';
```

## Development

### Project Structure
```
Lemmy-haag/
├── badge-api.js                          # Badge API server
├── badge-injection-dynamic.js            # Client-side badge injection script
├── enhanced-frontend-with-badges.html    # Custom research frontend
├── docker-compose.yml                    # Service orchestration
├── Dockerfile.badge-api                  # Badge API container
├── lemmy.hjson                           # Lemmy configuration
├── nginx_alexandrite.conf                # Alexandrite proxy config
├── nginx_internal.conf                   # Standard UI proxy config
├── package.json                          # Node.js dependencies
└── volumes/
    ├── lemmy-ui/extra_themes/           # Custom CSS themes
    ├── pictrs/                           # Image storage
    └── postgres/                         # Database files
```

### Adding Custom Badges

You can add badges via SQL or the Badge API:

**Method 1: Direct SQL**
```bash
# Connect to PostgreSQL
docker compose exec postgres psql -U lemmy -d lemmy

# Insert a new badge
INSERT INTO badge (name, description, icon, color, category, criteria, points, active)
VALUES (
  'Custom Badge',
  'Detailed description of achievement',
  '🎖️',
  '#FF5733',
  'research',  -- Options: research, technology, community, special, admin, academic
  'Criteria for earning this badge',
  100,  -- Points value
  true
);

# Award the badge to a user
INSERT INTO user_badge (person_id, badge_id, reason)
SELECT p.id, b.id, 'Achievement unlocked!'
FROM person p, badge b
WHERE p.name = 'username' AND b.name = 'Custom Badge';
```

**Method 2: Badge API**
```bash
# Award an existing badge via API
curl -X POST http://localhost:3001/api/badges/award \
  -H "Content-Type: application/json" \
  -d '{
    "username": "targetuser",
    "badge_name": "Research Pioneer",
    "awarded_by": "admin",
    "reason": "Exceptional research contributions"
  }'
```

### Custom Themes

Add CSS files to `volumes/lemmy-ui/extra_themes/`:
- `darkspace.css`
- `lora-compact.css`
- `modern-enhanced.css`
- `wildlabs-inspired.css`
- And more...

## Troubleshooting

### Services won't start
```bash
# Check logs
docker compose logs

# Restart specific service
docker compose restart lemmy

# Full restart
docker compose down
docker compose up -d
```

### Database connection errors
```bash
# Verify PostgreSQL is running
docker compose ps postgres

# Check PostgreSQL logs
docker compose logs postgres
```

### Badge API not responding
```bash
# Check badge-api logs
docker compose logs badge-api

# Restart badge-api
docker compose restart badge-api
```

### Port conflicts
If ports are already in use, edit `docker-compose.yml` to change port mappings:
```yaml
ports:
  - "8081:8536"  # Change 8080 to 8081
```

## Production Deployment

For production deployment:

1. **Change all default passwords** in `docker-compose.yml` and `lemmy.hjson`
2. **Use proper SSL certificates** (Let's Encrypt, etc.)
3. **Configure proper hostname** in all configuration files
4. **Set up backups** for PostgreSQL and Pictrs volumes
5. **Configure email** settings in `lemmy.hjson`
6. **Enable monitoring** and logging
7. **Review security settings** in Nginx configs

## Contributing

This is an academic research project. Contributions are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project uses Lemmy (AGPL-3.0) and adds custom components. Please review the Lemmy license before use.

## Credits

- **Lemmy**: https://github.com/LemmyNet/lemmy
- **Alexandrite**: https://github.com/sheodox/alexandrite
- **Conservation Community**: Wildlife researchers and conservation technologists

## Support

For issues and questions:
- Open an issue on GitHub
- Check the Lemmy documentation: https://join-lemmy.org/docs/

## Research Context

This platform is part of CS8903 coursework at Georgia Tech, exploring gamification and community engagement in scientific collaboration platforms, specifically focused on conservation technology and wildlife research communities.

---

**Note**: This is a development/research project. For production use, ensure proper security hardening and configuration.
