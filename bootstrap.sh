#!/bin/bash

# Set the keyboard loayout
# TODO move the layout to external configuration
echo "KEYMAP=hu" > /etc/vconsole.conf

# Validate the changes
reboot
