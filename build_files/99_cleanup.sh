#!/usr/bin/env bash
set ${SET_X:+-x} -eou pipefail

printf '\n%s\n' "Starting system cleanup"

# Clean package manager cache
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

# Clean /var directory while preserving essential files
# find /var/* -maxdepth 0 -type d \! -name cache -exec rm -fr {} \;
# find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 \! -name rpm-ostree -exec rm -fr {} \;

printf '\n%s\n' "Cleanup completed"
