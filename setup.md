# Setting up GPU-enabled short course Jupyter hub containers

## Requirements
* Docker
* Google Compute Engine
* Google Kubernetes Engine
* NVIDIA CUDA docker [images](https://hub.docker.com/r/nvidia/cuda)
* jupyter [docker-stacks](https://github.com/jupyter/docker-stacks)

## Steps
* Start a Google Compute Engine instance with an NVIDIA GPU and install CUDA and docker. See [here](https://medium.com/google-cloud/jupyter-tensorflow-nvidia-gpu-docker-google-compute-engine-4a146f085f17).
* Clone the jupyter docker-stacks repository
* In the base-notebook Docker file, change the BASE_CONTAINER to "nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04"
* `>> docker build --rm -t djgagne/base-notebook .`
* Change to docker-stacks/minimal-notebook directory.
* `>> docker build --rm -t djgagne/minimal-notebook .`
* Change to directory containing short course docker file.
* `>> docker build --rm -t djgagne/ams-ml-short-course:gpu .`
* Start a Kubernetes cluster on google
* Log into a Kubernetes node and install CUDA [here](https://cloud.google.com/compute/docs/gpus/add-gpus).
* Wait until the nvidia drivers have been completely installed. Check status by typing in
`kubectl get pods --name
* Setup Jupyterhub on Google Cloud by following instructions [here](https://zero-to-jupyterhub.readthedocs.io/en/stable/index.html).

