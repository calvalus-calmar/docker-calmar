#!/bin/bash

echo "Installing Calvalus on HDFS..."
hdfs dfs -mkdir -p /calvalus/software/1.0

# install calvalus-bundle
cd /build/usr/share/java/
java -jar calvalus/calvalus-distribution/cpt.jar -e --deploy calvalus/calvalus-bundle/*.jar calvalus-2.19-SNAPSHOT

# Add GDAL JNI support
hdfs dfs -copyFromLocal -f gdal.jar /calvalus/software/1.0/calvalus-2.19-SNAPSHOT

# install snap-bundle
java -jar calvalus/calvalus-distribution/cpt.jar -e --deploy calvalus/snap-bundle/snap-all.jar snap-7.0.4cv-SNAPSHOT

# add snap python support
hdfs dfs -copyFromLocal -f calvalus/snap-python/org-esa-snap-snap-python.jar /calvalus/software/1.0/snap-7.0.4cv-SNAPSHOT

# add bundle-descriptor.xml - to help register product file formats in portal
hdfs dfs -copyFromLocal -f calvalus/snap-bundle/resources/bundle-descriptor.xml /calvalus/software/1.0/snap-7.0.4cv-SNAPSHOT

# confirm copy:
hdfs dfs -ls /calvalus/software/1.0
hdfs dfs -ls /calvalus/software/1.0/calvalus-2.19-SNAPSHOT
hdfs dfs -ls /calvalus/software/1.0/snap-7.0.4cv-SNAPSHOT

echo "Finished installing Calvalus on HDFS"

