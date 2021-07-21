#!/bin/bash

echo "Initialising Calvalus with demo configuration"

cd scripts/

# Install Calvalus to HDFS
./setup_calvalus.sh

# Copy processors to HDFS
./setup_processors.sh

# Copy SNAP color palettes to HDFS
./setup_snap_color_palettes.sh

# Copy user-defined color palettes to
./setup_user_color_palettes.sh
