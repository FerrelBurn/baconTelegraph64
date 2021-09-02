
#!/bin/bash
#########################################################
# Created by W7SVT Nov 2020 #############################
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
sudo apt-get install -y \
asciidoctor \
libfftw3-dev \
qtdeclarative5-dev \
texinfo \
libqt5multimedia5 \
libqt5multimedia5-plugins \
qtmultimedia5-dev \
libusb-1.0.0-dev \
libqt5serialport5-dev \
asciidoc \
libudev-dev \
libboost-all-dev \
libwebsockets-dev \


echo "######################" 
echo "# Setting Temp Swap #"
echo "######################" 

sudo fallocate -l 2G /swapfile 
sudo chmod 600 /swapfile 
sudo mkswap /swapfile 
sudo swapon /swapfile

cd $HOME

echo "###########################" 
echo "# Downloading JTDX HAMLIB #"
echo "###########################" 

mkdir ~/hamlib-prefix
cd ~/hamlib-prefix
git clone git://github.com/jtdx-project/jtdxhamlib src

echo "###########################" 
echo "# Build JTDX HAMLIB from src #"
echo "###########################" 

cd src
./bootstrap
mkdir ../build
cd ../build
../src/configure --prefix=$HOME/hamlib-prefix \
 --disable-shared --enable-static --without-readline \
 --without-indi --without-cxx-binding --disable-winradio \
 CFLAGS="-g -O2 -fdata-sections -ffunction-sections" \
 LDFLAGS="-Wl,--gc-sections"
make
make install-strip
cd $HOME

echo "######################" 
echo "# Download JTDX         #"
echo "######################" 

mkdir -p ~/jtdx-prefix/build
cd ~/jtdx-prefix
git clone git://github.com/jtdx-project/jtdx src

echo "###########################" 
echo "# Build JTDX              #"
echo "###########################" 

cd ~/jtdx-prefix/build
cmake -D CMAKE_PREFIX_PATH=~/hamlib-prefix ../src
cmake --build .
sudo cmake --build . --target install

echo "######################" 
echo "# default config JTDX  #"
echo "######################" 


## get CALLSIGN

if [ -n "$CALLSIGN" ]; then
cp -f /baconTelegraph/files/JTDX.ini $HOME/.config
sed -i "s/NOCALL/$CALLSIGN/g" $HOME/.config/JTDX.ini
sed -i "s/NOGRID/$GRID" $HOME/.config/JTDX.ini
else
  echo "Please (re)run install.sh and set your GRID and CALLSIGN" \
fi


