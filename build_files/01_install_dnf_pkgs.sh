#!/usr/bin/env bash
set ${SET_X:+-x} -eou pipefail

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Use a COPR Example:
# dnf5 -y copr enable ublue-os/staging

declare -a copr_repos=(
    "scottames/ghostty"
)
for repo in "${copr_repos[@]}"; do
    dnf5 -y copr enable "${repo}"
done

# ------------------------------------------------------------------------------
# Install system pkgs

declare -a dnf_pkgs=(

    "ghostty"

    "chezmoi" # Manage your dotfiles across multiple diverse machines | https://github.com/twpayne/chezmoi

    "starship"

    "xonsh"
    "elvish"
    "nu"
    "fish"
    "zsh"

    "pipx"
    "python3-pip"
    "uv" # An extremely fast Python package installer and resolver, written in Rust
    "ruff" # Extremely fast Python linter and code formatter
    "cargo"

    "util-linux"
    "aria2"
    "fzf"
    "thefuck"
    "bat"
    "btop"
    "direnv"
    "eza"
    "gh"
    "rclone"
    "ripgrep"
    "yq"
    "jq"
    "zoxide"
    "just"
    "ugrep" # A more powerful, ultra fast, user-friendly, compatible grep | https://github.com/Genivia/ugrep
    "cheat" # Help for various commands and their use cases
    "tealdeer" # Fetch and show tldr help pages for many CLI commands
    "nnn" # Terminal file browser | https://github.com/jarun/nnn

    "mpv"
    "vlc-plugin-bittorrent"
    "vlc-plugin-ffmpeg"
    "vlc-plugin-pause-click"
    "vlc"

    "qemu-kvm"
    "virt-manager"
    "virt-viewer"
    "virt-install"

    "podman-tui" # terminal user interface for Podman
    "podlet" # Generate Podman Quadlet files from a Podman command, compose file, or existing object.
    "podman-compose" # Run docker-compose.yml using podman
    "skopeo" # A command line utility that performs various operations on container images and image repositories | https://github.com/containers/skopeo
    "udica" # A tool for generating SELinux security policies for containers | https://github.com/containers/udica

    "ansible"

    "gparted"

    "nmap"
    "wireshark"

    "gnome-shell-theme-yaru"  # Yaru GNOME Shell Theme
    "yaru-icon-theme"         # Yaru icon theme
    "yaru-sound-theme"        # Yaru sound theme
    "yaru-theme"              # Ubuntu community theme "yaru"

    "https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm"
)

dnf5 install -y "${dnf_pkgs[@]}"

# ------------------------------------------------------------------------------
# Disable COPRs so after install they don't end up enabled on the final image:

for repo in "${COPR_REPOS[@]}"; do
    dnf5 -y copr disable "${repo}"
done

# ------------------------------------------------------------------------------
# Install Teamviewer
rpm --import https://linux.teamviewer.com/pubkey/currentkey.asc
dnf5 install -y "https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm"
