#!/usr/bin/env bash
set ${SET_X:+-x} -eou pipefail

# ------------------------------------------------------------------------------
# Install Teamviewer
rpm --import https://linux.teamviewer.com/pubkey/currentkey.asc
dnf5 install -y "https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm"
