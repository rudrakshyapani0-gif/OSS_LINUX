# oss-audit-24BCY10121

# The Open Source Audit — Linux Kernel

> Capstone Project | Open Source Software (OSS NGMC Course)

---

## Student Details

| Field | Details |
|---|---|
| **Student Name** | Rudrakshya Pani |
| **Registration Number** | 24BCY10121 |
| **Course** | Open Source Software |
| **Chosen Software** | Linux Kernel |
| **License** | GNU General Public License v2 (GPL v2) |

---

## Repository Structure

```
oss-audit-24BCY10121/
│
├── script1_system_identity.sh        # System Identity Report
├── script2_package_inspector.sh      # FOSS Package Inspector
├── script3_disk_permission_auditor.sh # Disk and Permission Auditor
├── script4_log_analyzer.sh           # Log File Analyzer
├── script5_manifesto_generator.sh    # Open Source Manifesto Generator
│
└── README.md                         # This file
```

---

## About the Chosen Software — Linux Kernel

The **Linux Kernel** is the core of the Linux operating system, first created by **Linus Torvalds** in 1991 as a free, open-source alternative to MINIX and proprietary UNIX systems. It is licensed under the **GNU General Public License v2 (GPL v2)**, which guarantees every user the freedom to run, study, modify, and redistribute the software and any derivative works.

Today, the Linux Kernel powers Android smartphones, web servers, supercomputers, cloud infrastructure, and embedded devices worldwide — making it the most widely deployed piece of software in human history.

---

## Script Descriptions

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a formatted welcome screen with full system identity information. Shows the Linux distribution name, kernel version, system architecture, logged-in user, home directory, system uptime, current date and time, and a message about the GPL v2 license that covers the Linux Kernel.

**Shell Concepts Used:** Variables, `echo`, command substitution `$()`, `printf` for formatted output, sourcing `/etc/os-release` for distro detection.

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether a specified package is installed on the system, retrieves its version and license information, and prints a philosophy note about the package using a `case` statement. Supports both RPM-based (Fedora, CentOS, RHEL) and DEB-based (Ubuntu, Debian) systems. Always shows the currently running kernel version regardless of the package argument.

**Shell Concepts Used:** `if-then-else`, `case` statement, `rpm -qi` / `dpkg -s`, pipe with `grep`, command-line arguments (`$1`).

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_permission_auditor.sh`

Loops through a list of standard system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/boot`, `/lib/modules`) and reports the permissions, owner, group, and disk usage of each. Also audits Linux Kernel-specific paths such as `/boot`, `/lib/modules/$(uname -r)`, `/proc/sys/kernel`, and `/etc/sysctl.conf`. Displays the top 10 currently loaded kernel modules and kernel boot parameters.

**Shell Concepts Used:** `for` loop, arrays, `ls -ld`, `awk`, `du -sh`, `cut`, `lsmod`, conditional `-d` and `-e` directory/file checks.

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line, counts how many lines contain a specified keyword (default: `error`), and prints the last 5 matching lines. Auto-detects the kernel log file location (`/var/log/kern.log` on Debian/Ubuntu or `/var/log/messages` on RHEL/CentOS). Implements a do-while style retry loop if the log file is found to be empty, and provides a summary of common severity levels (`error`, `warning`, `critical`, `info`, `panic`, `oops`).

**Shell Concepts Used:** `while read` loop, `if-then`, counter variables, command-line arguments (`$1`, `$2`), `grep -i`, `tail`, do-while retry simulation.

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Interactively asks the user three questions about their open-source experience and values, then composes a personalised philosophy statement using their answers. Saves the manifesto to a `.txt` file named `manifesto_<username>.txt` and displays it on screen. Demonstrates input validation (re-prompting on empty input) and the alias concept via inline comments.

**Shell Concepts Used:** `read` for interactive user input, string concatenation, writing to a file with `>` and `>>`, `date` command, input validation with `while` loops, alias concept demonstrated via comments.

---

## Dependencies

| Dependency | Purpose | Check Command |
|---|---|---|
| `bash` (v4.0+) | Run all scripts | `bash --version` |
| `uname` | Kernel version info | `uname -r` |
| `rpm` or `dpkg` | Package inspection (Script 2) | `which rpm` or `which dpkg` |
| `lsmod` | List kernel modules (Script 3) | `lsmod` |
| `du`, `df` | Disk usage (Script 3) | `du --version` |
| `grep`, `awk`, `cut` | Text processing | pre-installed on all Linux distros |

> All dependencies are pre-installed on standard Linux distributions. No additional installation is required.

---

## How to Run the Scripts

### Step 1 — Clone the repository

```bash
git clone https://github.com/<your-username>/oss-audit-24BCY10048.git
cd oss-audit-24BCY10048
```

### Step 2 — Make all scripts executable

```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3 — Run each script

#### Script 1 — System Identity Report
```bash
bash script1_system_identity.sh
```

#### Script 2 — FOSS Package Inspector
```bash
# Inspect the kernel package (default)
bash script2_package_inspector.sh kernel

# Inspect other packages
bash script2_package_inspector.sh firefox
bash script2_package_inspector.sh git
bash script2_package_inspector.sh vlc
```

#### Script 3 — Disk and Permission Auditor
```bash
bash script3_disk_permission_auditor.sh
```
> Some directories (e.g., `/lib/modules`) may require `sudo` for full size reporting.

#### Script 4 — Log File Analyzer
```bash
# Default: searches for 'error' in auto-detected kernel log
bash script4_log_analyzer.sh

# Custom log file and keyword
bash script4_log_analyzer.sh /var/log/kern.log error
bash script4_log_analyzer.sh /var/log/syslog warning
```
> You may need `sudo` to read `/var/log/kern.log` or `/var/log/messages` depending on your system.

#### Script 5 — Open Source Manifesto Generator
```bash
bash script5_manifesto_generator.sh
```
> This script is interactive. Answer the three prompts when asked. Your manifesto will be saved as `manifesto_<yourusername>.txt` in the current directory.

---

## Tested On

| Distribution | Version | Package Manager |
|---|---|---|
| Ubuntu | 22.04 LTS / 24.04 LTS | `dpkg` / `apt` |
| Fedora | 38 / 39 | `rpm` / `dnf` |
| CentOS Stream | 9 | `rpm` / `dnf` |
| Debian | 12 (Bookworm) | `dpkg` / `apt` |

---

## Academic Integrity

All shell scripts and written work in this project are the original work of **Akash Dasandi (24BCY10048)**. No code has been copy-pasted without understanding. All scripts have been tested on a live Linux environment and can be explained line by line.

---

## License

This project is submitted as academic coursework for the Open Source Software course at VIT. The Linux Kernel itself is licensed under the **GNU General Public License v2 (GPL v2)** — see [https://www.gnu.org/licenses/old-licenses/gpl-2.0.html](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).

---

*Submitted via VITyarthi Portal | Open Source Software — Capstone Project*
