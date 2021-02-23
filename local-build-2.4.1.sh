#!/usr/bin/env bash

pushd local

rm -rf tensorflow

git clone --depth 1 --branch v2.4.1 git@github.com:tensorflow/tensorflow.git

# Set env vars for configure
export TF_NEED_CUDA=1
export TF_NEED_TENSORRT=0
export TF_CUDA_VERSION=11.0
export CUDA_TOOLKIT_PATH="/usr/local/cuda"
export TF_CUDNN_VERSION=8
export TF_TENSORRT_VERSION=7.2.2
export CUDNN_INSTALL_PATH=/usr
export TF_CUDA_COMPUTE_CAPABILITIES=7.5,6.1

export PYTHON_BIN_PATH=/usr/bin/python
export PYTHON_LIB_PATH=/usr/local/lib/python3.8/dist-packages
export TF_NEED_ROCM=0
export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_NEED_OPENCL=0
export TF_NEED_JEMALLOC=1
export TF_ENABLE_XLA=0
export TF_NEED_VERBS=0
export TF_CUDA_CLANG=0
export TF_NEED_MKL=0
export TF_DOWNLOAD_MKL=0
export TF_NEED_AWS=0
export TF_NEED_MPI=0
export TF_NEED_GDR=0
export TF_NEED_S3=0
export TF_NEED_OPENCL_SYCL=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_NEED_COMPUTECPP=0
export GCC_HOST_COMPILER_PATH=/usr/bin/gcc
export CC_OPT_FLAGS="-march=native"
export TF_NEED_KAFKA=0
export GCC_HOST_COMPILER_PATH=/usr/bin/gcc
export CC_OPT_FLAGS="-march=native"

pushd ./tensorflow

# Configure Build
./configure

# build entire package
bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package

# build c++ library
#TODO bazel build --config=cuda  tensorflow:libtensorflow_cc.so

# build from release branch
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

popd

popd