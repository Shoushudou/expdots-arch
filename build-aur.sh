#!/usr/bin/env bash
set -e

echo "╔════════════════════════════════════════╗"
echo "║         ExpDots AUR Builder           ║"
echo "╚════════════════════════════════════════╝"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

AUR_DIR="aur-pkgs"
mkdir -p "$AUR_DIR"
cd "$AUR_DIR"

# Check if we have AUR packages to build
if [ ! -f "../aur-packages.txt" ]; then
    echo -e "${YELLOW}No AUR packages list found. Skipping AUR build.${NC}"
    exit 0
fi

# Install build dependencies
echo -e "${YELLOW}Installing build dependencies...${NC}"
sudo pacman -S --needed --noconfirm base-devel git > /dev/null 2>&1

# Build AUR packages
build_aur_package() {
    local pkg="$1"
    echo -e "${GREEN}Building AUR package: $pkg${NC}"
    
    if [ ! -d "$pkg" ]; then
        git clone "https://aur.archlinux.org/$pkg.git" > /dev/null 2>&1
    fi
    
    cd "$pkg"
    
    # Clean any previous builds
    rm -f *.pkg.tar.* 2>/dev/null || true
    
    # Build package
    if makepkg -s --noconfirm > /dev/null 2>&1; then
        # Copy built package to parent directory
        cp *.pkg.tar.* ../
        echo -e "${GREEN}✓ Successfully built $pkg${NC}"
    else
        echo -e "${RED}✗ Failed to build $pkg${NC}"
    fi
    
    cd ..
}

# Read and build AUR packages
while IFS= read -r pkg; do
    [ -z "$pkg" ] && continue
    [ "${pkg:0:1}" = "#" ] && continue
    
    build_aur_package "$pkg"
done < "../aur-packages.txt"

echo -e "${GREEN}✓ AUR package building completed!${NC}"
