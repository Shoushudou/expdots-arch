#!/usr/bin/env bash

profile_name="ExpDots"
iso_name="expdots-arch"
iso_label="EXPDOTS_$(date +%Y%m)"
iso_version="$(date +%Y.%m.%d)"
install_dir="expdots"
buildmodes=('iso')

arch="x86_64"
pacman_conf="pacman.conf"

airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')

bootstrap_tarball_compression=('zstd' '-c' '-T0' '--long' '--auto-threads=available')

iso_application="ExpDots for Arch Linux"
iso_publisher="ExpDots Project"
iso_author="ExpDots Team"
iso_description="Aesthetic Arch Linux with Hyprland and KDE Plasma"

work_dir="work"
out_dir="out"

gpg_key=""

packages=()

files=()
