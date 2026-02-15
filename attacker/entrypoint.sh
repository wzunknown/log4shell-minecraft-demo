#!/bin/sh


DISPLAY="${DISPLAY:-:99}"
SCREEN="${XVFB_SCREEN:-1920x1080x24}"

# Start Xvfb
Xvfb "$DISPLAY" -screen 0 "$SCREEN" -nolisten tcp -ac &
XVFB_PID=$!

# Ensure Xvfb is killed on exit
cleanup() {
  kill "$XVFB_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

export DISPLAY

# Optional: wait until X is ready (avoid race conditions)
i=0
while [ $i -lt 50 ]; do
  if xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; then
    break
  fi
  i=$((i+1))
  sleep 0.1
done

exec "$@"