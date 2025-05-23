#!/usr/bin/env bash
# set -euo pipefail

disk=$(df -h -t btrfs | grep home | awk '{print $4}')
now=$(date +'%Y-%m-%d %H:%M')
bat_name=$(upower -e | grep 'BAT')
bat=$(upower -i $bat_name  | grep percentage | awk '{print $2}' | sed 's/%//')
if [ $bat -le 15 ]
then
bat="<span color=\"red\"><b> $bat%</b></span>"
else
bat=" $bat%"
fi
mem=$(free -h | tail -n 2 | awk '{print "\t" $3}' | tr '\n' ' ' | awk '{print $1 " " $2}')
# cpu=$(mpstat | tail -n 1 | awk '{print (100 - $12) "%"}')
# cpu=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu=$(awk '{print $1, $2, $3}' /proc/loadavg)

unmuted=$(pactl list sinks | grep "Mute: yes" | wc -l)
volume=$(pactl list sinks | grep Volume | head -n 1 | awk '{print $5}')
if [ "$unmuted" = "0" ]
then
audio=" $volume"
else
audio=🔇
fi

plugged=$(cat /sys/class/power_supply/AC*/online)
if [ "$plugged" = "1" ]
then
plug="󱐥"
else
plug="󱐤"
fi

echo " $cpu   $mem   $disk  $bat <span size='13000'>$plug</span>  $audio   $now"
