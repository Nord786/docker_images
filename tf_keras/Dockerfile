#docker build -t tf12_keras_murashev .

FROM gcr.io/tensorflow/tensorflow:0.12.1-devel-gpu
RUN apt-get -y update && apt-get install -y vim wget screen git subversion 
RUN pip install prettytensor h5py pillow pandas matplotlib seaborn tqdm requests scikit-image keras-tqdm pymorphy2
RUN pip install keras

#Непонятно заработает ли
#RUN pip install http://download.pytorch.org/whl/cu80/torch-0.1.12.post1-cp27-none-linux_x86_64.whl 
#RUN pip install torchvision

RUN cd /root && git clone https://github.com/osh/KerasGAN
RUN cd /root && git clone https://github.com/fchollet/deep-learning-models

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG user_id=20170
ARG username=a.murashev
#Создаем пользователя с uid аналогичным host машине
RUN useradd -ms /bin/bash --uid $user_id $username && adduser $username sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#Нужно, чтобы пути для CUDA прописались в bashrc и работали под screen
RUN env | grep LD_LIB | sed 's|^|export |' >> /home/$username/.bashrc

RUN echo "defshell -bash" > /home/$username/.screenrc 
RUN chown $username /home/$username/.screenrc

RUN cp -r /root/.jupyter /home/$username && chown -R $username /home/$username/.jupyter

USER $username
WORKDIR /home/$username

#Добавить CUDA_VISIBLE_DEVICES
RUN echo "export CUDA_VISIBLE_DEVICES=2" >> /home/$username/.bashrc
WORKDIR /WORK

CMD python -m tensorflow.models.image.mnist.convolutional
