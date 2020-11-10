#!/usr/bin/env bash


# Generic goal of the whole experimentation
export goalline="Main goal for the series"
# Subgoal of this iteration
export iterationgoal="iteration notes"
#--@a Customize that foreach variations
export suffix="_var_001"
# Filename of the Style Image located in ./style
export style_imgname=sample-style.jpg
# Filename of the content source image in ./content
export content_imgname=sample-content.jpg


#################################### DO NOT EDIT UNLESS KNOWING WHAT YOU ARE DOING :) ######################################
#
# CALL OF THE WRAPPER SCRIPT
#echo  ./st_wrapper__tmp.sh "$goalline" "$suffix" "$style_imgname" "$content_imgname" "$iterationgoal" "$0"

./st_wrapper__tmp.sh "$goalline" "$suffix" "$style_imgname" "$content_imgname" "$iterationgoal" "$0"
