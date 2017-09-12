#!/bin/bash

#Update Packages and Distribution Information
apt update
apt -y dist-upgrade
apt -y autoremove
apt clean