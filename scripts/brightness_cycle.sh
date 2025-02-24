#!/bin/bash

# Get the current brightness level
current=$(brightnessctl get)
max=$(brightnessctl max)

# Calculate the current brightness percentage
percent=$((current * 100 / max))

# Define the step size and the minimum/maximum brightness
step=10
min=20
max=100

# Calculate the next brightness level
if [ $percent -lt $min ]; then
    next=$min
elif [ $percent -ge $max ]; then
    next=$min
else
    next=$((percent + step))
fi

# Set the brightness to the calculated level
brightnessctl set "${next}%"

