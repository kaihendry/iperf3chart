#!/bin/bash

# Grateful for the answers on http://stackoverflow.com/questions/34447348
shopt -s nullglob

echo \$data \<\<EOD
for j in *.json
do
	dt=$(basename "$j" .json)
	sent=$(jq '.end.sum_sent.bits_per_second / 8' < "$j")
	received=$(jq '.end.sum_received.bits_per_second / 8' < "$j")
	echo "$dt" "$sent" "$received"
done
echo EOD

cat << END
set term svg size 800,600 fname "Helvetica Neue" fsize 9 rounded dashed
set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 0.9
set xtic rotate by -45 scale 0 font ",8"
set key top left

# Convert bytes to megabytes
set format y '%.0s %cB'

plot \$data using 2:xticlabels(strftime("%H:%M %Y-%m-%d",column(1))) t 'up', '' u 3 t 'down'
END
