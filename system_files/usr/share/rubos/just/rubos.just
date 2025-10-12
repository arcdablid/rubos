# Install all rubos curated apps
rubos-install: rubos-install-flatpaks rubos-install-brews

# Install only Flatpaks
rubos-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Flatpaks..."
    # Read file lines without inline comments
    xargs -a <( awk -F ' # ' '{print $1}' /usr/share/rubos/flatpak/flatpaks ) flatpak --system -y install
    echo "Flatpaks installation complete."

# Install only Homebrews
rubos-install-brews:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Homebrew formulae..."
    brew bundle --file /usr/share/rubos/homebrew/brewfile
    echo "Homebrew formulae installation complete."

# Setup Ghostty terminal configuration
rubos-install-vscode-extentions:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Flatpaks..."
    # Read file lines without inline comments
    xargs -a <( awk -F ' # ' '{print $1}' /usr/share/rubos/vscode/extentions ) flatpak --system -y install
    echo "Flatpaks installation complete."

# Setup shell configurations (zsh, bash)
rubos-setup-shells:
    #!/usr/bin/env bash
    set -euo pipefail

    # Setup Bash configuration
    echo "Setting up Bash configuration..."
    cp -f "/etc/skel/.bashrc" "${HOME}/.bashrc"
    cp -f "/etc/skel/.bash_profile" "${HOME}/.bash_profile"
    cp -f "/etc/skel/.bash_logout" "${HOME}/.bash_logout"
    echo "Bash configuration complete."

    echo "Shell configurations setup complete."

# Clean up old packages and Docker/Podman images and volumes
rubos-clean:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Cleaning up system..."
    docker system prune -af
    podman system prune -af
    flatpak uninstall --unused
    rpm-ostree cleanup -bm
    # nix-collect-garbage -d
    sudo docker system prune -af
    sudo podman system prune -af
    # sudo -i nix-collect-garbage -d
