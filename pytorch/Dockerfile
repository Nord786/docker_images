FROM nvidia/cuda:8.0-devel-ubuntu16.04 

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && apt-get install -y vim wget screen git subversion sudo 


RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

ENV CUDNN_VERSION 6.0.20 
RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         libcudnn6=$CUDNN_VERSION-1+cuda8.0 \             
         libcudnn6-dev=$CUDNN_VERSION-1+cuda8.0 && \
     rm -rf /var/lib/apt/lists/*


ARG user_id=20170
ARG username=a.murashev
#Создаем пользователя с uid аналогичным host машине
RUN useradd -ms /bin/bash --uid $user_id $username && adduser $username sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#Нужно, чтобы пути для CUDA прописались в bashrc и работали под screen
RUN env | grep LD_LIB | sed 's|^|export |' >> /home/$username/.bashrc

RUN echo "defshell -bash" > /home/$username/.screenrc 
RUN chown $username /home/$username/.screenrc

USER $username

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p ~/conda && \     
     rm ~/miniconda.sh && \
     ~/conda/bin/conda install conda-build && \
     ~/conda/bin/conda create -y --name pytorch-py35 python=3.5.2 numpy pyyaml scipy ipython mkl jupyter matplotlib tqdm && \
     ~/conda/bin/conda clean -ya 

ENV PATH ~/conda/envs/pytorch-py35/bin:$PATH

RUN ~/conda/bin/conda install --name pytorch-py35 -c soumith magma-cuda80 torchvision
# This must be done before pip so that requirements.txt is available
WORKDIR ~/pytorch
COPY . .

RUN TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="~/conda/bin/conda/../" \
    sudo ~/conda/envs/pytorch-py35/bin/python setup.py install

WORKDIR /WORK

RUN echo "source activate pytorch-py35" >> /home/$username/.bashrc
