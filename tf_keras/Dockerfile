FROM gcr.io/tensorflow/tensorflow:0.12.1-devel-gpu
RUN apt-get -y update && apt-get install -y vim wget screen git subversion 
RUN pip install prettytensor h5py pillow pandas matplotlib keras seaborn tqdm
COPY ./screenrc_docker /root/.screenrc 
