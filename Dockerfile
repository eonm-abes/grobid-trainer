
# -------------------
# Training automation
# -------------------

RUN apt-get update && \
    apt-get install -y make

COPY Makefile ./
COPY .env ./
