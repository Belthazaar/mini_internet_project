#!/bin/bash

set -o errexit # exit on error
set -o pipefail # catch errors in pipelines
set -o nounset # exit on undeclared variable

if (($UID != 0)); then
    echo "$0 needs to be run as root"
    exit 1
fi

printf -v startTime "$(date +'%Y-%m-%d %H:%M:%S')"

echo startTime
echo "Cleaning up old containers.."
bash ./cleanup/hard_reset.sh

echo "Waiting for all containers to be removed.."

bash ./startup.sh

echo "Waiting for all containers to start.."
sleep 30

bash ./utils/autoconfiguration/configure_as.sh

echo "waiting 60 seconds for configuration to be applied.."
sleep 60
# This seems to fix the occasional issue where the bgp messages aren't propogating properly
echo "Clearing BGP tables to confirm configuration.."
bash ./setup/bgp_clear.sh .

echo "Done!"
printf -v endTime "$(date +'%Y-%m-%d %H:%M:%S')"

echo "Start time: $startTime"
echo "End time: $endTime"
echo -en "\007" # beep
duration=$(( $(date -d "$endTime" +%s) - $(date -d "$startTime" +%s) ))
minutes=$(( duration / 60 ))
seconds=$(( duration % 60 ))
echo "Duration: $minutes minutes and $seconds seconds"
echo "Duration: $(( $(date -d "$endTime" +%s) - $(date -d "$startTime" +%s) )) seconds"