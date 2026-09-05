#!/usr/bin/env bash
set -euo pipefail

# WPSD Custom Public IP Display API – One-Command Installer
# Repo: https://github.com/lim3soft/wpsd-public-ip
# Created by 9W3SPY @ Sept 2026

REPO="lim3soft/wpsd-public-ip"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/files"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "[*] Downloading installer files from GitHub..."

curl -fsSL "${BASE_URL}/publicip.php"      -o "${TMPDIR}/publicip.php"
curl -fsSL "${BASE_URL}/wpsd-public-ip-apply" -o "${TMPDIR}/wpsd-public-ip-apply"
curl -fsSL "${BASE_URL}/wpsd-public-ip-apply.service" -o "${TMPDIR}/wpsd-public-ip-apply.service"
curl -fsSL "${BASE_URL}/wpsd-public-ip-apply.timer" -o "${TMPDIR}/wpsd-public-ip-apply.timer"

echo "[*] Installing persistent API source..."
install -d -m 755 /usr/local/share/wpsd-public-ip
install -m 644 "${TMPDIR}/publicip.php" /usr/local/share/wpsd-public-ip/publicip.php
chmod 644 /usr/local/share/wpsd-public-ip/publicip.php

echo "[*] Installing apply script..."
install -m 755 "${TMPDIR}/wpsd-public-ip-apply" /usr/local/sbin/wpsd-public-ip-apply

echo "[*] Installing systemd units..."
install -m 644 "${TMPDIR}/wpsd-public-ip-apply.service" /etc/systemd/system/wpsd-public-ip-apply.service
install -m 644 "${TMPDIR}/wpsd-public-ip-apply.timer"  /etc/systemd/system/wpsd-public-ip-apply.timer

echo "[*] Reloading systemd and enabling timer..."
systemctl daemon-reload
systemctl enable --now wpsd-public-ip-apply.timer

echo "[*] Running initial apply..."
/usr/local/sbin/wpsd-public-ip-apply || true

echo "[*] Installation complete."
echo ""
echo "Health check:"
echo "  systemctl is-active wpsd-public-ip-apply.timer && grep -c 'reloadPublicIP' /var/www/dashboard/index.php && curl -s http://127.0.0.1/api/publicip.php"
echo ""
echo "Created by 9W3SPY @ Sept 2026"