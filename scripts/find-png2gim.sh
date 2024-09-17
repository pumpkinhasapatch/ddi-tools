#!/bin/sh
echo Converting everything in $1.
find $1 -name "*.PNG" -exec  sh -c 'x={}; wine GimConv.exe "$x" -o $(echo $(basename "$x") | sed 's/\.PNG/\.GIM/g')' \;
