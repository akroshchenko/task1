#!/bin/bash


add_rep_usage="script.sh add-rep (stable|testing|unstable) URI "
pin_usage="script.sh pin URI 'name_package'(mya content globbing)"


no_rep_exist () {
local uri=$1
local distribition=$2
if [[ $uri =~ http://.*\.debian\.org ]] 
then 
	if ( grep "$uri" /etc/apt/sources.list | grep -w $distribition >/dev/null ) 
	then
		echo "repository alreade exist"
	else
		echo "repository $uri added"
		return 0
	fi
fi
return 1
}


#body of the script

case $1 in
	add-rep)
		if [ ! -f /etc/apt/sources.list.back ]
		then
			echo "creating /etc/apt/sources.list.back"
 	                cp /etc/apt/sources.list /etc/apt/sources.list.back
		fi
		 case $2 in
			  stable) 
				if (no_rep_exist $3 $2)
				then
					echo "### new $2 repository ###" >> /etc/apt/sources.list 
					echo "deb $3 $2 main contrib non-free" >> /etc/apt/sources.list
				fi 
			  	;;
			 testing) 
				if (no_rep_exist $3 $2)
				then
					echo "### new $2 repository ###" >> /etc/apt/sources.list
                                        echo "deb $3 $2 main contrib non-free" >> /etc/apt/sources.list
				fi	
				;;
			unstable)
				if (no_rep_exist $3 $2)
				then
					 echo "### new $2 repository ###" >> /etc/apt/sources.list
                                         echo "deb $3 $2 main contrib non-free" >> /etc/apt/sources.list
				fi
				;;
			       *) echo $add_rep_usage
		 esac
		;;
	   pin)
		if [ ! -f /etc/apt/preferences ]
		then 
			touch /etc/apt/preferences
		else
			echo "creating /etc/apt/preferences.back"
			cp /etc/apt/preferences /etc/apt/preferences.back
		fi
		
		printf "Package: %s \nPin origin \"%s\"\nPin-Priority: 1001\n\n" $3 "$2" >> /etc/apt/preferences
		 ;;
	      *) echo "varient of usage"
		 echo $add_rep_usage
		 echo $pin_usage

esac
