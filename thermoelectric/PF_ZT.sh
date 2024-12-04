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


if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

echo "Do you want to calculate Power Factor (PF), Figure of Merit (ZT), or both?"
read -p "Enter 'PF', 'ZT', or 'both': " calculation

if [ "$calculation" != "PF" ] && [ "$calculation" != "ZT" ] && [ "$calculation" != "both" ]; then
    echo "Invalid calculation type. Use 'PF' for Power Factor, 'ZT' for Figure of Merit, or 'both' for both calculations."
    exit 1
fi

if [ "$calculation" == "PF" ] || [ "$calculation" == "both" ]; then
    awk '{print $2, ($5*$5*$6)}' "$filename" > PF.dat
    echo "Power Factor calculation complete. Results saved in PF.dat."
fi

if [ "$calculation" == "ZT" ] || [ "$calculation" == "both" ]; then
    awk '{
        if ($8 != 0 && $8 != "") {
            print $2, ($5*$5*$6*$2/$8)
        } else {
            print $2, "NaN"
        }
    }' "$filename" > ZT.dat
    echo "ZT calculation complete. Results saved in ZT.dat."
fi

echo
echo "******************************************************"
echo "*                                                    *"
echo "*                 Regards,                           *"
echo "*                 Dr. Hamid                          *"
echo "*              dftdoctor@gmail.com                   *"
echo "*                                                    *"
echo "******************************************************"



