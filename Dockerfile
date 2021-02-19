ARG CUDAVER=whatever
ARG CUDNNVER=whatever
FROM nvidia/cuda:$CUDAVER-cudnn$CUDNNVER-devel-ubuntu18.04
ARG TFVER
ARG CUDAVER
ARG CUDNNVER

MAINTAINER Aaron Cody <aaron@aaroncody.com>

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apt-utils wget tree git

# Install dev tools
RUN apt-get install -y build-essential

# Install pip3
RUN apt install -y python3-pip
RUN pip3 install --upgrade pip

# Set up SSH
RUN mkdir /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/id_rsa.pub
ADD config /root/.ssh/config
ADD authorized_keys /root/.ssh/authorized_keys

RUN chmod 700 ~/.ssh
RUN chmod 644 ~/.ssh/authorized_keys
RUN chmod 644 ~/.ssh/config
RUN chmod 600 ~/.ssh/id_rsa
RUN chmod 644 ~/.ssh/id_rsa.pub

# Install Go
RUN wget https://dl.google.com/go/go1.16.linux-amd64.tar.gz
RUN tar -xvf go1.16.linux-amd64.tar.gz -C /usr/local
RUN echo "export GOROOT=/usr/local/go" >> /root/.bashrc
RUN echo "export GOPATH=/root/go" >> /root/.bashrc
RUN echo "export PATH=/root/go/bin:/usr/local/go/bin:$PATH" >> /root/.bashrc
ENV GOROOT="/usr/local/go"
ENV GOPATH="$USER/go"
ENV PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

# Python dependencies
RUN link /usr/bin/python3 /usr/bin/python
RUN pip3 install numpy
RUN pip3 install keras_applications --no-deps
RUN pip3 install keras_preprocessing --no-deps
RUN pip3 install h5py

# Install Baselisk
RUN go get github.com/bazelbuild/bazelisk
RUN mv `which bazelisk` /usr/local/bin/bazel

# Get TF sources
RUN git clone --depth 1 --branch $TFVER git@github.com:tensorflow/tensorflow.git

# Set env vars for configure
ENV TF_CUDA_VERSION=$CUDAVER
ENV TF_CUDNN_VERSION=$CUDNNVER
ENV PYTHON_BIN_PATH=/usr/bin/python
ENV PYTHON_LIB_PATH=/usr/local/lib/python3.6/dist-packages
ENV CUDA_TOOLKIT_PATH="/usr/local/cuda-$CUDAVER"
ENV CUDNN_INSTALL_PATH=/usr
ENV TF_NEED_ROCM=0
ENV TF_NEED_GCP=0
ENV TF_NEED_CUDA=1
ENV TF_CUDA_COMPUTE_CAPABILITIES=7.5,6.1
ENV TF_NEED_HDFS=0
ENV TF_NEED_OPENCL=0
ENV TF_NEED_JEMALLOC=1
ENV TF_ENABLE_XLA=0
ENV TF_NEED_VERBS=0
ENV TF_CUDA_CLANG=0
ENV TF_NEED_MKL=0
ENV TF_DOWNLOAD_MKL=0
ENV TF_NEED_AWS=0
ENV TF_NEED_MPI=0
ENV TF_NEED_GDR=0
ENV TF_NEED_S3=0
ENV TF_NEED_OPENCL_SYCL=0
ENV TF_SET_ANDROID_WORKSPACE=0
ENV TF_NEED_COMPUTECPP=0
ENV GCC_HOST_COMPILER_PATH=/usr/bin/gcc
ENV CC_OPT_FLAGS="-march=native"
ENV TF_NEED_KAFKA=0
ENV TF_NEED_TENSORRT=0
ENV GCC_HOST_COMPILER_PATH=/usr/bin/gcc
ENV CC_OPT_FLAGS="-march=native"

# Configure Build
ENV TF_ROOT=/tensorflow

WORKDIR $TF_ROOT
RUN ./configure

# build TensorFlow (add  -s to see executed commands)
# "--copt=" can be "-mavx -mavx2 -mfma  -msse4.2 -mfpmath=both"

# build entire package
RUN bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package

# build c++ library
#TODO RUN bazel build --config=cuda  tensorflow:libtensorflow_cc.so

# build from release branch
RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

# OR, build nightly:
#TODO RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package --nightly_flag /tmp/tensorflow_pkg

# Install wheel
#RUN pip3 install /tmp/tensorflow_pkg/tensorflow*.whl