#!/usr/bin/env bash
set ${SET_X:+-x} -eou pipefail

print_divider -f '-' -r 80

printf '\n%s\n' "Enable podman socket"
systemctl enable podman.socket
