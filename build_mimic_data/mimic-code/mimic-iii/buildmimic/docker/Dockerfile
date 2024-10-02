FROM postgres:latest

# in the docker initialization, we do not build the data
ENV BUILD_MIMIC 0

RUN apt-get update \
 && apt-get install -y git \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mimic-code /mimic_data \
 && cd /mimic-code \
 # clone the postgres build scripts into a local folder
 && git init \
 && git remote add -f origin https://github.com/MIT-lcp/mimic-code \
 && git config core.sparseCheckout true \
 && echo "mimic-iii/buildmimic/postgres/" >> .git/info/sparse-checkout \
 && echo "mimic-iii/buildmimic/docker/"   >> .git/info/sparse-checkout

RUN cd /mimic-code \
 && git pull origin main

RUN cd /mimic-code \
 && cp -r mimic-iii/buildmimic/postgres /docker-entrypoint-initdb.d/

COPY setup.sh /mimic-code/mimic-iii/buildmimic/docker/setup.sh

RUN cd /mimic-code \
 # copy the build scripts into a different folder and remove the temp folder
 && cp mimic-iii/buildmimic/docker/setup.sh /docker-entrypoint-initdb.d/ \
 && rm -rf /mimic-code
