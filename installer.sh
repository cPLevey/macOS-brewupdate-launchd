#!/bin/sh
#
# https://github.com/cPLevey/macOS-brewupdate-launchd
#
# Installer/Setup for macOS-brewupdate-launchd
#

# Variables

launchagent_dir="~/.launchd";
logging_dir="$launchagent_dir/logs";

# Check if homebrew is installed.

if [ ! -e /usr/local/bin/brew ]; then 
		echo -e "[ERROR] [$(date)]: Brew installation not found.";
	else

# Create necessary directories. 

		if [ ! -d "$launchagent_dir" ]; then 
			mkdir -p "$launchagent_dir"; 
			echo -e "$launchagent_dir directory created.";
		fi

		if [ ! -d "$logging_dir" ]; then 
			mkdir -p "$logging_dir"; 
			echo -e "$logging_dir directory created.";
		fi

# Initiate log files.

		if [ ! -f "$logging_dir/brewupdate.err" ]; then 
			echo -e "Initiated brewupdate.err @ $(date)\n" >> "$logging_dir/brewupdate.err";
			echo -e "Error log initiated.";
		fi

		if [ ! -f "$logging_dir/brewupdate.log" ]; then 
			echo -e "Initiated brewupdate.log @ $(date)\n" >> "$logging_dir/brewupdate.log"
			echo -e "Log file initiated.";
		fi

# Grab bash "cron job" and LaunchD plist file.

		echo -e "Grabbing the goods.\n";
			
			wget -nv "https://raw.githubusercontent.com/cPLevey/macOS-brewupdate-launchd/master/.launchd/brewupdate.sh" -O "~/$launchagent_dir/brewupdate.sh";
			wget -nv "https://raw.githubusercontent.com/cPLevey/macOS-brewupdate-launchd/master/.launchd/homebrew.brewupdate.plist" -O "~/$launchagent_dir/homebrew.brewupdate.plist";

# Run job for the firt time.

		echo -e "Running job (without log redirect) for the first time.";

			/bin/sh ~/$launchagent_dir/brewupdate.sh

# Loading LaunchAgent plist.

		launchctl load ~/$launchagent_dir/homebrew.brewupdate.plist
			



fi