#!/bin/bash
for ip in $(seq 2 50);
do 
        static="10.0.5."
        full=$static$ip

        if fping -c 1 -t 100 $full; 
                then echo $full >> sweep2.txt
        fi
done
