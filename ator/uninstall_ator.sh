#!/bin/bash
sudo apt-get -y remove anon 
sudo systemctl daemon-reload
sudo systemctl status anon
