#!/bin/bash

# Stop if error
set -e

# Create the FTP user if doesnt exist
if ! id "$FTP_USER" >/dev/null 2>&1; then
  echo "Creating FTP user $FTP_USER..."
  adduser --disabled-password --gecos "" "$FTP_USER"
  echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

mkdir -p /home/$FTP_USER/ftp
chown -R "$FTP_USER:$FTP_USER" /home/$FTP_USER

# Authorize the user in vsftpd’s userlist
if [ ! -f /etc/vsftpd.userlist ] || ! grep -q "^$FTP_USER$" /etc/vsftpd.userlist; then
  echo "$FTP_USER" >> /etc/vsftpd.userlist
fi

# Point vsftpd at the correct chroot (jail authenticated users into their home directory)
echo "local_root=/home/$FTP_USER/ftp" >> /etc/vsftpd.conf

exec "$@"