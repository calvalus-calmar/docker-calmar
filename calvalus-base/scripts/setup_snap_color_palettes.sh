#!/bin/bash

# Copy SNAP color palettes
hdfs dfs -mkdir -p /calvalus/auxiliary/cpd
hdfs dfs -copyFromLocal -f palettes/snap_color_palettes/*.cpd /calvalus/auxiliary/cpd/
