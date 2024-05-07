#!/bin/bash

# Path to your HTML file inside the Docker container
FILE="/usr/share/nginx/html/index.html"

# Check for red backgrounds
if grep -qiE 'background(-color)?:\s*(red|#f00|#ff0000|rgb\(255,\s*0,\s*0\));' "$FILE"; then
    echo "Red background detected!"
    exit 1
else
    echo "No red background found."
    exit 0
fi
