#!/bin/bash
set -e

echo "🚀 Starting Ombre Brain (server.py) on port 8000..."
echo "🚀 Starting Ombre Gateway (gateway.py) on port 8010..."

# Start Gateway in background
python gateway.py &
GATEWAY_PID=$!

# Handle shutdown gracefully
cleanup() {
    echo "⏹️ Shutting down..."
    kill $GATEWAY_PID 2>/dev/null
    exit 0
}
trap cleanup SIGTERM SIGINT

# Start Brain in foreground (keeps container alive)
exec python server.py
