#!/bin/bash
filelist=`upower -e | grep BAT`
energy=0
energyfull=0
while read line
do
    energy=$(echo $energy + `echo $(upower -i $line | grep energy: | awk '{print $2}')`| bc )
    energyfull=$(echo $energyfull + `echo $(upower -i $line | grep energy-full: | awk '{print $2}')`| bc )
done <<END
$filelist
END
percentage=`echo "scale=2; $energy *100 / $energyfull" | bc`
echo $percentage%
# if [[ $state = "discharging" ]]; then
#     echo "⚡$percentage%"
# elif [[ $state = "charging" ]]; then
#     echo "🔌$percentage%"
# elif [[ $state = "fully-charged" ]]; then
#     echo "🔌FULL"
# fi
