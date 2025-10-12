#!/usr/bin/bash
set -euo pipefail

# Use a COPR Example:
# dnf5 -y copr enable ublue-os/staging

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

declare -a dnf_pkgs=(
    "xonsh"
    "elvish"
    "nu"

    "pipx"
    "python3-pip"
    "uv" # An extremely fast Python package installer and resolver, written in Rust
    "ruff" # Extremely fast Python linter and code formatter
    "cargo"

    "util-linux"
    "aria2"
    "fzf"
    "gparted"
    "thefuck"

    # "haruna"
    # "mpv"
    # "vlc-plugin-bittorrent"
    # "vlc-plugin-ffmpeg"
    # "vlc-plugin-kde"
    # "vlc-plugin-pause-click"
    # "vlc"

    "qemu-kvm"
    "virt-manager"
    "virt-viewer"

    "nmap"
    "wireshark"
)

dnf5 install -y "${dnf_pkgs[@]}"

# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
