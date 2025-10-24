#!/usr/bin/env bash
set -e

echo "╔════════════════════════════════════════╗"
echo "║        ExpDots for Arch Builder        ║"
echo "╚════════════════════════════════════════╝"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check dependencies
check_deps() {
    local deps=("mkarchiso" "sudo")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing+=("$dep")
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${RED}Error: Missing dependencies:${NC} ${missing[*]}"
        echo "Please install: sudo pacman -S archiso"
        exit 1
    fi
}

# Clean previous builds
clean_build() {
    echo -e "${YELLOW}Cleaning previous builds...${NC}"
    sudo rm -rf work out 2>/dev/null || true
}

# Build ISO
build_iso() {
    echo -e "${BLUE}Starting ISO build process...${NC}"
    
    # Copy config files to archiso directory
    echo -e "${YELLOW}Setting up configuration files...${NC}"
    cp -f packages.x86_64 archiso/
    cp -f configs/* archiso/airootfs/root/.config/
    
    # Build the ISO
    echo -e "${GREEN}Building ISO with mkarchiso...${NC}"
    sudo mkarchiso -v -w "$PWD/work" -o "$PWD/out" "$PWD/archiso"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ ISO build completed successfully!${NC}"
    else
        echo -e "${RED}✗ ISO build failed!${NC}"
        exit 1
    fi
}

# Display build info
show_info() {
    if [ -d "out" ]; then
        iso_file=$(find out -name "*.iso" -type f | head -1)
        if [ -n "$iso_file" ]; then
            echo
            echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
            echo -e "${GREEN}║             BUILD COMPLETE             ║${NC}"
            echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
            echo -e "ISO File: ${BLUE}$iso_file${NC}"
            echo -e "Size: ${YELLOW}$(du -h "$iso_file" | cut -f1)${NC}"
            echo
            echo -e "${YELLOW}To test in QEMU:${NC}"
            echo -e "qemu-system-x86_64 -cdrom \"$iso_file\" -m 4G -smp 2 -vga virtio"
            echo
            echo -e "${YELLOW}To write to USB:${NC}"
            echo -e "sudo dd if=\"$iso_file\" of=/dev/sdX bs=4M status=progress && sync"
        fi
    fi
}

# Main execution
main() {
    check_deps
    clean_build
    build_iso
    show_info
}

main "$@"
