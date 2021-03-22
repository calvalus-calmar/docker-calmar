#!/bin/bash

# Copy SNAP color palettes
hdfs dfs -mkdir -p /calvalus/auxiliary/cpd
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/sar.cpd /calvalus/auxiliary/cpd/
