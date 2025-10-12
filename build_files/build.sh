#!/usr/bin/bash
set -euo pipefail

# /ctx/build_files/install_dnf_pkgs.sh
# /ctx/build_files/install_virtualbox.sh

handle_build_files() {
    # Complex "find" expression to numerically sort scripts like "01_packages.sh"
    mapfile -t build_files < <( find "/ctx/build_files" -maxdepth 1 -iname "*_*.sh" -type f | sort --sort=human-numeric )

    for bf in "${build_files[@]}"; do
        printf "\n[build_file] %s\n" "$(basename "$bf")"
        "$(realpath $bf)"
    done
}

handle_system_files() {
    mapfile -t system_files < <( find "/ctx/system_files" -maxdepth 1 -mindepth 1 -type d )

    for sf in "${system_files[@]}"; do
        printf "\n[system_file] %s\n" "$(basename "$sf")"
        cp -avf "${sf}" /
    done
}

handle_system_files
handle_build_files

#### Example for enabling a System Unit File

# systemctl enable podman.socket
