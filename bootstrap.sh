#!/bin/bash

# Convert the variables file type to unix type
pacman -S dos2unix --noconfirm
dos2unix .variables

# Load the variables
source /home/vagrant/.variables

# Set the keyboard loayout
if [ ! -z "$CONSOLE_KEYMAP" ]
then
    echo "Use console keymap: ${CONSOLE_KEYMAP}"
    echo "KEYMAP=${CONSOLE_KEYMAP}" > /etc/vconsole.conf
else
    echo "Use the default (US) kaymap."
fi

# Validate the changes
reboot
