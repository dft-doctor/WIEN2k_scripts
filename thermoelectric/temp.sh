#!/bin/bash

# Dr. Hamid
# Script for seperating available temperatures in .trace file
# 
# This script is free software: you can redistribute it and/or modify it 
# under the terms of the GNU General Public License as published by the 
# Free Software Foundation
# 
# This script is distributed in the hope that it will be useful, but WITHOUT 
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 


if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi


filename="$1"


if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi


read -p "Enter the Fermi energy: " fermi_energy


temp_file=$(mktemp)


awk -v fe="$fermi_energy" '{ $1 = $1 - fe; print }' "$filename" > "$temp_file"


temperatures=$(awk '$2 !~ /Ef\[Ry\]/ {print $2}' "$temp_file" | sort -ug)


all_option="All"
temperatures_with_all="$temperatures"$'\n'"$all_option"


echo "Available temperatures:"
echo "$temperatures_with_all"


read -p "Enter the temperature you want to filter on (or 'All' for all temperatures): " selected_temperature


if [ "$selected_temperature" == "$all_option" ]; then
    selected_temperature=""
fi


if [ -z "$selected_temperature" ]; then
    # Run for all temperatures
    for temp in $temperatures; do
        formatted_temperature=$(printf "%.4f" "$temp")
        output_file="${temp}.dat"
        awk -v temp="$formatted_temperature" '$2 == temp' "$temp_file" > "$output_file"
        echo "Rows with temperature $formatted_temperature saved to $output_file."
    done
else
    # Run for the selected temperature
    formatted_temperature=$(printf "%.4f" "$selected_temperature")
    output_file="${selected_temperature}.dat"
    awk -v temp="$formatted_temperature" '$2 == temp' "$temp_file" > "$output_file"
    echo "Rows with temperature $formatted_temperature saved to $output_file."
fi

# Clean up the temporary file
rm "$temp_file"

echo
echo "******************************************************"
echo "*                                                    *"
echo "*                 Regards,                           *"
echo "*                 Dr. Hamid                          *"
echo "*              dftdoctor@gmail.com                   *"
echo "*                                                    *"
echo "******************************************************"
