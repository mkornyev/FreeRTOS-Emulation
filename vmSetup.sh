#!/usr/bin/env bash

# DONT NEED TO INSTALL QEMU, We already have Vagrant

# echo 'Installing QEMU Utils'
# sudo apt install qemu qemu-utils qemu-kvm virt-manager libvirt-daemon-system libvirt-clients bridge-utils
# sudo apt install gnome-system-tools

echo 'Include Needed Libraries'

cp /vagrant/FreeRTOSv202012.00.zip .
cp /vagrant/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 .

echo 'Unpack Libraries'

unzip FreeRTOSv202012.00.zip
rm FreeRTOSv202012.00.zip

tar -xf gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
rm gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2

# Set up ARM 
export PATH="$HOME/gcc-arm-none-eabi-10-2020-q4-major/bin:$PATH"
arm-none-eabi-gcc --version

# OPTIONAL ARM SETUP:

# sudo ln -s ./gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc 
# sudo ln -s ./gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
# sudo ln -s ./gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb
# sudo ln -s ./gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size

# # Create Symlinks
# sudo apt install libncurses-dev
# sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
# sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5

# # Confirm Installation
# arm-none-eabi-gcc --version
# arm-none-eabi-g++ --version
# arm-none-eabi-gdb --version
# arm-none-eabi-size --version


# Compile EMULATED FreeRTOS
git clone https://github.com/FreeRTOS/FreeRTOS.git --recurse-submodules --depth 1
sudo apt-get update 
sudo apt-get install -y make qemu qemu-system-arm 
cd ./FreeRTOS/FreeRTOS/Demo/CORTEX_M3_MPS2_QEMU_GCC
make

echo 'Running the Emulation'

sudo qemu-system-arm -machine mps2-an385 -monitor null -semihosting --semihosting-config enable=on,target=native -kernel ./build/RTOSDemo.axf -serial stdio -nographic

