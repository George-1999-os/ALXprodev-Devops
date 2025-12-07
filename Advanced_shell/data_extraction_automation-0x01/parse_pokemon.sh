#!/usr/bin/env bash

# Usage: ./parse_pokemon.sh <pokemon.json>

INPUT="$1"

if [ -z "$INPUT" ] || [ ! -f "$INPUT" ]; then
    echo "Usage: $0 <pokemon.json>"
    exit 1
fi

# Extract values using jq only
name=$(jq -r '.name' "$INPUT" | sed 's/.*/\u&/')            # capitalize
height=$(jq -r '.height' "$INPUT")                          # decimeters
weight=$(jq -r '.weight' "$INPUT")                          # hectograms
type=$(jq -r '.types[0].type.name' "$INPUT" | sed 's/.*/\u&/')

# Convert units:
# decimeters → meters = height/10
# hectograms → kg = weight/10
formatted_height=$(awk "BEGIN {printf \"%.1f\", $height/10}")
formatted_weight=$(awk "BEGIN {printf \"%.1f\", $weight/10}")

echo "$name is of type $type, weighs ${formatted_weight}kg, and is ${formatted_height}m tall."
