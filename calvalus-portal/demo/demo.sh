#!/bin/bash

echo "Initialising Calvalus portal with demo configuration"

cd scripts/

# setup tomcat user for calvalus-portal
./tomcat-config.sh

# configure calvalus-portal
./calvalus-portal-config.sh

# configure user defined color palettes and regions for calvalus-portal (in current user's home directory)
./calvalus-user-config.sh
