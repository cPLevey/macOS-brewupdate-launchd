#!/bin/sh
#
# https://github.com/cPLevey/macOS-brewupdate-launchd
#

if [ ! -e /usr/local/bin/brew ]; then 
		echo -e "[ERROR] [$(date)]: Brew installation not found.";
	else
		echo -e "Executing homebrew update @ $(date)";
			/usr/local/bin/brew update
		echo -e "Complete.\n";
fi