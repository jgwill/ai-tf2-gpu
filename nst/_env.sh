#!/bin/bash

#ENV
export zoomFactor=4
export ext_target=jpg
export ext_ne='_ne'$zoomFactor'x'

export docker_ne_host=jgwill/neuzexport docker_ne_host=jgwill/neuz


inbasename=$(basename $cfile)
nefbname=${cfile%.*}
#echo $nefbname

export ne_file_src=$nefbname$ext_ne.png
export ne_file_target=$nefbname$ext_ne.$ext_target



