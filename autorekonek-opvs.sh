#!/bin/bash
#opvs (Wegare)
route="$(lsof -i | grep -i stunnel | grep -i listen)" 
route2="$(route | grep -i tun0 | head -n1 | awk '{print $8}')" 
	if [[ -z $route2 ]]; then
		   (printf '3\n'; sleep 15; printf '\n') | opvs	
           exit
    elif [[ -z $route ]]; then
		   (printf '3\n'; sleep 15; printf '\n') | opvs	
           exit
	fi
