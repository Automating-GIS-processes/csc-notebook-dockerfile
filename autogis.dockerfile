# use jupyter minimal notebook as base for your image
# it has eg conda already installed
FROM jupyter/minimal-notebook

# Configure which year of AutoGIS this container is used for
# (checks out the according classroom repositories)
ENV YEAR "2022" 

# Set the commit hash for the version of the AutoGIS site
# that has the appropriate environment.yml defined
ENV AUTOGIS_SITE_COMMIT "34f08ad" 

# set home environment variable to point to user directory
ENV HOME /home/$NB_USER

# install some tools
USER root
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get clean 
USER $NB_USER

# Get the environment.yml from ${YEAR}’s AutoGIS repository
RUN curl -L \
    https://raw.githubusercontent.com/Automating-GIS-processes/site/${AUTOGIS_SITE_COMMIT}/ci/environment.yml \
    -o /tmp/environment.yml

### Installing the needed conda packages and jupyter lab extensions. 
# Run conda clean afterwards in same layer to keep image size lower
RUN conda env update --file /tmp/environment.yml --name base \
  && conda clean -afy


# TODO: add script that checks out lecture git repo
