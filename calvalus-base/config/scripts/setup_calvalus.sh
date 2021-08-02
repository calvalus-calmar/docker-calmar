#!/bin/bash

echo "Installing Calvalus to HDFS..."
hdfs dfs -mkdir -p /calvalus/software/1.0

cd /build/usr/share/java/

# install calvalus-bundle
java -jar calvalus/calvalus-distribution/cpt.jar -e --deploy calvalus/calvalus-bundle/*.jar calvalus-2.22

# Add GDAL JNI support
hdfs dfs -copyFromLocal -f gdal.jar /calvalus/software/1.0/calvalus-2.22

# install snap-bundle
java -jar calvalus/calvalus-distribution/cpt.jar -e --deploy calvalus/snap-bundle/snap-all.jar snap-8.0.3.4cv

# install snap-python
hdfs dfs -copyFromLocal -f calvalus/snap-python/*.jar /calvalus/software/1.0/snap-8.0.3.4cv

# add snap built-in bundle descriptor
hdfs dfs -copyFromLocal -f calvalus/snap-bundle/resources/bundle-descriptor.xml /calvalus/software/1.0/snap-8.0.3.4cv

echo "Finished installing Calvalus on HDFS"
