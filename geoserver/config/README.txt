To initialise geoserver with the demo configuration and demo data, run this
command:

  bash config.sh

After running config.sh, you must restart the geoserver container for the
changes to take effect.

If editing these scripts for a custom configuration, please copy these scripts 
to the user's home directory for editing. This is because docker-compose has 
been setup to enable file persistence within the user's home directory. You 
must also restart the geoserver container after custom editing for the changes 
to take effect.

If using docker-compose, you can connect to the geoserver container using this 
command:

  docker exec -it geoserver bash
