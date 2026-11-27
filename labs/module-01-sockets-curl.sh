#!/usr/bin/env bash
set -euo pipefail

LAB_DIR="/tmp/curl-lab"
mkdir -p "$LAB_DIR"
echo "Hello from Ubuntu socket lab!" > "$LAB_DIR/index.html"
echo '{"status":"ok","module":1}' > "$LAB_DIR/health.json"

python3 -m http.server 8099 --bind 127.0.0.1 --directory "$LAB_DIR" >/dev/null 2>&1 &
LAB_PID=$!
trap 'kill "$LAB_PID" 2>/dev/null || true' EXIT
sleep 1

echo "=== Listening Socket (ss) ==="
ss -tln 'sport = :8099'

echo "=== HTTP Headers (-I) ==="
curl -sI http://127.0.0.1:8099/

echo "=== Status Code Checks ==="
curl -s -o /dev/null -w "GET / -> %{http_code}\n" http://127.0.0.1:8099/
curl -s -o /dev/null -w "GET /missing -> %{http_code}\n" http://127.0.0.1:8099/missing
