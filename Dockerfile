FROM djgagne/minimal-notebook

LABEL maintainer="David John Gagne <djgagne@ou.edu>"

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    vim \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -c conda-forge --quiet --yes \
    numpy \
    scipy \
    pandas \
    matplotlib \
    scikit-learn \
    shapely \
    descartes \
    xarray \
    netcdf4 \
    distributed \
    ipywidgets \
    cartopy \
    dask && \
    pip install --no-cache-dir tensorflow-gpu && \
    pip install --no-cache-dir keras && \
    conda clean -tipsy && \
    cp /usr/lib/x86_64-linux-gnu/libcudnn* /usr/local/cuda/lib64/ && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER 

ENV LD_LIBRARY_PATH /usr/local/nvidia/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

ENV PATH /usr/local/nvidia/bin:$PATH

ENV XDG_CACHE_HOME /home/$NB_USER/.cache/


RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER

RUN mkdir /data && \
    chmod 755 /data

ADD track_data_ncar_ams_3km_nc_small.tar.gz /data
ADD track_data_ncar_ams_3km_csv_small.tar.gz /data

USER $NB_UID

RUN git clone https://github.com/djgagne/ams-ml-python-course.git

RUN ln -s /data /home/$NB_USER/ams-ml-python-course/data

