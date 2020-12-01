#!/usr/bin/env bash
set -euo pipefail

swaymsg -t get_tree | jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring) + " " + .name + " - " + .app_id)' | wofi -i -I --show dmenu  | cut -d' ' -f1 | {
    read -r id name
    swaymsg "[con_id=$id]" focus
}
