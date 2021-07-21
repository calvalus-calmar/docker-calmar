To initialise calvalus with the demo configuration, run this command:

  bash config.sh

The config.sh script runs these configuration scripts:

1) setup_calvalus.sh
   install Calvalus on HDFS

2) setup_snap_color_palettes.sh
   copy SNAP color palettes on HDFS

3) setup_user_color_palettes.sh
   copy user-defined color palettes on HDFS

After running config.sh, you must restart Docker Hadoop for the changes to
take effect, e.g.:

  docker-compose restart

You can connect to the calvalus-base container to run these commands using
this command:

  docker run --rm -it \
  --network docker-calmar_default \
  --env-file hadoop.env \
  -v docker-calmar_calvalus_base_home:/root \
  -v ~/docker-calmar-examples:/examples \
  calvaluscalmar/calvalus-base:master \
  bash

Note1:
The '-v docker-calmar_calvalus_base_home:/root' line above enables file
persistence within the user's home directory. If editing these scripts for
a custom configuration, please copy these scripts to the user's home
directory for editing to help persistence.

Note2: The above command assumes you are mounting host directory
'docker-calmar-examples' to container directory 'examples'. If not either
remove the '-v ~/docker-calmar-examples:/examples' line, or replace with
another mount.
