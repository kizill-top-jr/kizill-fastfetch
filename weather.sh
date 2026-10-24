#!/bin/bash
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/fastfetch"
CACHE="$CACHE_DIR/weather.txt"
CITY="Moscow"

mkdir -p "$CACHE_DIR"

if [[ ! -f "$CACHE" || $(( $(date +%s) - $(stat -c %Y "$CACHE") )) -gt 1800 ]]; then
    curl -4 -s --max-time 5 "https://wttr.in/${CITY}?format=%C+%t&m" > "$CACHE.tmp" \
        && mv "$CACHE.tmp" "$CACHE"
fi

if [[ ! -s "$CACHE" ]]; then
    echo "N/A"
else
    cat "$CACHE" | sed 's/  / /g'
fi
