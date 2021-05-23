#!/usr/bin/env bash
# set -euo pipefail

disk=$(df -h -t ext4 | grep home | sed "s/  / /g" | cut -d" " -f4,5)
now=$(date +'%Y-%m-%d %H:%M')
bat_name=$(upower -e | grep 'BAT')
bat=$(upower -i $bat_name  | grep percentage | awk '{print " " $2}')
mem=$(free -h | tail -n 2 | awk '{print "\t" $3}' | tr '\n' ' ' | awk '{print $1 " " $2}')
# cpu=$(mpstat | tail -n 1 | awk '{print (100 - $12) "%"}')
cpu=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')

unmuted=$(pactl list sinks | grep "Mute: yes" | wc -l)
volume=$(pactl list sinks | grep Volume | head -n 1 | awk '{print $5}')
if [ "$unmuted" = "0" ]
then
    audio=" $volume"
else
    audio=🔇
fi

echo " $cpu%   $mem  $disk  $bat  $audio   $now"
