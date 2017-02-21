#docker build -t tf_keras .

FROM gcr.io/tensorflow/tensorflow:0.12.1-devel-gpu
RUN apt-get -y update && apt-get install -y vim wget screen git subversion 
RUN pip install prettytensor h5py pillow pandas matplotlib seaborn tqdm requests scikit-image keras-tqdm
RUN pip install keras

RUN cd /root && git clone https://github.com/osh/KerasGAN
RUN cd /root && git clone https://github.com/fchollet/deep-learning-models

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

RUN env | grep LD_LIB | sed 's|^|export |' >> /root/.bashrc
#Нужно, чтобы пути для CUDA прописались в bashrc и работали под screen
COPY ./screenrc_docker /root/.screenrc 

#Добавить CUDA_VISIBLE_DEVICES
RUN echo "export CUDA_VISIBLE_DEVICES=2" >> /root/.bashrc

CMD python -m tensorflow.models.image.mnist.convolutional
