FROM lfoppiano/grobid:0.5.6

RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt-get install -y xsltproc make pdftk bash-completion

WORKDIR /opt/grobid
COPY Makefile ./
COPY .env ./
COPY xslt ./xslt/
RUN make mkdir

WORKDIR /
COPY bash.bashrc ./etc/