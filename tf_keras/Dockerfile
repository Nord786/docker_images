#docker build -t tf_keras .

FROM gcr.io/tensorflow/tensorflow:0.12.1-devel-gpu
RUN apt-get -y update && apt-get install -y vim wget screen git subversion 
RUN pip install prettytensor h5py pillow pandas matplotlib seaborn tqdm
RUN pip install keras
RUN cd /root && git clone https://github.com/osh/KerasGAN

COPY ./screenrc_docker /root/.screenrc 
#Нужно, чтобы пути для CUDA прописались в bashrc и работали под screen
RUN env | grep LD_LIB | sed 's|^|export |' >> /root/.bashrc

CMD python -m tensorflow.models.image.mnist.convolutional
