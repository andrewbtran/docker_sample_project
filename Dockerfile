FROM rocker/shiny
#If you were running a plumber API
#FROM trestletech/plumber

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install git \
    && sudo apt-get -y install libssl-dev libxml2-dev libudunits2-dev libgdal-dev libproj-dev libgeos-dev git default-jre default-jdk \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install default-jre-headless\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;


# WORKDIR /srv/shiny-server    
# COPY depends.r /srv/shiny-server/
# RUN Rscript depends.r
# COPY start.sh /srv/shiny-server/
WORKDIR /srv/shiny-server    

COPY depends.R /srv/shiny-server/
RUN Rscript depends.R

RUN mkdir -p /srv/shiny-server/notebooks
COPY /notebooks/01_notebook_example.Rmd /srv/shiny-server/notebooks

RUN mkdir -p /srv/shiny-server/shiny
COPY /shiny/server.R /srv/shiny-server/shiny
COPY /shiny/ui.R /srv/shiny-server/shiny

# if you were running the api
#RUN mkdir -p /srv/shiny-server/api
#COPY /api/plumber.R /srv/shiny-server/api
#COPY /api/readme.MD /srv/shiny-server/api

#RUN chmod -R +r /srv/shiny-server/
#RUN chmod -R 755 /srv/shiny-server/

## entrypoint if you were running a plumber API
#ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('/api/plumber.R'); pr$run(host='0.0.0.0', port=8000, swagger=TRUE)"]

EXPOSE 3838

# build locally
# docker-compose down && docker-compose rm && docker-compose up --force-recreate --build