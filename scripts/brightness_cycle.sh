#!/bin/bash

# Get the current brightness level
current=$(brightnessctl get)
max=$(brightnessctl max)

# Calculate the current brightness percentage
percent=$((current * 100 / max))

# Define the brightness levels to cycle through
if [ $percent -lt 20 ]; then
    brightnessctl set 20%
elif [ $percent -lt 100 ]; then
    brightnessctl set 100%
else
    brightnessctl set 20%
fi

