#!/bin/bash


# Dr. Hamid
# Script for calculating Power Factor (PF) and Figure of Merit (ZT)
# 
# This script is free software: you can redistribute it and/or modify it 
# under the terms of the GNU General Public License as published by the 
# Free Software Foundation
# 
# This script is distributed in the hope that it will be useful, but WITHOUT 
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 




if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <trace_file>"
    exit 1
fi


file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# enter Fermi energy
read -p "Enter Fermi energy: " fermi_energy_input


if ! [[ $fermi_energy_input =~ ^-?[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?$ ]]; then
    echo "Error: Invalid input. Please enter a valid number."
    exit 1
fi


function is_near() {
    local fermi_energy_file=$1
    local fermi_energy_input=$2
    local threshold=0.001  # Adjust this threshold as needed

    
    awk -v fe_file="$fermi_energy_file" -v fe_input="$fermi_energy_input" -v threshold="$threshold" \
        'BEGIN { diff = fe_file - fe_input; if (diff < 0) diff = -diff; if (diff <= threshold) print "yes"; else print "no" }' \
    | grep -q "yes"
}


function spinner() {
    local pid=$1
    local delay=0.1
    local spin_chars='|/-\'
    while [ -d /proc/$pid ]; do
        for i in $(seq 0 3); do
            printf "\rProcessing... %s" "${spin_chars:$i:1}"
            sleep $delay
        done
    done
    printf "\rProcessing... Done!           \n"
}

# Output file
output_file="modified.trace"


{
    
    while read -r fermi_energy_file col2 col3 col4 col5 col6 col7 col8 col9 col10; do
        if is_near "$fermi_energy_file" "$fermi_energy_input"; then
            line="$fermi_energy_file $col2 $col3 $col4 $col5 $col6 $col7 $col8 $col9 $col10"
            echo "$line" >> "$output_file"
        fi
    done < "$file"
} &

spinner $!

echo "Results saved to $output_file"


echo 
echo
echo "******************************************************"
echo "*                                                    *"
echo "*                 Regards,                           *"
echo "*                 Dr. Hamid                          *"
echo "*              dftdoctor@gmail.com                   *"
echo "*                                                    *"
echo "******************************************************"
echo 