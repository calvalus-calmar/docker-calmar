#!/bin/bash

echo "Copy SNAP color palettes to HDFS..."
hdfs dfs -mkdir -p /calvalus/auxiliary/cpd
hdfs dfs -copyFromLocal -f palettes/snap_color_palettes/*.cpd /calvalus/auxiliary/cpd/
