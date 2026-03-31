#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Rudrakshya Pani | Registration: 24BCY10121
# Course: Open Source Software | Chosen Software: Linux Kernel
# Description: Displays a formatted welcome screen showing
#              system identity, environment, and OSS license info.
# ============================================================

# --- Student Variables (fill these in) ---
STUDENT_NAME="Rudrakshya Pani"
REG_NUMBER="24BCY10121"
SOFTWARE_CHOICE="Linux Kernel"
SOFTWARE_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Gather System Information using command substitution $() ---
KERNEL=$(uname -r)                          # Kernel release version
KERNEL_NAME=$(uname -s)                     # Kernel name (e.g., Linux)
ARCH=$(uname -m)                            # System architecture (e.g., x86_64)
USER_NAME=$(whoami)                         # Currently logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Full date (e.g., Monday, 01 January 2025)
CURRENT_TIME=$(date '+%H:%M:%S')            # Current time in HH:MM:SS format

# --- Detect Linux Distribution ---
# /etc/os-release is a standard file present on most modern distros
if [ -f /etc/os-release ]; then
    # Source the file to get variables like NAME, VERSION
    . /etc/os-release
    DISTRO_NAME="$NAME"
    DISTRO_VERSION="$VERSION"
else
    # Fallback if os-release is not available
    DISTRO_NAME="Unknown Distribution"
    DISTRO_VERSION="N/A"
fi

# --- Hostname ---
HOST_NAME=$(hostname)   # Machine's hostname on the network

# --- Display the formatted Identity Report ---
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           THE OPEN SOURCE AUDIT — SYSTEM IDENTITY           ║"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  %-20s %-38s  ║\n" "Student:"      "$STUDENT_NAME"
printf "║  %-20s %-38s  ║\n" "Reg Number:"   "$REG_NUMBER"
printf "║  %-20s %-38s  ║\n" "Software:"     "$SOFTWARE_CHOICE"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  %-20s %-38s  ║\n" "Hostname:"     "$HOST_NAME"
printf "║  %-20s %-38s  ║\n" "Distribution:" "$DISTRO_NAME $DISTRO_VERSION"
printf "║  %-20s %-38s  ║\n" "Kernel:"       "$KERNEL_NAME $KERNEL"
printf "║  %-20s %-38s  ║\n" "Architecture:" "$ARCH"
printf "║  %-20s %-38s  ║\n" "Logged in as:" "$USER_NAME"
printf "║  %-20s %-38s  ║\n" "Home Dir:"     "$HOME_DIR"
printf "║  %-20s %-38s  ║\n" "System Uptime:" "$UPTIME"
printf "║  %-20s %-38s  ║\n" "Date:"         "$CURRENT_DATE"
printf "║  %-20s %-38s  ║\n" "Time:"         "$CURRENT_TIME"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  %-20s %-38s  ║\n" "OS License:"   "$SOFTWARE_LICENSE"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║                                                              ║"
echo "║  The Linux Kernel is free software: you can redistribute    ║"
echo "║  and/or modify it under the terms of the GNU General        ║"
echo "║  Public License v2 as published by the Free Software        ║"
echo "║  Foundation. Freedom to run, study, share, and improve.     ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
