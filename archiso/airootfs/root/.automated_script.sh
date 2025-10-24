#!/bin/bash

echo "ExpDots for Arch - Automated Setup"
echo "=================================="

# Set up live user
LIVE_USER="live"

# Enable essential services
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable bluetooth
systemctl enable docker

# Set up SDDM
mkdir -p /etc/sddm.conf.d

# Set fish as default shell for live user
chsh -s /usr/bin/fish "$LIVE_USER"

# Create music directory for MPD
mkdir -p "/home/$LIVE_USER/Music"
chown "$LIVE_USER:$LIVE_USER" "/home/$LIVE_USER/Music"

# Set up MPD directories
mkdir -p "/home/$LIVE_USER/.config/mpd/playlists"
chown -R "$LIVE_USER:$LIVE_USER" "/home/$LIVE_USER/.config"

# Set proper permissions for user home
chown -R "$LIVE_USER:$LIVE_USER" "/home/$LIVE_USER"

echo "ExpDots setup completed!"
