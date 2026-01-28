# n8n Deployment

This project contains a Docker Compose setup for deploying an n8n instance with PostgreSQL database.

## Prerequisites

- Docker and Docker Compose installed
- Environment variables configured (see Configuration section)

## Configuration

Create a `.env` file in the project root with the following variables:

```env
POSTGRES_PASSWORD=your_secure_password
N8N_ENCRYPTION_KEY=your_encryption_key
WEBHOOK_URL=http://localhost:5678/
TIMEZONE=Asia/Taipei
```

## Docker Compose Commands

### Starting Services

```bash
# Start all services in detached mode (background)
docker-compose up -d

# Start all services with logs visible
docker-compose up

# Start specific service
docker-compose up -d n8n
```

### Stopping Services

```bash
# Stop all services (containers remain)
docker-compose stop

# Stop and remove all containers
docker-compose down

# Stop and remove all containers, volumes, and networks
docker-compose down -v
```

### Viewing Logs

```bash
# View logs from all services
docker-compose logs

# Follow logs in real-time
docker-compose logs -f

# View logs from specific service
docker-compose logs -f n8n

# View last 100 lines of logs
docker-compose logs --tail=100
```

### Managing Containers

```bash
# List running containers
docker-compose ps

# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart n8n

# Execute command in running container
docker-compose exec n8n /bin/sh

# View resource usage
docker-compose stats
```

### Building and Updating

```bash
# Build or rebuild services
docker-compose build

# Pull latest images
docker-compose pull

# Recreate containers with new images
docker-compose up -d --force-recreate

# Update to specific version (modify docker-compose.yml first)
docker-compose up -d --no-deps n8n
```

### Database Management

```bash
# Access PostgreSQL shell
docker-compose exec postgres psql -U n8n -d n8n

# Backup database
docker-compose exec postgres pg_dump -U n8n n8n > backup_$(date +%Y%m%d).sql

# Restore database
cat backup.sql | docker-compose exec -T postgres psql -U n8n -d n8n
```

### Maintenance

```bash
# Check service health
docker-compose ps

# Validate docker-compose.yml configuration
docker-compose config

# Remove stopped containers
docker-compose rm

# View container details
docker-compose exec n8n env
```

## Service Access

- **n8n Interface**: http://localhost:5678
- **PostgreSQL**: localhost:5432 (not exposed by default)

## Architecture

- **n8n**: Version 2.3.6, workflow automation platform
- **PostgreSQL**: Version 16, database backend
- **Network**: Bridge network (n8n-network)
- **Volumes**: 
  - `postgres_data`: PostgreSQL data persistence
  - `n8n_data`: n8n workflow and configuration data

## Troubleshooting

### Service won't start
```bash
# Check logs for errors
docker-compose logs n8n
docker-compose logs postgres

# Verify environment variables
docker-compose config
```

### Database connection issues
```bash
# Check if PostgreSQL is healthy
docker-compose ps
docker-compose exec postgres pg_isready -U n8n
```

### Reset everything
```bash
# WARNING: This will delete all data
docker-compose down -v
docker-compose up -d
```

## Additional Notes

- The services are configured with `restart: unless-stopped` for automatic recovery
- PostgreSQL includes health checks to ensure n8n waits for database readiness
- Community packages are enabled for n8n
- Timezone is configurable via environment variables
