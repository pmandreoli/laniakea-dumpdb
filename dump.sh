#!/bin/bash
# Script that:
#- dump galaxy galaxy-tools db in /tmp/dump
#- create the _conda directory and shed_tool dir tarball  in /tmp/dump
#- copy the shed_tool_conf.xml file  in /tmp/dump

sudo su - postgres << BASH
pg_dump -f galaxy_tools.psql galaxy_tools;
BASH

sudo su - root << ROOT
mkdir -p /tmp/dump && chown -R galaxy:galaxy /tmp/dump ; 
mv /var/lib/pgsql/galaxy_tools.psql /tmp/dump/dump.psql &>/tmp/dump/dump.log &
cp /home/galaxy/galaxy/config/shed_tool_conf.xml /tmp/dump &>> /tmp/dump/dump.log &
tar pcvzf /tmp/dump/tar_shed_tools.tar.gz /home/galaxy/galaxy/var/shed_tools/ &>>/tmp/dump/dump.log && echo 'Shed_tool dump_package created' &
tar pcvzf /tmp/dump/tar_conda.tar.gz /export/tool_deps/_conda &>>/tmp/dump/dump.log && echo 'Conda dump_package created' & 
wait
echo "packages created"

ROOT
