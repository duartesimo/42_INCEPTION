#!/bin/bash

# Stop if error
set -e

mkdir -p /etc/nginx/certs

# Generate certificate only once
if [ ! -f "/etc/nginx/certs/cert.pem" ] || [ ! -f "/etc/nginx/certs/key.pem" ]; then
  echo "Generating self-signed certificate for localhost..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/key.pem \
    -out /etc/nginx/certs/cert.pem \
    -subj "/C=PT/ST=Porto/L=Porto/O=42/OU=Student/CN=${DOMAIN_NAME}"
fi

# Replace script PID1 with NGINX itself, daemon off makes nginx stay in foreground PID1
exec nginx -g "daemon off;"