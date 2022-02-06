#!/bin/bash

echo "Copy user-defined color palettes to HDFS..."
hdfs dfs -mkdir -p /calvalus/auxiliary/cpd
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/gradient_grey.cpd /calvalus/auxiliary/cpd/
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/s1_sar_grd_ampitude_vh.cpd /calvalus/auxiliary/cpd/
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/s1_sar_grd_ampitude_vv.cpd /calvalus/auxiliary/cpd/
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/s1_sar_grd_intensity_vh.cpd /calvalus/auxiliary/cpd/
hdfs dfs -copyFromLocal -f palettes/user_color_palettes/s1_sar_grd_intensity_vv.cpd /calvalus/auxiliary/cpd/
