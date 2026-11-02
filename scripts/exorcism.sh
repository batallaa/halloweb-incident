#!/bin/bash

CSV_FILE="data/ghost_hosts.csv"

echo "=== HALLOWEB DEFENSE SYSTEM ==="

if [ ! -f "$CSV_FILE" ]; then
    echo "ERROR: No s'ha trobat $CSV_FILE"
    exit 1
fi

echo "Analitzant amenaces..."

tail -n +2 "$CSV_FILE" | while IFS=',' read -r ip hostname nivell estat port
do
    if [ "$estat" = "INFECTAT" ]; then
        case "$port" in
            22|80|443)
                echo "AMENACA CRITICA: $hostname ($ip), port $port"
                ;;
            *)
                echo "Port no critic descartat: $hostname ($port)"
                ;;
        esac
    fi
done