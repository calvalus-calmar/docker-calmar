#!/bin/bash

echo "Installing demo processors to HDFS..."
hdfs dfs -mkdir -p /calvalus/software/1.0

# install processors
hdfs dfs -copyFromLocal processor-bundles/S1-L1-GRD-Terrain-Correction-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal /build/usr/share/java/calvalus/s1tbx/*.jar /calvalus/software/1.0/S1-L1-GRD-Terrain-Correction-1.0/

hdfs dfs -copyFromLocal processor-bundles/S1-L2-OCN-preprocess-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal /build/usr/share/java/calvalus/calmar/calmar-ocean-wind-energy-op-0.1.0-SNAPSHOT.jar /calvalus/software/1.0/S1-L2-OCN-preprocess-1.0/
