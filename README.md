# 42 Inception

## Overview

Inception is a 42 project about setting up a small infrastructure with Docker.  
The goal is to run multiple isolated services that work together to host a WordPress website securely.

In this project, the setup includes:

- **NGINX** as the web server
- **WordPress** with **php-fpm**
- **MariaDB** as the database
- Docker volumes for persistent data
- a custom Docker network for container communication

## Main ideas behind the project

### Containers and processes

A container is designed to run a main process.  
If that process stops, the container exits as well.

Because of that, each service must run correctly in the foreground instead of relying on background daemons or fake commands just to keep the container alive.

This is especially important in Inception, where the containers must stay up by running their real service:
- MariaDB
- NGINX
- WordPress/ php-fpm 

### PID 1

Inside a container, the main process runs as **PID 1**.

This matters because PID 1 handles signals differently in Linux.  
If the main process is not started properly, signals such as `SIGTERM` may not be handled as expected, which can cause bad shutdown behavior.

### Networking

Each container is isolated, but Docker networking allows them to communicate safely.

In this project, the services share a custom network so that:
- NGINX can serve the website
- WordPress can talk to MariaDB
- the full stack works as one application

### NGINX

NGINX is responsible for serving the website over HTTPS.

Its configuration defines how requests are handled, which files are served, and how PHP requests are passed to php-fpm.

### MariaDB

MariaDB stores all the WordPress data, such as:
- users
- posts
- settings
- plugin information

The database must be initialized correctly and configured so WordPress can connect to it.

## What I learned

This project helped me understand:
- how Docker containers work
- why foreground processes matter
- how services communicate through networks
- how to configure NGINX, WordPress, and MariaDB together
- how to debug multi-container setups

## Conclusion

Inception is a good introduction to containerized infrastructure.  
It combines system administration, networking, Docker, and service configuration in one project, while showing how separate containers can work together as a complete web application.
