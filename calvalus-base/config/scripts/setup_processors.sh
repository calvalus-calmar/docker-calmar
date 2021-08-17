#!/bin/bash

echo "Installing demo processors to HDFS..."
hdfs dfs -mkdir -p /calvalus/software/1.0

# install processors
hdfs dfs -copyFromLocal -f processor-bundles/S1-L1-GRD-terrain-correction-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal -f /build/usr/share/java/calvalus/s1tbx/*.jar /calvalus/software/1.0/S1-L1-GRD-terrain-correction-1.0/

hdfs dfs -copyFromLocal -f processor-bundles/S1-L2-OCN-restructure-geocoding-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal -f /build/usr/share/java/calvalus/calmar/s1-l2-ocn-restructure-geocoding-op-0.1.0.jar /calvalus/software/1.0/S1-L2-OCN-restructure-geocoding-1.0/

hdfs dfs -copyFromLocal -f processor-bundles/S1-L2-OCN-vertical-wind-shear-java-1.0 /calvalus/software/1.0
hdfs dfs -copyFromLocal -f /build/usr/share/java/calvalus/calmar/s1-l2-ocn-vertical-wind-shear-op-java-0.1.0.jar /calvalus/software/1.0/S1-L2-OCN-vertical-wind-shear-java-1.0

hdfs dfs -copyFromLocal -f processor-bundles/S1-L2-OCN-vertical-wind-shear-python-1.0 /calvalus/software/1.0/
hdfs dfs -copyFromLocal -f /build/usr/share/java/calvalus/calmar/s1-l2-ocn-vertical-wind-shear-op-python-0.1.0.jar /calvalus/software/1.0/S1-L2-OCN-vertical-wind-shear-python-1.0
