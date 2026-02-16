#!/usr/bin/env bash
set -euo pipefail

# Add Docker's official GPG key:
SUDO=$([ "$EUID" -eq 0 ] && echo "" || echo "sudo")

$SUDO apt update
$SUDO apt install ca-certificates curl -y
$SUDO install -m 0755 -d /etc/apt/keyrings
$SUDO curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
$SUDO chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
$SUDO tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

$SUDO apt update

$SUDO apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
