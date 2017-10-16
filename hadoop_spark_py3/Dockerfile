FROM ubuntu:14.04 

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /workspace

RUN apt-get -y update && apt-get install -y vim wget curl git subversion sudo apt-transport-https 

RUN apt-get -y update && apt-get install -y openjdk-7-jdk

ENV PYTHON_VERSION=3.6
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \     
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install python=3.5 && \
     /opt/conda/bin/conda install ipython && \
     /opt/conda/bin/conda clean -ya 

ENV PATH="/opt/conda/bin:$PATH"
#Make anaconda default python

#Install hadoop
RUN wget https://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
RUN dpkg -i cdh5-repository_1.0_all.deb

RUN apt-get update && sudo apt-get install zookeeper-server -y
RUN apt-get update && sudo apt-get install zookeeper -y

RUN mkdir -p /var/lib/zookeeper
RUN chown -R zookeeper /var/lib/zookeeper/

RUN service zookeeper-server init
RUN service zookeeper-server start

RUN apt-get update; apt-get install -y hadoop-yarn-resourcemanager
RUN apt-get install -y hadoop-hdfs-namenode
RUN apt-get install -y hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce
RUN apt-get install -y hadoop-mapreduce-historyserver hadoop-yarn-proxyserver
RUN apt-get install -y hadoop-client

COPY test_streaming.sh .

#Install spark
RUN apt-get install -y spark-core spark-history-server spark-python
COPY test_pyspark.sh test_pyspark.py ./
