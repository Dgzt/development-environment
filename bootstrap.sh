#!/bin/bash

# Update the system before setting up
pacman -Syu --noconfirm --disable-download-timeout

# Convert the variables file type to unix type
pacman -S dos2unix --noconfirm --disable-download-timeout
dos2unix .variables

# Load the variables
source /home/vagrant/.variables

# Set the keyboard loayout
if [ ! -z "$KEYMAP" ]
then
    echo "Use console keymap: ${KEYMAP}"
    echo "KEYMAP=${KEYMAP}" > /etc/vconsole.conf
else
    echo "Use the default (US) kaymap."
fi

# Set the timezone
if [ ! -z "$TIMEZONE" ]
then
	echo "Set timezone to: ${TIMEZONE}"
	timedatectl set-timezone "${TIMEZONE}"
fi

# Setup the desktop environement
if [ ! -z "$DESKTOP_ENVIRONMENT" ]
then
    if [ "$DESKTOP_ENVIRONMENT" != "lxqt" ]
    then
        echo "WARNING! Invalid DESKTOP_ENVIRONMENT option: ${DESKTOP_ENVIRONMENT}"
    else
        # Use VB guest utils for X
        pacman -Rs --noconfirm virtualbox-guest-utils-nox
        pacman -S --noconfirm virtualbox-guest-utils --disable-download-timeout
        
        # Install LXQt with dependencies
        pacman -S --noconfirm xorg sddm lxqt oxygen-icons ttf-dejavu --disable-download-timeout
        
        # Start sddm at startup
        systemctl enable sddm
        
        if [ ! -z "$KEYMAP" ]
        then
            localectl --no-convert set-x11-keymap "${KEYMAP}"
        fi
    fi
fi

# Setup etckeeper
pacman -S etckeeper --noconfirm --disable-download-timeout
etckeeper init
git config --global user.email "vagrant@example.com"
git config --global user.name "Vagrant"
etckeeper commit "first commit"
systemctl enable etckeeper.timer
etckeeper commit "enable etckeeper"

# Validate the changes
reboot
