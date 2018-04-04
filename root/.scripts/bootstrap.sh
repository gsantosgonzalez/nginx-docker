#!/bin/bash

NGINX="/etc/nginx"
OVERRIDE="/shared"

CONFIG="nginx.conf"
SITES="sites"
LOGS="logs"
AVAILABLE="sites-available"
ENABLED="sites-enabled"

# Symlink sites directory
if [[ -d "$OVERRIDE/$SITES" ]]; then
    echo "Creating symlinks to available sites..."

    rm -fr "$AVAILABLE"
    ln -s "$OVERRIDE/$SITES" "$AVAILABLE"

    rm -fr "$ENABLED"
    ln -s "$OVERRIDE/$SITES" "$ENABLED"

    echo "Symlinks created"
fi

# Create logs directory
if [[ ! -d "$OVERRIDE/$LOGS" ]]; then
    echo "Creating log dir..."

    mkdir -p "$OVERRIDE/$LOGS"

    echo "Log dir created"
fi

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
    echo "Creating symlinks to custom nginx config file.."

    rm -f "$CONFIG"
    ln -s "$OVERRIDE/$CONFIG" "$CONFIG"

    echo "Symlink created"
fi

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
    echo "Creating symlinks to custom nginx config file.."

    rm -f "$CONFIG"
    ln -s "$OVERRIDE/$CONFIG" "$CONFIG"

    echo "Symlink to nginx conf created"
fi

/bin/bash /root/.scripts/fix-permissions.sh || true

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf