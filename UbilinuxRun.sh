#!/bin/bash
sudo su
clear
echo "Setting up Edison Batmand mesh"

sudo ifconfig wlan0 down
sudo ifconfig wlan0 up

echo ".... batmand ...."
cd /
sudo ./batmand/batmand -o 500 -s 10.42.0.1 wlan0
echo ".... mesh ...."

sleep 0.5

sudo wpa_cli -iwlan0 disconnect
sudo wpa_cli -iwlan0 remove_network all
sudo wpa_cli -iwlan0 add_network
sudo wpa_cli -iwlan0 set_network 0 frequency 2412
sudo wpa_cli -iwlan0 set_network 0 mode 1
sudo wpa_cli -iwlan0 set_network 0 ssid '"CSPLMESH"'
sudo wpa_cli -iwlan0 set_network 0 auth_alg OPEN
sudo wpa_cli -iwlan0 set_network 0 key_mgmt NONE
sudo wpa_cli -iwlan0 set_network 0 scan_ssid 1
sudo wpa_cli -iwlan0 select_network 0
sudo wpa_cli -iwlan0 enable_network 0
sudo wpa_cli -iwlan0 status
sudo udhcpd wlan0

sleep 0.5

clear
echo ".... Result ...."
sudo wpa_cli -iwlan0 status
sudo ifconfig wlan0

exit

cd ros_catkin_ws/
roslaunch mavros px4.launch
