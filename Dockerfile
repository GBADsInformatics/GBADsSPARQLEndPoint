# Base ontop image
FROM ontop/ontop-endpoint:latest

# Switch to legacy Debian Buster repositories
RUN echo "deb http://archive.debian.org/debian/ buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security/ buster/updates main" >> /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install the necessary packages
RUN apt-get update && apt-get install -y \
    gettext \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copy in the options
WORKDIR /opt/ontop
COPY input/SpeciesTerm_v2.rdf input/SpeciesTerm_v2.obda input/prod.SpeciesTerm_v2.properties input/

COPY jdbc/postgresql-42.7.3.jar jdbc/
# copy jdbc/postgresql-42.7.3.jar /opt/graphdb/dist/lib

ENV ONTOP_MAPPING_FILE=/opt/ontop/input/SpeciesTerm_v2.obda
ENV ONTOP_ONTOLOGY_FILE=/opt/ontop/input/SpeciesTerm_v2.rdf
ENV ONTOP_PROPERTIES_FILE=/opt/ontop/input/prod.sub.SpeciesTerm_v2.properties

# Add Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

# Add supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start supervisord when the container has launched
ENTRYPOINT ["sh", "-c", "envsubst < /opt/ontop/input/prod.SpeciesTerm_v2.properties > /opt/ontop/input/prod.sub.SpeciesTerm_v2.properties && sed -i \"s|\\$BASE_URL|${BASE_URL}|g\" /etc/nginx/conf.d/default.conf && /usr/bin/supervisord"]
