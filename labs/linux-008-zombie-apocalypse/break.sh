#!/bin/bash
# Launch the zombie factory in the background
python3 /app/zombie_factory.py &
sleep 1  # give it time to spawn zombies

exec "$@"
