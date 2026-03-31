#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Rudrakshya Pani | Registration: 24BCY10121
# Course: Open Source Software | Chosen Software: Linux Kernel
# Description: Loops through key system directories, reports
#              permissions, ownership, and disk usage.
#              Also checks Linux Kernel-specific config paths.
# ============================================================

# --- List of important system directories to audit ---
# These are standard Linux FHS (Filesystem Hierarchy Standard) paths
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/lib/modules")

echo ""
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                   DISK AND PERMISSION AUDITOR                           ║"
echo "║              Open Source Audit — Linux Kernel Edition                   ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo ""
printf "%-20s %-15s %-10s %-10s %-10s\n" "Directory" "Permissions" "Owner" "Group" "Size"
echo "--------------------------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory exists using -d flag
    if [ -d "$DIR" ]; then

        # Extract permissions, owner, group using ls -ld and awk
        # awk '{print $1}' gets the permission string (e.g., drwxr-xr-x)
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')

        # awk '{print $3}' gets the owner username
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')

        # awk '{print $4}' gets the group name
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh calculates human-readable disk usage; 2>/dev/null suppresses errors
        # cut -f1 extracts only the size column (tab-separated output)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row using printf for aligned columns
        printf "%-20s %-15s %-10s %-10s %-10s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "$SIZE"

    else
        # Directory does not exist on this system
        printf "%-20s %-45s\n" "$DIR" "[NOT FOUND on this system]"
    fi

done

echo "--------------------------------------------------------------------------------"
echo ""

# ============================================================
# Linux Kernel-specific directory checks
# These are locations unique to the Linux Kernel's footprint
# ============================================================
echo "--- Linux Kernel Specific Path Audit ---"
echo ""

# Array of kernel-specific directories and files to check
KERNEL_PATHS=(
    "/boot"                          # Kernel images (vmlinuz), initrd, GRUB config
    "/lib/modules/$(uname -r)"       # Loadable kernel modules for running kernel
    "/proc/sys/kernel"               # Live kernel parameters (sysctl)
    "/usr/src/linux-headers-$(uname -r)" # Kernel headers (if installed)
    "/etc/sysctl.conf"               # Persistent kernel parameter config file
    "/etc/modprobe.d"                # Module loading configuration directory
)

for KPATH in "${KERNEL_PATHS[@]}"; do

    if [ -e "$KPATH" ]; then
        # -e checks for existence (works for both files and directories)
        KPERMS=$(ls -ld "$KPATH" 2>/dev/null | awk '{print $1}')
        KOWNER=$(ls -ld "$KPATH" 2>/dev/null | awk '{print $3}')
        KSIZE=$(du -sh "$KPATH" 2>/dev/null | cut -f1)
        echo "  [FOUND]   $KPATH"
        printf "            Permissions: %-15s Owner: %-10s Size: %s\n" "$KPERMS" "$KOWNER" "$KSIZE"
    else
        echo "  [MISSING] $KPATH — not present on this system"
    fi
    echo ""

done

# --- Show currently loaded kernel modules (top 10) ---
echo "--- Currently Loaded Kernel Modules (top 10) ---"
echo ""
# lsmod lists loaded modules; awk skips header line; head limits output
lsmod | awk 'NR>1 {printf "  %-30s Size: %-10s Used: %s\n", $1, $2, $3}' | head -10
echo ""

# --- Show kernel boot parameters ---
echo "--- Kernel Boot Parameters (/proc/cmdline) ---"
echo ""
# /proc/cmdline contains the command line passed to the kernel at boot
if [ -f /proc/cmdline ]; then
    echo "  $(cat /proc/cmdline)"
else
    echo "  /proc/cmdline not accessible."
fi

echo ""
echo "========================================"
echo "   Audit complete."
echo "========================================"
echo ""
