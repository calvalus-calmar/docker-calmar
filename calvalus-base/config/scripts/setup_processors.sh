#!/bin/bash

echo "Installing demo processors to HDFS..."
hdfs dfs -mkdir -p /calvalus/software/1.0

# install processors
hdfs dfs -copyFromLocal -f processor-bundles/S1-L1-GRD-Terrain-Correction-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal -f /build/usr/share/java/calvalus/s1tbx/*.jar /calvalus/software/1.0/S1-L1-GRD-Terrain-Correction-1.0/

hdfs dfs -copyFromLocal -f processor-bundles/S1_L2_OCN_restructure_geocoding-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal -f /build/usr/share/java/calvalus/calmar/s1-l2-ocn-restructure-geocoding-0.1.0.jar /calvalus/software/1.0/S1_L2_OCN_restructure_geocoding-1.0/
