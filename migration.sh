# cd ~/Developer/
# git clone $1 ~/Developer/
# space=" "
# path=~/Downloads/wordpress$space$2
# cd $path

#We use parameter expansion `${dir##*\ }" to extract everything after space in directory's name
#for dir in wordpress*/ ; do mv "${dir}" "${dir##*\ }" ;done

# cd ~/Developer/
# git clone $1



repo=$1
proj=$(echo $repo| cut -d'/' -f 2)
folder=$(echo $proj| cut -d'.' -f 1)
folder=~/Developer/$1

#echo $folder
#git clone $1 ~/Developer/scripts/$folder
#php patch.php $folder

wp_version_line=$(ls -l | grep 'wp_version = ' $folder/wp-includes/version.php)
wp_version=$(echo $wp_version_line| cut -d"'" -f 2)
wp_major_version=$(echo $wp_version| cut -d"." -f 1)
wp_medium_version=$(echo $wp_version| cut -d"." -f 2)
wp_minor_version=$(echo $wp_version| cut -d"." -f 3)
echo $wp_version
echo $wp_minor_version
nextv=$wp_major_version"."$wp_medium_version".""$(($wp_minor_version + 1))"
echo $nextv

url=https://fr.wordpress.org/wordpress-$wp_version-fr_FR.zip
#wget $url
#my_json= $(curl https://api.wordpress.org/core/version-check/1.7/?version=4.7.2&locale=%22fr_FR%22)
#grep -Po '"text":.*?[^\\]",' $(curl https://api.wordpress.org/core/version-check/1.7/?version=4.7.2&locale=%22fr_FR%22)
#echo $my_json
#echo "${wp_version_line#*@}"


#!/bin/bash
function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
    echo ${temp##*|}
}

json=`curl -s -X GET https://api.wordpress.org/core/version-check/1.7/?version=${wp_version}&locale=%22fr_FR%22`
prop='download'
jsonval

