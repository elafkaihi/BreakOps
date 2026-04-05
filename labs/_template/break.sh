#!/bin/bash
# Inject the broken state here.
# This script runs at container start (ENTRYPOINT).
# The last line must always be: exec "$@"

# Example:
# chmod 000 /app/config.yml
# systemctl stop myservice

exec "$@"
