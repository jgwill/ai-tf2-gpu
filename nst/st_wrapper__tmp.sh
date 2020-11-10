#!/bin/bash

# The goal of this script is to make the usual .sh I duplicate more light and this will receive the variable to be executed as such:

# ./st_wrapper__tmp.sh "$goalline" "$suffix" $style_imgname $content_imgname $iterationgoal $0
#$0 so we have the correct post-processing observable file generated


##########################################################
# UNLESS UPDATED TO A NEW ONE THIS BELLOW WONT CHANGE MUCH
#########################################################
source ./_env.sh 


export goalline="$1"
#--@a Customize that foreach variations
export suffix="$2"
export style_imgname="$3"
export content_imgname="$4"
export iterationgoal="$5"
iname=$(basename $6)
inameTMP=${iname%.*}
export iterationname="$inameTMP"

echo $goalline
echo "------------------------------"
echo "$goalline $suffix $style_imgname $content_imgname $iterationgoal $iterationname"
#exit 

# The current NST Transfer Python Script to use for the Style Transfer
# :)
export nst_script=x__style_transfer__2010251156__30_01.py
export ne_script=./ne_enhancer.sh
export interpreter_cmd=python

export style_subdir=style
export content_subdir=content
export result_subdir=result

#--@STCGoal Trying to generate output name based on the name of this script
export baseout="./$result_subdir/$iterationname"
echo $baseout
export metaresultsout=$iterationname.md
echo "## $goalline" >>$metaresultsout
echo " " >>$metaresultsout
export mdheader="|   	| Content  	|  Result 	|  Style Image 	|   	|"




# If new stuff, we commit and push them

sleep 1
git pull
git add $style_subdir/$iterationname*
git add $content_subdir/$iterationname*
git add $iterationname*
git commit . -m "add: $iterationnamet"
git push

















#---------------------------------------------------------
#----------------------START----------------------------------
#----------------------------------------------------


export result_imgname=$baseout.$suffix.jpg
echo "Result_imgname= $result_imgname"
#--@a Telling the user what we are doing.
echo $goalline
echo $iterationgoal

#--@a Fabric of the Outputs/inputs
styleimage=$style_subdir/$style_imgname
contentimage=$content_subdir/$content_imgname
resultoutfile=$result_imgname

##--@STCGoal A Markdown output with a Table we can analyze the results
#--@A Entering the analysis table for the whole script
echo "## $iterationgoal" >>$metaresultsout
echo " " >>  $metaresultsout
echo "$mdheader" >>$metaresultsout
echo "|---	|---	|---	|---	|---	|" >>$metaresultsout
export mdline='|   	 	| ![Content]('$contentimage') | ![Result image]('$resultoutfile')  	|  ![Style]('$styleimage') 	|   	|'
echo $mdline >>$metaresultsout

#--@a Making Meta File - a file just for that variation
export metafile=$resultoutfile.meta.md
echo "# $goalline" > $metafile
echo " " >>  $metafile
echo "## $iterationgoal" >>  $metafile
echo "$mdheader" >>$metafile
echo "|---	|---	|---	|---	|---	|" >>$metafile
export mdline2='|   	 	| ![Content](../'$contentimage') | ![Result image](../'$resultoutfile')  	|  ![Style](../'$styleimage') 	|   	|'
echo $mdline >>$metafile

#--@a Echoing the filename that we created
echo "Generated MD File for previewing results"
echo $metaresultsout
echo $metafile

echo "### Date Start : $(date)" >> $metaresultsout ; echo "### Date Start : $(date)" >> $metafile


# making a temp in progress image
cp util/rendering_placeholder.jpg $resultoutfile
git add $resultoutfile
git commit  $resultoutfile -m "add: rendering placeholder"
git pull
git push &

#--@a Executing the Neural Style Transfer
#DONE ALREADY
echo $interpreter_cmd $nst_script $styleimage $contentimage $resultoutfile

$interpreter_cmd $nst_script $styleimage $contentimage $resultoutfile

echo "### Date End : $(date)" >> $metaresultsout ; echo "### Date End : $(date)" >> $metafile
echo " " >> $metafile ; echo " "  >> $metaresultsout  # Blank line


#########################################################
#  Neural Resolution Enhancement (NRE)			#
#########################################################
$ne_script $resultoutfile

# inbasename=$(basename $resultoutfile)
# nefbname=${resultoutfile%.*}
# #echo $nefbname

# export ne_file_src=$nefbname$ext_ne.png
# export ne_file_target=$nefbname$ext_ne.$ext_target

# echo "### Neurally Enhanced" >> $metaresultsout ; echo "### Neurally Enhanced" >> $metafile
echo '![Neurally Enhanced]('$ne_file_target')' >> $metaresultsout ; echo '![]('$ne_file_target')'>> $metafile
cat  _tmp_ne.md>> $metafile
cat  _tmp_ne.md>> $metaresultsout

#rm _tmp_ne.md

#exit


sleep 2
git pull
git add $metaresultsout $metafile $iterationname.md
git add $result_subdir/$iterationname*
git commit . -m "add:result $iterationgoal"
git push
#--------------------END----------------------
#-------------------------------------------------------------




#### COMPLETED Message

ginol -s "$goalline just completed"

