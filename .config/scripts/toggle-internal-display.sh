#!/bin/bash

# Change eDP and HDMI-1 to your actual output names
INTERNAL="eDP"
EXTERNAL="HDMI-1-0"

STATUS=$(xrandr | grep "$INTERNAL connected")

if [ -n "$STATUS" ]; then
  xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --auto
else
  xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --off
fi

