#!/bin/bash

check_exist () {
local uri=$1
echo "in function uri =$uri "
[[ $uri =~ \.debian\.org ]] && [ ! $( grep "$uri" /etc/apt/sources.list >/dev/null ) ] && echo "this repository ( $uri) - valid" && return 0
echo "this repository already exists"
return 1
}

echo "creating /etc/apt/sources.list.bak"
echo "cp /etc/apt/sources.list /etc/apt/sources.list.back"

usage="example of usage  script.sh (add-rep|pick|) (stable|testing|unstable) URI (main|contrib|non-free)"

case $1 in
	add-rep)
		 case $2 in
			  stable) 
				echo "s2 stable"
				if (check_exist $3)
				then
					echo "deb $3 $2 $4"
				fi 
			  ;;
			 testing) echo "s2 testing" ;;
			unstable) echo "s2 unstable" ;;
			       *) echo "need choose  (stable|testing|unstable)"
		 esac
		;; 
	   pick) echo "pick " ;;
	      *) echo $usage
esac
