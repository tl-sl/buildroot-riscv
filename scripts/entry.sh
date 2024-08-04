#!/bin/bash
set -e

USER="root"
PROFILE='/home/builder/.bashrc'

add_env_to_PROFILE() {
  local env_name="$1"
  local env_value="$2"
  echo "export ${1}=${2}" > $PROFILE
  echo "Added ${1} to ${PROFILE}"

}
# Run dockerd
# dockerd -s vfs &> /dev/null &

export PATH="$PATH:/opt/sophgo/host-tools/gcc/riscv64-linux-x86_64/bin"
# Setup local group, if not existing
if [ "${BUILDER_GID:-0}" -ne 0 ] && ! getent group "${BUILDER_GID:-0}"; then
  groupadd -g "${BUILDER_GID}" builder


  # Setup local user
  if [ "${BUILDER_UID:-0}" -ne 0 ]; then
    useradd -m -u "${BUILDER_UID}" -g "${BUILDER_GID}" -G sudo builder
    echo "builder ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
  fi
fi

if [ "${BUILDER_UID:-0}" -ne 0 ]; then
  # Make sure cache is accessible by builder
  chown "${BUILDER_UID}:${BUILDER_GID}" /cache
  # Make sure output is accessible by builder (if anonymous volume is used)
  chown "${BUILDER_UID}:${BUILDER_GID}" /build/output || true
  USER="builder"
  add_env_to_PROFILE "PATH" "${PATH}:/opt/sophgo/host-tools/gcc/riscv64-linux-x86_64/bin"
  echo "alias br-make='make -C /build/buildroot O=/build/output BR2_EXTERNAL=/build/buildroot-sipeed'" >> $PROFILE
fi


if CMD="$(command -v "$1")"; then
  shift
  sudo -H -u ${USER} "$CMD" "$@"
else
  echo "Command not found: $1"
  exit 1
fi
