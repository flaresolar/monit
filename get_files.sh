#!/bin/bash
rsync -a --exclude htpasswd --exclude monitrc* --exclude monit_scrub.sh --exclude .git  /etc/monit/ .
