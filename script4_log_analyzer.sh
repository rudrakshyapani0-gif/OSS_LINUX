#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Rudrakshya Pani | Registration: 24BCY10121
# Course: Open Source Software | Chosen Software: Linux Kernel
# Description: Reads a log file line by line, counts keyword
#              occurrences, prints matching lines, and retries
#              if the file is empty. Kernel logs are analysed
#              using /var/log/kern.log or /var/log/messages.
# Usage: ./script4_log_analyzer.sh [logfile] [keyword]
# Example: ./script4_log_analyzer.sh /var/log/kern.log error
# ============================================================

# --- Command-line arguments ---
# $1 = log file path (defaults to kernel log if not provided)
# $2 = keyword to search for (defaults to "error")

# Auto-detect default kernel log location (varies by distro)
if [ -f /var/log/kern.log ]; then
    DEFAULT_LOG="/var/log/kern.log"       # Debian/Ubuntu systems
elif [ -f /var/log/messages ]; then
    DEFAULT_LOG="/var/log/messages"       # RHEL/CentOS/Fedora systems
else
    DEFAULT_LOG="/var/log/syslog"         # Fallback generic syslog
fi

LOGFILE="${1:-$DEFAULT_LOG}"    # Use argument or auto-detected default
KEYWORD="${2:-error}"           # Default search keyword is 'error'
MAX_RETRIES=3                   # Maximum retry attempts if file is empty
COUNT=0                         # Counter for keyword matches
RETRY=0                         # Retry counter

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║             KERNEL LOG FILE ANALYZER                        ║"
echo "║         Open Source Audit — Linux Kernel Edition            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  Log File : $LOGFILE"
echo "  Keyword  : $KEYWORD"
echo ""

# --- Validate that the file exists using -f flag ---
if [ ! -f "$LOGFILE" ]; then
    echo "ERROR: Log file '$LOGFILE' not found."
    echo ""
    echo "Common kernel log locations:"
    echo "  Debian/Ubuntu : /var/log/kern.log"
    echo "  RHEL/CentOS   : /var/log/messages"
    echo "  Systemd       : use 'journalctl -k' for kernel logs"
    echo ""
    echo "Usage: $0 <logfile> [keyword]"
    exit 1
fi

# --- Do-while style retry loop if the file is empty ---
# Bash doesn't have a native do-while, so we simulate it with
# a while loop that checks the retry counter after each attempt
while true; do

    # Check if the file is empty using -s (true if file has size > 0)
    if [ ! -s "$LOGFILE" ]; then
        RETRY=$((RETRY + 1))

        # If we've exceeded max retries, exit with an error
        if [ "$RETRY" -gt "$MAX_RETRIES" ]; then
            echo "ERROR: File '$LOGFILE' is empty after $MAX_RETRIES retries. Giving up."
            exit 1
        fi

        echo "WARNING: '$LOGFILE' appears empty. Retry $RETRY of $MAX_RETRIES..."
        sleep 2    # Wait 2 seconds before retrying
        continue   # Go back to the top of the while loop
    fi

    # File has content — break out of the retry loop
    break

done

echo "  File size: $(du -sh "$LOGFILE" | cut -f1) | Lines: $(wc -l < "$LOGFILE")"
echo ""
echo "--- Scanning for keyword: '$KEYWORD' ---"
echo ""

# --- While-read loop: read file line by line ---
# IFS= preserves leading/trailing whitespace in each line
# -r flag prevents backslash interpretation
while IFS= read -r LINE; do

    # if-then: check if current line contains the keyword (case-insensitive)
    # grep -i = case insensitive | -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment counter using arithmetic expansion
    fi

done < "$LOGFILE"   # Redirect file into the while loop as input

# --- Summary output ---
echo "  Result: Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE"
echo ""

# --- Show last 5 matching lines using grep + tail ---
echo "--- Last 5 lines containing '$KEYWORD' ---"
echo ""

# grep -i = case insensitive search through the file
# tail -5 = show only the last 5 matching results
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" 2>/dev/null | tail -5)

if [ -n "$MATCHES" ]; then
    # -n checks if string is non-empty
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  No matching lines found for '$KEYWORD'."
fi

echo ""

# --- Bonus: Kernel-specific analysis ---
echo "--- Kernel Log Summary ---"
echo ""

# Count different severity levels commonly found in kernel logs
for LEVEL in "error" "warning" "critical" "info" "panic" "oops"; do
    # grep -ic = case insensitive count of matching lines
    LEVEL_COUNT=$(grep -ic "$LEVEL" "$LOGFILE" 2>/dev/null || echo "0")
    printf "  %-12s : %s occurrences\n" "$LEVEL" "$LEVEL_COUNT"
done

echo ""
echo "--- Most Recent Kernel Messages (last 5 lines) ---"
echo ""
tail -5 "$LOGFILE" | while IFS= read -r RECENT; do
    echo "  $RECENT"
done

echo ""
echo "========================================"
echo "   Log analysis complete."
echo "========================================"
echo ""
