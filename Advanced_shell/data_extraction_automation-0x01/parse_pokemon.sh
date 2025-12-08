#!/usr/bin/env bash
INPUT="$1"
if [ -z "$INPUT" ] || [ ! -f "$INPUT" ]; then
    echo "Usage: $0 <pokemon.json>"
    exit 1
fi

name=$(jq -r '.name' "$INPUT" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
type=$(jq -r '.types[0].type.name' "$INPUT" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
height=$(jq -r '.height' "$INPUT")
weight=$(jq -r '.weight' "$INPUT")

formatted_height=$(awk "BEGIN {printf \"%.1f\", $height/10}")
formatted_weight=$(awk "BEGIN {w=$weight/10; printf \"%g\", w}")

echo "$name is of type $type, weighs ${formatted_weight}kg, and is ${formatted_height}m tall."
