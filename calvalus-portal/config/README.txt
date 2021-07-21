To initialise calvalus-portal with the demo configuration, run this command:

  bash config.sh

The config.sh script runs these configuration scripts:

1) tomcat-config.sh
   setup tomcat user for calvalus-portal

2) calvalus-portal-config.sh
   configure calvalus-portal

3) calvalus-user-config.sh
   configure user defined color palettes and regions for calvalus-portal in
   the user's home directory

After running config.sh, you must restart the calvalus-portal container for the
changes to take effect.

If editing these scripts for a custom configuration, please copy these scripts 
to the user's home directory for editing. This is because docker-compose has 
been setup to enable file persistence within the user's home directory. You 
must also restart the calvalus-portal container after custom editing for the 
changes to take effect.

If using docker-compose, you can connect to the calvalus-portal container 
using this command:

  docker exec -it calvalus-portal bash
