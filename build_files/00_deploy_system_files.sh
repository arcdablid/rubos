#!/usr/bin/env bash
set ${SET_X:+-x} -eou pipefail

# ------------------------------------------------------------------------------

executor="${0##*/}"
executor_path="${BASH_SOURCE}"
while [ -L "${executor_path}" ]; do
    executor_dir="$(cd -P "$(dirname "${executor_path}")" >/dev/null 2>&1 && pwd)"
    executor_path="$(readlink "${executor_path}")"
    [[ ${executor_path} != /* ]] && executor_path="${executor_dir}/${executor_path}"
done
executor_path="$(readlink -f "${executor_path}")"
executor_dir="$(cd -P "$(dirname -- "${executor_path}")" >/dev/null 2>&1 && pwd)"

declare -a required_cmds=( "cp" "mkdir" "rm" )

fail=false
for rc in "${required_cmds[@]}"; do
    if ! command -v "${rc}" &> /dev/null ; then
        printf "[${executor}] ${BRed}ERROR${Color_Off} - '${rc}' command not available!"
        fail=true
    fi
done
[[ "${fail}" == true ]] && exit 1

# ------------------------------------------------------------------------------

print_divider -f '-' -r 80

# Copy over files
mapfile -t system_files < <( find "/ctx/system_files" -maxdepth 1 -mindepth 1 -type d )

for sf in "${system_files[@]}"; do
    printf "\n[system_file] %s\n" "$(basename "$sf")"
    cp -avf "${sf}" /
done

print_divider -f '-' -r 80

# Add rubos justfiles to ujust
printf '\n# rubos\n' | tee -a /usr/share/ublue-os/justfile > /dev/null
mapfile -t just_files < <( find "/usr/share/rubos/just" -maxdepth 1 -iname "*_*.just" -type f | sort --sort=human-numeric )
for jf in "${just_files[@]}"; do
    printf "\n[just_file] %s\n" "$(basename "$jf")"
    printf 'import %s' "${jf}" | tee -a /usr/share/ublue-os/justfile > /dev/null
done
