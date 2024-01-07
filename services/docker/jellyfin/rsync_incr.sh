#!/bin/bash

echo "$(date --rfc-3339=seconds) - starting ${1} backup"
rsync -auv "${1}" "${2}"
echo "$(date --rfc-3339=seconds) -  finished ${1} backup"

echo

