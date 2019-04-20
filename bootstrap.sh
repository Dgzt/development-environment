#!/bin/bash

# Update the system before setting up
pacman -Syu --noconfirm

# Convert the variables file type to unix type
pacman -S dos2unix --noconfirm
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

if [ ! -z "$DESKTOP_ENVIRONMENT" ]
then
    if [ "$DESKTOP_ENVIRONMENT" != "lxqt" ]
        echo "WARNING! Invalid DESKTOP_ENVIRONMENT option: ${DESKTOP_ENVIRONMENT}"
    then 
        # Use VB guest utils for X
        pacman -Rs --noconfirm virtualbox-guest-utils-nox
        pacman -S --noconfirm virtualbox-guest-utils
        
        # Install LXQt with dependencies
        pacman -S --noconfirm xorg sddm lxqt oxygen-icons
        
        # Start sddm at startup
        systemctl enable sddm
        
        if [ ! -z "$KEYMAP" ]
        then
            localectl --no-convert set-x11-keymap "${KEYMAP}"
        fi
    fi
fi

# Validate the changes
reboot
