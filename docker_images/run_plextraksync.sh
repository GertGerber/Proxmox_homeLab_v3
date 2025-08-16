#!/bin/bash
# =============================================================================
# File: plextraktsync.sh
# Created: 2025-08-11
# Description:
#   Helper script to manage PlexTraktSync Docker container via docker-compose
# =============================================================================

# --- Configuration ---
COMPOSE_FILE="/root/docker/compose/docker-compose-plextracksync-sync.yml"
COMPOSE_FILE2="/root/docker/compose/docker-compose-plextracksync-watch.yml"
WORKDIR="$(dirname "$COMPOSE_FILE")"

# --- Functions ---
start_container() {
    echo "[INFO] Starting PlexTraktSync container..."
    docker compose -f "$COMPOSE_FILE2" up -d
}

stop_container() {
    echo "[INFO] Stopping PlexTraktSync container..."
    docker compose -f "$COMPOSE_FILE2" down
}

restart_container() {
    echo "[INFO] Restarting PlexTraktSync container..."
    docker compose -f "$COMPOSE_FILE2" down
    docker compose -f "$COMPOSE_FILE2" up -d
}

view_logs() {
    echo "[INFO] Showing logs for PlexTraktSync container..."
    docker compose -f "$COMPOSE_FILE2" logs -f
}

run_sync() {
    echo "[INFO] Running PlexTraktSync 'sync'..."
    docker compose -f "$COMPOSE_FILE" run --rm plextraktsync sync
}

# --- Main ---
case "$1" in
    start)
        start_container
        ;;
    stop)
        stop_container
        ;;
    restart)
        restart_container
        ;;
    logs)
        view_logs
        ;;
    sync)
        run_sync
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|logs|sync}"
        exit 1
        ;;
esac
