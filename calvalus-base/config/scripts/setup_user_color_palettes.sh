#!/bin/bash

echo "Copy user-defined color palettes to HDFS..."
hdfs dfs -mkdir -p /calvalus/auxiliary/cpd
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/sar.cpd /calvalus/auxiliary/cpd/
