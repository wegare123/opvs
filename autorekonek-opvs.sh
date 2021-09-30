#!/bin/bash
#opvs (Wegare)
route="$(netstat -plantu | grep -i stunnel | grep -i listen)" 
route2="$(route | grep -i tun0 | head -n1 | awk '{print $8}')" 
	if [[ -z $route2 ]]; then
		   printf '\n' | opvs
           exit
    elif [[ -z $route ]]; then
		   printf '\n' | opvs
           exit
	fi
