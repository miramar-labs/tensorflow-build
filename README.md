### Tensorflow Build Container

Assumes:
- you are running this container on a machine that has an NVIDIA GPU
- the machine has the usual NVIDIA GPU drivers installed
- the machine has docker installed
- the machine has the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) installed

[TF Source Build Notes](https://www.tensorflow.org/install/source#build_the_package)

[GPU Compute numbers](https://developer.nvidia.com/cuda-gpus#compute)
default: 7.5,6.1

Edit Dockerfile for any other customizations (see [DockerHub](https://hub.docker.com/r/nvidia/cuda/) for available base images/CUDA versions)

Build:

Pass three parameters:
- CUDA version
- cuDNN version
- Tensorflow build tag


	bash build.sh 11.0 8 v2.4.1
	
To get a BASH prompt into the container:

	make run-tf-build
	
To run the test:

	make run-tf-build-test
	

Example Output on success:

	Tue Feb 16 22:39:25 2021       
	+-----------------------------------------------------------------------------+
	| NVIDIA-SMI 460.39       Driver Version: 460.39       CUDA Version: 11.2     |
	|-------------------------------+----------------------+----------------------+
	| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
	| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
	|                               |                      |               MIG M. |
	|===============================+======================+======================|
	|   0  GeForce RTX 207...  On   | 00000000:01:00.0  On |                  N/A |
	| N/A   45C    P8    16W /  N/A |   1252MiB /  7982MiB |     14%      Default |
	|                               |                      |                  N/A |
	+-------------------------------+----------------------+----------------------+
																				   
	+-----------------------------------------------------------------------------+
	| Processes:                                                                  |
	|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
	|        ID   ID                                                   Usage      |
	|=============================================================================|
	+-----------------------------------------------------------------------------+
	2021-02-16 22:39:25.127444: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcudart.so.11.0
	2021-02-16 22:39:26.122692: I tensorflow/compiler/jit/xla_cpu_device.cc:41] Not creating XLA devices, tf_xla_enable_xla_devices not set
	2021-02-16 22:39:26.123334: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcuda.so.1
	2021-02-16 22:39:26.154385: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:941] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
	2021-02-16 22:39:26.154818: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1720] Found device 0 with properties: 
	pciBusID: 0000:01:00.0 name: GeForce RTX 2070 with Max-Q Design computeCapability: 7.5
	coreClock: 1.125GHz coreCount: 36 deviceMemorySize: 7.79GiB deviceMemoryBandwidth: 327.88GiB/s
	2021-02-16 22:39:26.154854: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcudart.so.11.0
	2021-02-16 22:39:26.161983: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcublas.so.11
	2021-02-16 22:39:26.162024: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcublasLt.so.11
	2021-02-16 22:39:26.167298: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcufft.so.10
	2021-02-16 22:39:26.168640: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcurand.so.10
	2021-02-16 22:39:26.175141: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcusolver.so.10
	2021-02-16 22:39:26.176929: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcusparse.so.11
	2021-02-16 22:39:26.177080: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcudnn.so.8
	2021-02-16 22:39:26.177153: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:941] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
	2021-02-16 22:39:26.177548: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:941] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
	2021-02-16 22:39:26.177926: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1862] Adding visible gpu devices: 0
	Tensorflow - Num GPUs Available:  1

