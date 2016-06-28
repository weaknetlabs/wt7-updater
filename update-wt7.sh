#!/bin/bash
#
# WEAKERTHAN LINUX Updater Tool
# 2016 WeakNet Labs
# Douglas Berdeaux - WeakNetLabs@Gmail.com
#
# COLOR:
YELLOW='\e[33m';
GREEN='\e[32m'
WHITE='\e[97m'
RESET='\e[0m';
RED='\e[91m'
function bracket { # 0 = yellow *, 1 = green ?, 2 = red !
	if [ "$1" -eq "0" ]
	then
		printf "$WHITE[$YELLOW >$WHITE ] $RESET";
	elif [ "$1" -eq "1" ]
	then
		printf "$WHITE[ $GREEN?$WHITE ] $RESET";
	elif [ "$1" -eq "2" ]
	then
		printf "$WHITE[ $RED!$WHITE ] $RESET";
	fi
}
printf "$YELLOW\n \xe2\x9c\xaa  WEAKERTHAN LINUX Updater Tool $WHITE($GREEN";
printf "BETA$WHITE)$RESET\n\n";
bracket 0; echo "Checking update version of WT."
latest=$(curl https://weaknetlabs.com/linux/update-wt/update.php -s); # update version
uBase=$(echo $latest|sed -r 's/#.*//'); # update base
uRc=$(echo $latest|sed -r 's/[^#]+#//'); # update RC
update=0;
# should check if curl failed or not here
bracket 0; printf "Latest WT update for base$YELLOW $uBase$RESET is RC$YELLOW $uRc$RESET.\n";
bracket 0; echo "Checking local version of WT";
if [ -f "/etc/wt-version" ]
then
	bracket 0; echo "Version file found.";
	lBase=$(cat /etc/wt-version|sed -r 's/#.*//');
	lRc=$(cat /etc/wt-version|sed -r 's/[^#]+#//');
	bracket 0; printf "The local version is $YELLOW$lBase$RESET and RC is $YELLOW$lRc$RESET.\n";
	if (("$lBase" < "$uBase"))
	then
		bracket 2; printf "Your Base is lower than the newest update. Please install the latest version of WT, $YELLOW$uBase$RESET\n";
		exit 1;
	else
		# Base is equivalent, check RC
		if (("$lRc" < "uRc"))
		then
			bracket 1; printf "You can update your local version of WT from$YELLOW $lBase.$lRc$RESET to$YELLOW $lBase.$uRc$RESET. Proceed? [y/N]$GREEN "
			read updateAnswer;
			printf "$RESET";
			if [ "$updateAnswer" == "y" ];
			then
				update=1;
			fi
		else
			bracket 0; printf "You have the latest version of WT!\n"
		fi
	fi
	# get version info for local version
else
	# no update file found, create it.
	bracket 2; echo "No version file found.";
	bracket 0; echo "Creating version file /etc/wt-version";
	echo "7#1" >  /etc/wt-version
	bracket 2; echo "Done. Please re-run update tool.";
fi
if [ "$update" == "1" ];then
	bracket 0; echo "Downloading update script now."
	wget -q https://weaknetlabs.com/linux/update-wt/$uBase.$uRc.txt -O updater.sh && chmod +x updater.sh && ./updater.sh
	echo "$uBase#$uRc" > /etc/wt-version # make sure we doc the update!
fi
bracket 0; printf "Updating the desktop menu.\n";
sed -i "s/BETA 2/$uBase.$uRc/" /root/.fluxbox/menu # update the menu too!
if [ -f "/usr/local/sbin/update-wt7.sh" ];
then # already installed, say update
	bracket 0; printf "Updating ";
else
	bracket 0; printf "Installing ";
fi
printf "myself into /usr/local/sbin/\n";
cp /tmp/wt7-updater/update-wt7.sh /usr/local/sbin/
bracket 0; printf "Completed. $RESET\n\n"
