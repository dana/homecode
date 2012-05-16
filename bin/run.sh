#!/bin/sh

cd /home/dana/homecode/bin
perl graph_ping gw1 &
perl graph_ping gw2 &
perl graph_ping www &
