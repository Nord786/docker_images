#!/usr/bin/env bash

HADOOP_HOME=/usr/lib/hadoop-mapreduce/
input=/tmp/test_pyspark.txt
output=/tmp/test_pyspark_res

echo -e "1 2 3 4\n5\n2\n4\n4 3 3\n5 5 4 5 5" | hadoop fs -put -f - $input

pyspark test_pyspark.py
