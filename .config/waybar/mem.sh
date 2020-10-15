#!/usr/bin/env bash
set -euo pipefail

free -h | tail -n 2 | awk {'print "\t" $3'} | tr '\n' ' ' | awk {'print $1 " " $2'}
