#!/usr/bin/env bash



HADOOP_HOME=/usr/lib/hadoop-mapreduce/
input=/tmp/test_streaming.txt
output=/tmp/test_streaming_res

echo -e "1 2 3 4\n5\n6\n7\n8 9\n10" | hadoop fs -put -f - $input

hadoop fs -rm -r $output
hadoop  jar $HADOOP_HOME/hadoop-streaming.jar \
    -input $input \
    -output $output \
    -mapper cat \
    -reducer wc

#Check results
hadoop fs -text $output/*
