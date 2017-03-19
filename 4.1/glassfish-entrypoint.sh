#!/bin/bash
set -e

if [ "$1" = 'glassfish' ]; then
	for f in /docker-entrypoint-glassfish.d/*; do
	    case "$f" in
		*.sh)     echo "$0: running $f"; . "$f" ;;
		*.war)    echo "$0: autodeploying $f"; cp "$f" $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/;;
		*)        echo "$0750: ignoring $f" ;;
	    esac
	    echo
	done

       asadmin start-domain --verbose
fi

exec "$@"

