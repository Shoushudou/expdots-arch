#!/bin/bash

echo "ExpDots Repository Final Setup"
echo "=============================="

# Copy config files to archiso directory
echo "Copying configuration files..."
cp configs/hyprland.conf archiso/airootfs/root/.config/hypr/
cp configs/waybar-config.jsonc archiso/airootfs/root/.config/waybar/config
cp configs/mako-config archiso/airootfs/root/.config/mako/config
cp configs/mpd.conf archiso/airootfs/root/.config/mpd/
cp configs/ncmpcpp-config archiso/airootfs/root/.config/ncmpcpp/config
cp configs/cava-config archiso/airootfs/root/.config/cava/config
cp configs/starship.toml archiso/airootfs/root/.config/

# Copy package list
cp packages.x86_64 archiso/

# Create a simple wallpaper
echo "Creating default wallpaper..."
convert -size 1920x1080 gradient:#1e1e2e-#cba6f7 archiso/airootfs/root/wallpaper.jpg 2>/dev/null || \
echo "Note: ImageMagick not available, skipping wallpaper creation"

echo "Setup complete! You can now:"
echo "1. Build AUR packages: ./build-aur.sh"
echo "2. Build ISO: ./build.sh"
echo "3. Test in VM: ./test-vm.sh"
