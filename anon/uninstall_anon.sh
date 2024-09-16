#!/bin/bash
sudo apt-get -y remove anon 
sudo systemctl unmask anon.service
sudo systemctl disable anon.service
sudo systemctl stop anon.service
sudo apt-get -y purge anon
systemctl daemon-reload
