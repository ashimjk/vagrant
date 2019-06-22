#!/bin/bash

echo "setup timezone"
sudo echo "Asia/Kathmandu" | sudo tee /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata