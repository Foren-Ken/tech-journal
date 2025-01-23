#!/bin/bash
for ip in $(seq 2 50);
do 
        static="10.0.5."
        full=$static$ip

        if ping -c 1 -W 1 $full; 
                then echo $full > sweep1.txt
        fi
done
