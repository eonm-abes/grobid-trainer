
# -------------------
# Training automation
# -------------------

RUN mkdir -p /usr/share/man/man1

RUN apt-get update && \
    apt-get install -y xsltproc make pdftk bash-completion

COPY Makefile ./
COPY .env ./
COPY xslt ./xslt/

WORKDIR /
COPY bash.bashrc ./etc/

WORKDIR /opt/grobid
RUN make mkdir