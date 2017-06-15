#!/bin/sh
#
# https://github.com/cPLevey/macOS-brewupdate-launchd
#

if [ ! -e /usr/local/bin/brew ]; then 
		printf "[ERROR] [$(date)]: Brew installation not found.\n";
	else
		printf "Executing homebrew update @ $(date)\n";
			/usr/local/bin/brew update
		printf "Complete.\n\n";
fi