#!/bin/bash

sudo su - postgres -c 'pg_dump -f galaxy_tools.psql galaxy_tools'

sudo su - root -c "
mkdir -p /tmp/dump
mv /var/lib/pgsql/galaxy_tools.psql /tmp/dump/dump.psql
cp /home/galaxy/galaxy/config/shed_tool_conf.xml /tmp/dump
tar cvzf /tmp/dump/tar_shed_tools.tar.gz /home/galaxy/galaxy/var/shed_tools/
tar cvzf /tmp/dump/tar_conda.tar.gz /export/tool_deps/_conda"
