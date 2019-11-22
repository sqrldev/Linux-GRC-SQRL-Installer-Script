#!/bin/bash

#-----------------------------------------------------
# Linux GRC SQRL Installer Script
# 
# Shane D. Killian, author of initial work
#
# CC0 Software License:
# 
# To the extent possible under law, the author(s) have
# dedicated all copyright and related and neighboring
# rights to this software to the public domain
# worldwide.
# 
# This software is distributed without any warranty.
# 
# You should have received a copy of the CC0 Public
# Domain Dedication along with this software. If not,
# see
# http://creativecommons.org/publicdomain/zero/1.0/
#-----------------------------------------------------

# We want to start off by making sure both WINE and
# the xdg-desktop-menu tool are available.

if ! [ -x "$(command -v wine)" ]; then
	echo 'Error: sqrl.exe requires WINE, which is not installed.' >&2
	exit 127
fi

if ! [ -x "$(command -v xdg-desktop-menu)" ]; then
	echo 'Error: This script requires the xdg-desktop-menu tool, which is not installed.' >&2
	exit 127
fi

# Then, let's check the current directory for the
# sqrl.exe file. If it's not there, then we'll see
# if the wget command is installed. We'll throw an
# error if neither of these is the case; otherwise
# we'll use wget to download the latest sqrl.exe
# from grc.com.

if [ ! -f sqrl.exe ]; then
	if ! [ -x "$(command -v wget)" ]; then
	  echo 'Error: This script requires wget, which is not installed, or you can manually download sqrl.exe from grc.com and place it in the current directory.' >&2
	  exit 127
	fi
	wget https://www.grc.com/dev/sqrl.exe
	
	# Let's make sure it worked
	
	if [ ! -f sqrl.exe ]; then
	  echo 'Error: sqrl.exe could not be downloaded into the current directory. Check your permissions and network connection and try again, or download the file manually and place it in the current directory.' >&2
	  exit 1
	fi
fi

# All being well, we run the installation.

wine sqrl.exe -install >/dev/null 2>/dev/null

# There's some sort of delay between the SQRL
# installation returning control to the script
# and creating the sqrl.exe file in the destination
# directory, which can result in problems. There's
# no human interaction in the interim, so a 5-second
# delay should be plenty of time to cover it.

sleep 5

# Now let's find exactly where the installation put
# the sqrl.exe file, which will be in the GRC
# directory in Program Files. Since we don't know
# exactly where WINE is installed, we just do a
# search. It's doubtful the user would have run the
# script from more than 4 directories down from the
# home directory, so that should be a good place to
# search from.

sqrlexe=$(find ~ -mindepth 4 -name 'sqrl.exe')

# If the installation failed, then the $sqrlexe
# variable will be blank. We'll check for that and
# throw an error if it's the case.

if [ -z "$sqrlexe" ]; then
	echo 'Error: SQRL did not install correctly.' >&2
	exit 1
fi

# Everything should be good to go! We'll create the
# .desktop file in the current directory and install
# it.

echo "[Desktop Entry]" > grc-sqrl.desktop
echo "Name=SQRL" >> grc-sqrl.desktop
echo "Type=application" >> grc-sqrl.desktop
echo "Exec=wine '$sqrlexe' %u" >> grc-sqrl.desktop
echo "Categories=Internet" >> grc-sqrl.desktop
echo "Terminal=false" >> grc-sqrl.desktop
echo "MimeType=x-scheme-handler/sqrl" >> grc-sqrl.desktop
xdg-desktop-menu install grc-sqrl.desktop

# Is it possible we might want to delete
# grc-sqrl.desktop and sqrl.exe from the current
# directory when we're done? If so, this is where the
# commands would go. Otherwise, it's the end of the
# script.

#
# rm grc-sqrl.desktop >/dev/null 2>/dev/null
# rm sqrl.exe >/dev/null 2>/dev/null
#
