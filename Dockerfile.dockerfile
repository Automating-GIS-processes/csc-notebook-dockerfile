# Use jupyter minimal notebook as base for your image
# It has conda already installed
FROM jupyter/minimal-notebook

# Set maintainer
LABEL maintainer="Kamyar Hasanzadeh (kamyar.hasanzadeh@helsinki.fi)"

# Some first setup steps need to be run as root user
USER root

# Set home environment variable to point to user directory
ENV HOME /home/$NB_USER

# Install needed extra tools, e.g., ssh-client and less
RUN apt-get update \
    && apt-get install -y ssh-client less \
    && apt-get clean

# Switch back to non-root user
USER $NB_USER

# Install needed conda packages and jupyter lab extensions
RUN conda install --yes -c conda-forge \
    python=3.10 \
    matplotlib \
    jupyterlab=3.6.3 \
    jupyterlab-git \
    myst-nb \
    sphinx \
    sphinx-book-theme \
    jupyterlab-myst \
    jupytext \
    bokeh \
    contextily \
    folium \
    geojson \
    geopandas \
    geopy \
    mapclassify \
    osmnx \
    psycopg2 \
    pyproj \
    pyrosm \
    requests \
    scikit-learn \
    shapely \
    sqlalchemy

# Clean up conda to reduce image size
RUN conda clean -afy

# Build JupyterLab (optional)
RUN jupyter lab build --dev-build=False --minimize=False
