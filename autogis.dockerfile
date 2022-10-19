# use jupyter minimal notebook as base for your image
# it has eg conda already installed
FROM jupyter/minimal-notebook


# Set the commit hash for the version of the AutoGIS site
# that has the appropriate environment.yml defined (new year, new packages)
ENV AUTOGIS_SITE_COMMIT "3b1a93b"


# set home environment variable to point to user directory
ENV HOME /home/$NB_USER


# install curl
USER root
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get clean 
USER $NB_USER


# Get the environment.yml from AutoGIS’ repository
RUN curl --silent -L \
    https://raw.githubusercontent.com/Automating-GIS-processes/site/${AUTOGIS_SITE_COMMIT}/ci/environment.yml \
    -o /tmp/environment.yml

# ... and install it
RUN conda env update --file /tmp/environment.yml --name base \
  && conda clean -afy


# add script that checks out lecture git repo
USER root
ADD checkout-autogis-lesson-notebooks.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/checkout-autogis-lesson-notebooks.sh
USER $NB_USER

CMD ["/usr/local/bin/checkout-autogis-lesson-notebooks.sh"]
