# Linux GRC SQRL Installer Script

This is a *Bash* script to make it easy for most Linux users to install the SQRL Windows client from GRC to run under WINE.

## Wait, what's SQRL?

Read all about it [here](https://www.grc.com/sqrl/).

## Do I have to use this Windows client? Are there any alternatives?

At the moment, the only viable alternative for Linux users is the browser extension. See the addons store for your browser. Please note that, as of writing, the extension is still missing many features supported by the Windows client.

## So, what do I do?

Just download the `sqrl-install.sh` script and place it somewhere you can run it from, such as `~/Downloads`. As with all scripts, you might have to make it executable with

```chmod a+x sqrl-install.sh```

## What will I need?

Since GRC's SQRL client is a Win32 program, you'll need *WINE* to run it. To register the `sqrl:` protocol, you'll need the *xdg-desktop-menu* tool.

The script will automatically check to see if both of these are installed. If they aren't, see the documentation for your distro for installation instructions.

The script also uses *wget* to download the latest `sqrl.exe` file from grc.com. However, if you download the file manually and put it in the same directory, it will use the existing file, so you can install an older version if need be, or avoid installing *wget*. The script will throw an error if `sqrl.exe` isn't in the current directory and *wget* isn't installed.

## So how do I run the script?

Just type `./sqrl-install.sh` from the command line or double-click the file in a file manager. (You may have to use right-click options to get it to run the file instead of opening it in a text editor; again, see the documentation for your distro.)

# Wait, that's it?

Yep! SQRL will be installed and running, and you can either create your new SQRL identity or, if you already have one, import it from another client.

# Authors

* **Shane D. Killian** - *Initial work*

See also the list of contributors who participated in this project.

# License

[CC0 Public Domain](http://creativecommons.org/publicdomain/zero/1.0/): To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
