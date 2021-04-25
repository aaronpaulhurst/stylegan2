#!/bin/bash

# These are the setup preerequisitives for an AWS g4dn.xlarge instance, running Ubuntu 18.04 LTS.

# First step:
#   git clone https://github.com/aaronpaulhurst/stylegan2.git

# Install ubuntu packages
sudo apt update 
sudo apt install software-properties-common gcc g++ make python3-venv nvidia-driver-460 awscli

# Create and activate python virtual environment
rm -rf ~/venv
python3 -m venv --system-site-packages ~/venv
source venv/bin/activate

# Install Python PIP packages
pip install --upgrade pip
pip install --upgrade tensorflow-gpu==1.14
pip install Pillow

# Install CUDA 10 (from NVIDIA site)
wget https://developer.download.nvidia.com/compute/cuda/10.0/secure/Prod/local_installers/cuda_10.0.130_410.48_linux
chmod a+x cuda_10.0.130_410.48_linux
sudo ./cuda_10.0.130_410.48_linux

# Install CNN (from local S3 bucket)
aws s3 cp s3://ahurst-stylegan2/libcudnn7_7.5.0.56-1+cuda10.0_amd64.deb .
aws s3 cp s3://ahurst-stylegan2/libcudnn7-dev_7.5.0.56-1+cuda10.0_amd64.deb .
sudo dpkg -i libcudnn7_7.5.0.56-1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.5.0.56-1+cuda10.0_amd64.deb

# Setup environment
export CUDA_HOME=/usr/local/cuda-10.0
export CUDA_ROOT=/usr/local/cuda-10.0
export PATH=$PATH:$CUDA_ROOT/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

