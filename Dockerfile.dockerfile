# Use jupyter minimal notebook as base for your image
FROM jupyter/minimal-notebook

# Maintainer
LABEL maintainer="Kamyar Hasanzadeh (kamyar.hasanzadeh@helsinki.fi)"

# Root for system-level tools
USER root
ENV HOME /home/$NB_USER

# Install extra system tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends ssh-client less \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Back to non-root
USER $NB_USER

# Install conda packages from conda-forge
RUN conda install --yes -c conda-forge \
    # ---- Core Python ----
    python=3.11 \
    pip \
    numpy \
    pandas \
    # ---- Plotting ----
    matplotlib \
    imageio \
    contextily \
    folium \
    geojson \
    # ---- Jupyter environment ----
    jupyterlab \
    jupyterlab-git \
    jupyterhub \
    notebook \
    ipython \
    ipykernel \

    # ---- GIS core ----
    geopandas>=0.13 \
	shapely>=2.0\
    mapclassify \
    osmnx \
    requests \
    sqlalchemy \
    rasterio \
    rioxarray \
    xarray \
    scipy \
    owslib \
    rtree \
	pexpect>=4.9\
    && conda clean -afy

# Build JupyterLab (optional)
RUN jupyter lab build --dev-build=False --minimize=False
