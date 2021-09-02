#!/bin/bash
#########################################################
# Created by W7SVT Sep 2021 #############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################
cd $HOME/

git clone https://github.com/waveshare/UPS-Power-Module
cd UPS-Power-Module
sudo ./install.sh

cd ~/UPS-Power-Module
wget https://github.com/waveshare/UPS-Power-Module/blob/master/ups_display/ina219.py
#python3 -m ups_display.ina219