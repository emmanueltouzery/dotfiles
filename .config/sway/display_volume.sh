#!/usr/bin/env bash

# unmuted=$(pactl list sinks | grep -c "Mute: yes")
unmuted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -c "Mute: yes")
if [ "$unmuted" = "0" ]
then
#    pactl list sinks | grep Volume | head -n 1 | awk '{print $5}' | sed s/%// > /tmp/wobpipe
     pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print $5}' | sed s/%// > /tmp/wobpipe
else
    echo 0 > /tmp/wobpipe
fi
