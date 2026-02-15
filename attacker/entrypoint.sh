#!/bin/sh


DISPLAY="${DISPLAY:-:99}"
SCREEN="${XVFB_SCREEN:-1920x1080x24}"
VNC_PORT="${VNC_PORT:-5900}"
VNC_PASS="${VNC_PASS:-008cf12a-50e9-4b97-9963-1df11f928a99}"   # set to require a password

# Start Xvfb
Xvfb "$DISPLAY" -screen 0 "$SCREEN" -nolisten tcp -ac &
XVFB_PID=$!

export DISPLAY

# Wait for X to be ready (optional but avoids races)
i=0
while [ $i -lt 50 ]; do
  if xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; then break; fi
  i=$((i+1))
  sleep 0.5
done

# VNC auth (optional but strongly recommended)
VNC_AUTH_ARGS="-nopw"
if [ -n "$VNC_PASS" ]; then
  mkdir -p /root/.vnc
  # Create a VNC password file
  x11vnc -storepasswd "$VNC_PASS" /root/.vnc/passwd >/dev/null 2>&1
  VNC_AUTH_ARGS="-rfbauth /root/.vnc/passwd"
fi

# Start VNC server attached to the virtual display
x11vnc \
  -display "$DISPLAY" \
  -forever -shared -rfbport "$VNC_PORT" \
  $VNC_AUTH_ARGS \
  -listen 0.0.0.0 \
  -noxdamage \
  >/var/log/x11vnc.log 2>&1 &

VNC_PID=$!

cleanup() {
  kill "$VNC_PID" 2>/dev/null || true
  kill "$XVFB_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

exec "$@"