#!/usr/bin/env python

from pyspark import SparkConf, SparkContext
conf = SparkConf()
conf.setMaster("local")
conf.setAppName("My application")
conf.set("spark.executor.memory", "1g")
sc = SparkContext(conf = conf)

input = sc.textFile('/tmp/test_pyspark.txt').cache()
print("Total lines : ", input.count())

res = input.flatMap(lambda x: x.split()).map(lambda x: (x, 1)).reduceByKey(lambda x, y: x + y)

print(sorted(res.collect()))
