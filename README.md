
# Linux Server Administration & Bash Automation on AWS

A hands-on cloud engineering project demonstrating Linux server administration, application hosting, monitoring, and deployment automation using AWS EC2.

## Architecture

Windows PC
    |
    | SSH (key-based authentication)
    v
AWS EC2 Instance (Ubuntu Linux)
    |
    +-- UFW Firewall
    |
    +-- Nginx Reverse Proxy (Port 80)
    |       |
    |       v
    |   Flask App (Port 5000)
    |       |
    |       +-- systemd Service
    |
    +-- Bash Automation
            |
            +-- Server Monitoring (cron)
            +-- Automated Backups
            +-- Log Analysis
            +-- Application Deployment

## Technologies Used

- AWS EC2
- Ubuntu Linux
- SSH and UFW
- Nginx
- Python and Flask
- Bash scripting
- systemd
- cron
- logrotate
- Git and GitHub

## Features

### 1. Linux Server Administration
- Configured an Ubuntu server on AWS EC2.
- Implemented SSH key-based authentication.
- Configured a non-root user with sudo privileges.
- Applied firewall rules using UFW.

### 2. Application Hosting
- Hosted a Python Flask application.
- Configured systemd to manage the application.
- Used Nginx as a reverse proxy.

### 3. Server Monitoring
- Created a Bash script to monitor disk usage, memory usage, and service status.
- Scheduled monitoring using cron.
- Configured log rotation to manage log growth.

### 4. Backup Automation
- Created timestamped, compressed backups.
- Implemented retention logic to keep the five newest backups.

### 5. Log Analysis
- Developed a Bash script to summarize server status logs.
- Analyzed Nginx requests, HTTP status codes, and requesting IP addresses.

### 6. Deployment Automation
- Developed a Bash deployment script that retrieves application updates from GitHub.
- Installs required Python dependencies.
- Restarts the application using systemd.
- Performs an HTTP health check after deployment.

## Repository Structure

scripts/
- backup.sh
- deploy.sh
- log_parser.sh
- status_check.sh

configs/
- hello-service.service
- nginx-hello-service.conf
- status-log

## Application Repository

Flask application source code:
https://github.com/kabi710/hello-service

## Challenges and Lessons Learned

- Learned how SSH authentication and Linux file permissions work.
- Configured Linux services using systemd.
- Practiced troubleshooting firewall and application connectivity.
- Learned how Git and GitHub support application deployment.
- Built Bash scripts to automate repetitive administration tasks.

## Future Improvements

- Configure HTTPS using TLS certificates.
- Add automated tests to the deployment workflow.
- Implement a CI/CD pipeline using GitHub Actions.
- Add more comprehensive monitoring and alerting.
