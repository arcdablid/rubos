#!/usr/bin/bash
set -euo pipefail

printf '\n%s\n' "Starting system cleanup"

# Clean package manager cache
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

# Cleanup the entirety of `/var`.
# None of these get in the end-user system and bootc lints get super mad if anything is in there
rm -rf /var
mkdir -p /var

printf '\n%s\n' "Cleanup completed"
