#!/bin/sh  
#============ get the file name ===========  
# Folder_A="/go/src"  
# Output_file="output.txt"  
#这里用于清空原本的输出文件，感觉 : 这个符号用处挺大，shell的学习还是要多用才是  
# : > $Output_file                                                                                                                                            
# for file_a in ${Folder_A}/*
# do  
#    temp_file=`basename $file_a`  
#    echo $temp_file >> $Output_file  
# done
#! /bin/bash


function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
          getdir $dir_or_file
        else
        echo $dir_or_file
       fi  
#	echo $dir_or_file >> $output_file
    done
}

root_dir="/go/src/github.com/DataDog/zstd"
getdir $root_dir
Output_file="output.txt"

#以下命令均不包含"."，".."目录，以及"."开头的隐藏文件，如需包含，ll 需要加上 -a参数
#当前目录下文件个数，不包含子目录
# ls -a |grep "^-"|wc -l
#当前目录下目录个数，不包含子目录
# ls -a |grep "^d"|wc -l
#当前目录下文件个数，包含子目录
# ls -a -R|grep "^-"|wc -l
#当前目录下目录个数，包含子目录
# ls -a -R|grep "^d"|wc -l