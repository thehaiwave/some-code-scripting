#!/bin/bash
#@IMPORTANT: Requires 'jq' to work. See https://stedolan.github.io/jq/

declare -a indicators=("11" "21" "22" "23" "31" "32" "33" "43" "46" "48" "49" "51" "52" "53" "54" "55" "56" "61" "62" "71" "72" "81" "93")
total=0

for i in "${indicators[@]}";
	do
		filename="indicator${i}.json"
		touch "$filename"
		echo "Created file for indicator "${i}"..."

		cat "output2.json" | jq --compact-output '.features[] | select(.properties.codigo_act | startswith("'${i}'"))'  > "temp.json"	
		output=$(wc -l < temp.json)	
		total=$((total+output))
		echo "Extracted matching objects. ${output} matches..."
	
		sed '$!s/$/,/' "temp.json" > "$filename"
		echo "Added commas at end of lines..."
	
		echo '{"type": "FeatureCollection", "features": [' | cat - "$filename" > temp && mv temp "$filename" 
		echo "Added JSON type and features..."
	
		echo "]}" >> "$filename"
		echo "Done"
		echo 
	done 

echo "Total matches: ${total}"

