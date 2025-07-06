#!/bin/bash

# Threshold for notification (in percentage)
THRESHOLD=25

# Battery info (use appropriate battery device, e.g., BAT0)
BATTERY_INFO=$(acpi -b)
CHARGE=$(echo "$BATTERY_INFO" | grep -P -o '[0-9]+(?=%)')
STATUS=$(echo "$BATTERY_INFO" | awk '{print $3}' | tr -d ',')

# Only notify if discharging and below threshold
if [[ "$STATUS" == "Discharging" && "$CHARGE" -le "$THRESHOLD" ]]; then
  dunstify -u critical "Battery low: ${CHARGE}%"
fi

# Output battery status for polybar
echo "${CHARGE}%"

