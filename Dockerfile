# Base ontop image
FROM ontop/ontop

# Install the necessary packages
USER root
RUN apt-get update && apt-get install -y \
    gettext \
    && rm -rf /var/lib/apt/lists/*

# Copy in the options
WORKDIR /opt/ontop
COPY input/SpeciesTerm_v2.rdf input/SpeciesTerm_v2.obda input/prod.SpeciesTerm_v2.properties input/ 
RUN chown -R ontop:ontop input
USER ontop

COPY jdbc/mysql-connector-j-8.3.0.jar jdbc/
# copy jdbc/mysql-connector-j-8.3.0.jar /opt/graphdb/dist/lib

ENV ONTOP_MAPPING_FILE=/opt/ontop/input/SpeciesTerm_v2.obda
ENV ONTOP_ONTOLOGY_FILE=/opt/ontop/input/SpeciesTerm_v2.rdf
ENV ONTOP_PROPERTIES_FILE=/opt/ontop/input/SpeciesTerm_v2.properties

CMD envsubst < /opt/ontop/input/prod.SpeciesTerm_v2.properties > /opt/ontop/input/prod.sub.SpeciesTerm_v2.properties && \
        java -cp ./lib/*:./jdbc/* -Dlogback.configurationFile=file:./log/logback.xml \
        it.unibz.inf.ontop.cli.Ontop endpoint \
        --ontology=input/SpeciesTerm_v2.rdf \
        --mapping=input/SpeciesTerm_v2.obda \
        --properties=input/prod.sub.SpeciesTerm_v2.properties \
        --cors-allowed-origins=* \
        --port=80
