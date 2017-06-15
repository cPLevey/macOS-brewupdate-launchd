#!/bin/sh
#
# https://github.com/cPLevey/macOS-brewupdate-launchd
#
# Installer/Setup for macOS-brewupdate-launchd
#

# Variables
# If these are changed; the .plist file will need to be updated as well.

launchagent_dir="${HOME}/.launchd";
logging_dir="$launchagent_dir/logs";

# Check if homebrew is installed.

if [ ! -e /usr/local/bin/brew ]; then 
		printf "[ERROR] [$(date)]: Brew installation not found.\n";
	else

# Create necessary directories. 

		if [ ! -d "$launchagent_dir" ]; then 
			mkdir -p "$launchagent_dir"; 
			printf "$launchagent_dir directory created.\n";
		fi

		if [ ! -d "$logging_dir" ]; then 
			mkdir -p "$logging_dir"; 
			printf "$logging_dir directory created.\n";
		fi

# Initiate log files.

		if [ ! -f "$logging_dir/brewupdate.err" ]; then 
			printf "Initiated brewupdate.err @ $(date)\n\n" >> "$logging_dir/brewupdate.err";
			printf "Error log initiated.\n";
		fi

		if [ ! -f "$logging_dir/brewupdate.log" ]; then 
			printf "Initiated brewupdate.log @ $(date)\n\n" >> "$logging_dir/brewupdate.log"
			printf "Log file initiated.\n";
		fi

# Grab bash "cron job" and LaunchD plist file.

		printf "Grabbing the goods.\n\n";
			
			wget -nv "https://raw.githubusercontent.com/cPLevey/macOS-brewupdate-launchd/master/.launchd/brewupdate.sh" -O $launchagent_dir/brewupdate.sh;
				chmod +x $launchagent_dir/brewupdate.sh;
			
			wget -nv "https://raw.githubusercontent.com/cPLevey/macOS-brewupdate-launchd/master/.launchd/homebrew.brewupdate.plist" -O $launchagent_dir/homebrew.brewupdate.plist;

# Run job for the firt time.

		printf "Running job (without log redirect) for the first time.\n";

			/bin/sh $launchagent_dir/brewupdate.sh

# Loading LaunchAgent plist.

		launchctl load $launchagent_dir/homebrew.brewupdate.plist
		launchctl list |grep "brewupdate";

		printf "Setup completed.\n";

fi