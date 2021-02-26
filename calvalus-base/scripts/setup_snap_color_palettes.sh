#!/bin/bash

# Copy SNAP color palettes
hdfs dfs -mkdir -p /calvalus/auxiliary/cpd
hdfs dfs -copyFromLocal -f snap_color_palettes/*.cpd /calvalus/auxiliary/cpd/
