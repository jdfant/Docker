#!/bin/bash
#
# Retrieve and list (write to file) all installed plugins on remote Jenkins server
#
JENKINS_HOST=USERNAME:PASSWORD@JENKINS_URL:PORT
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' > ./Files/jenkins_plugins
