#!/bin/bash
# Start Tomcat in foreground so that output goes to stdout
# Use exec so that pid is 1 and the process gets shutdown cleanly
exec /usr/local/tomcat/bin/catalina.sh run
