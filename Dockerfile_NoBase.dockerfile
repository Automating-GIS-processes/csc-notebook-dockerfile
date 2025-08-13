# Use jupyter minimal notebook as base for your image
FROM jupyter/minimal-notebook

# Maintainer
LABEL maintainer="Kamyar Hasanzadeh (kamyar.hasanzadeh@helsinki.fi)"

# ---------- System setup ----------
USER root
ENV HOME=/home/$NB_USER
# Prevent ~/.local from shadowing conda packages
ENV PYTHONNOUSERSITE=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ssh-client less \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Back to non-root ----------
USER $NB_USER

# Remove possible user-site leftovers that could override conda
RUN rm -rf /home/$NB_USER/.local/lib/python3.11/site-packages/osmnx* \
           /home/$NB_USER/.local/lib/python3.11/site-packages/geopandas* \
           /home/$NB_USER/.local/lib/python3.11/site-packages/shapely* || true

# ---------- Conda config (strict conda-forge) ----------
RUN conda config --add channels conda-forge \
 && conda config --set channel_priority strict \
 && conda install -y -n base mamba \
 && conda clean -afy

# ---------- Create a CLEAN env so base pins don't interfere ----------
# Name it autogis2025 and install everything in ONE transaction
RUN mamba create -y -n autogis2025 \
    python=3.11 \
    pip \
    # ---- Core Python ----
    numpy \
    pandas \
    scipy \
    requests \
    sqlalchemy \
    # ---- Plotting ----
    matplotlib \
    imageio \
    contextily \
    folium \
    geojson \
    mapclassify \
    # ---- GIS core (modern & mutually compatible) ----
    shapely>=2.0 \
    geopandas>=0.13 \
    osmnx>=2.0 \
    pyproj \
    rtree \
    rasterio \
    rioxarray \
    xarray \
    owslib \
    # ---- Jupyter environment ----
    jupyterlab \
    jupyterlab-git \
    jupyterhub \
    notebook \
    ipython \
    ipykernel \
 && conda clean -afy

# Make the new env the default for everything (shell, python, jupyter)
ENV CONDA_DEFAULT_ENV=autogis2025
ENV PATH=/opt/conda/envs/autogis2025/bin:$PATH

# Register the kernel so Jupyter uses autogis2025 by default
RUN /opt/conda/envs/autogis2025/bin/python -m ipykernel install --user --name autogis2025 --display-name "Python (autogis2025)"

# Build JupyterLab (optional)
RUN jupyter lab build --dev-build=False --minimize=False
