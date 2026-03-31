#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Rudrakshya Pani | Registration:24BCY10121
# Course: Open Source Software | Chosen Software: Linux Kernel
# Description: Checks if a package is installed, shows its
#              version/license, and prints a philosophy note
#              about the package using a case statement.
# ============================================================

# --- Define the package to inspect ---
# For Linux Kernel audit, we inspect 'linux-kernel' related tools.
# We check 'uname' availability and kernel headers as proxy packages.
# On RPM systems: kernel, kernel-headers | On DEB systems: linux-image

PACKAGE="${1:-kernel}"   # Accept package name as argument, default to 'kernel'

echo ""
echo "========================================"
echo "   FOSS Package Inspector"
echo "   Course: Open Source Software"
echo "========================================"
echo ""
echo ">> Inspecting package: $PACKAGE"
echo ""

# --- Detect package manager: RPM (Red Hat/Fedora/CentOS) or DEB (Debian/Ubuntu) ---
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    # If neither is found, warn and exit gracefully
    echo "ERROR: No supported package manager found (rpm or dpkg)."
    exit 1
fi

echo ">> Package manager detected: $PKG_MANAGER"
echo ""

# --- Check if package is installed using if-then-else ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based check: rpm -q returns exit code 0 if installed
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "[INSTALLED] $PACKAGE is present on this system."
        echo ""
        echo "--- Package Details ---"
        # rpm -qi gives full info; grep filters key fields with pipe
        rpm -qi "$PACKAGE" | grep -E 'Name|Version|Release|License|Summary|URL'
    else
        INSTALLED=false
        echo "[NOT FOUND] $PACKAGE is NOT installed via RPM."
    fi

elif [ "$PKG_MANAGER" = "dpkg" ]; then
    # DEB-based check: dpkg -l lists packages, grep searches for it
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        echo "[INSTALLED] $PACKAGE is present on this system."
        echo ""
        echo "--- Package Details ---"
        # dpkg -s shows package status; grep filters important fields
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E 'Package|Version|Architecture|Maintainer|Description'
    else
        INSTALLED=false
        echo "[NOT FOUND] $PACKAGE is NOT installed via dpkg."
    fi
fi

echo ""

# --- Special check: always show running kernel info ---
echo "--- Currently Running Kernel ---"
echo "Kernel Version : $(uname -r)"
echo "Kernel Name    : $(uname -s)"
echo "Architecture   : $(uname -m)"
echo ""

# --- Case statement: print philosophy note based on package name ---
# The case construct matches patterns against the value of $PACKAGE
echo "--- Open Source Philosophy Note ---"
case "$PACKAGE" in
    kernel | linux | linux-image* | linux-headers*)
        echo "Linux Kernel: Born from Linus Torvalds' desire for a free Unix."
        echo "GPL v2 ensures every derivative must remain open — freedom enforced by law."
        ;;
    httpd | apache2)
        echo "Apache: The web server that built the open internet, born in 1995."
        echo "Apache License allows commercial use without forcing open-source derivatives."
        ;;
    mysql | mysql-server)
        echo "MySQL: A dual-license story — free for open use, commercial for proprietary."
        echo "Owned by Oracle, it sparked the MariaDB fork to preserve community control."
        ;;
    vlc | vlc-media-player)
        echo "VLC: Built by students at École Centrale Paris who needed to stream video."
        echo "LGPL/GPL licensed — the result of academic freedom meeting open-source values."
        ;;
    firefox)
        echo "Firefox: Mozilla's answer to a corporate-dominated web browser market."
        echo "MPL 2.0 license protects the open web against closed, monopolistic alternatives."
        ;;
    git)
        echo "Git: Linus built this when BitKeeper (proprietary) revoked Linux's free access."
        echo "GPL v2 — a tool born from the very principle that software should be free."
        ;;
    python3 | python)
        echo "Python: Guided by Guido van Rossum, shaped by community PEPs and consensus."
        echo "PSF License — permissive, allowing Python to power both open and closed software."
        ;;
    libreoffice)
        echo "LibreOffice: Forked from OpenOffice.org when Oracle threatened community control."
        echo "MPL 2.0 — a lesson in how forks preserve freedom when corporations take over."
        ;;
    *)
        # Default case for any unrecognized package
        echo "$PACKAGE: An open-source tool contributing to the shared commons of software."
        echo "Check its LICENSE file to understand the freedoms it grants you."
        ;;
esac

echo ""
echo "========================================"
echo "   Inspection complete."
echo "========================================"
echo ""
