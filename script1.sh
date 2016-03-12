#!/bin/bash


usage="example of usage  script.sh (add-rep|pick|) (stable|testing|unstable) URI (main|contrib|non-free)"


if [ ! -f /etc/apt/sources.list.back ]
then    
        echo "creating /etc/apt/sources.list.bak"
        echo "cp /etc/apt/sources.list /etc/apt/sources.list.back"
fi


no_rep_exist () {
local uri=$1
local distribition=$2
if [[ $uri =~ http://.*\.debian\.org ]] 
then 
	if ( grep "$uri" /etc/apt/sources.list | grep -w $distribition >/dev/null ) 
	then
		echo "repository alreade exist"
	else
		echo "goog repo"
		return 0
	fi
fi
return 1
}


#body of the script

case $1 in
	add-rep) case $2 in
			  stable) 
				echo "s2 stable"
				if (no_rep_exist $3 $2)
				then
					echo "deb $3 $2 main contrib non-free"
				fi 
			  	;;
			 testing) echo "s2 testing" 
				if (no_rep_exist $3 $2)
				then
					echo "deb $3 $2 main contrib non-free"
				fi	
				;;
			unstable) echo "s2 unstable" 
				if (no_rep_exist $3 $2)
				then
					 echo "deb $3 $2 main contrib non-free"
				fi
				;;
			       *) echo "need choose  (stable|testing|unstable)"
		 esac
		;;
	   pick) echo "pick " ;;
	      *) echo $usage
esac
