#!/bin/bash
(
  flock 200

  killall -q polybar

  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output="HDMI-1-0"
  #tray_output="eDP"

  for m in $outputs; do
    if [[ $m == "HDMI-1-0" ]]; then
        tray_output=$m
    fi
  done

  # Wait for PipeWire's PulseAudio interface
  until pactl info >/dev/null 2>&1; do
    echo "Waiting for PulseAudio (via PipeWire)..."
    sleep 0.5
  done


  for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none
    if [[ $m == $tray_output ]]; then
      TRAY_POSITION=right
    fi

    polybar --reload main </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
    disown
  done
) 200>/var/tmp/polybar-launch.lock


