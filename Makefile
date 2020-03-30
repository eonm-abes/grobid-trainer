#!make
include .env
export $(shell sed 's/=.*//' .env)

build: mkdir
	git pull && git submodule update --init --recursive
	rm -f ./grobid/Dockerfile.tmp && cat ./grobid/Dockerfile ./Dockerfile >> ./grobid/Dockerfile.tmp
	cp Makefile grobid/
	cp .env grobid/
	cp -r ./xslt grobid/
	cp bash.bashrc grobid/

run: build
	docker build grobid/ -f grobid/Dockerfile.tmp -t grobid-trainer && docker run -v "$$(pwd)"/$$INPUT_DIR:/opt/grobid/$$INPUT_DIR -v "$$(pwd)"/$$OUTPUT_DIR:/opt/grobid/$$OUTPUT_DIR -it grobid-trainer bash

mkdir:
	mkdir -p $$INPUT_DIR
	mkdir -p $$OUTPUT_DIR

populate: mkdir
	# Copy PDF files into input dir.

prepare: populate
	# Take first page of each PDF in the input dir.
	for i in $$INPUT_DIR/*.pdf ; do pdftk $$i cat 1 output tmp.pdf && mv tmp.pdf $$i ; done

train: prepare populate clear
	java -Xmx4G -jar grobid-core-onejar.jar -gH grobid-home/ -dIn $$INPUT_DIR -dOut $$OUTPUT_DIR -exe createTraining

autocorrect-segmentation:
	for i in $$OUTPUT_DIR/*.training.segmentation.tei.xml ; do xsltproc --novalid xslt/front.xslt $$i > temp.xsl 2> /dev/null && mv temp.xsl $$i && rm -f temp.xsl ; done

train-segmentation: train autocorrect-segmentation

clear:
	rm -f -r $$OUTPUT_DIR/*

reset:
	rm -f -r $$OUTPUT_DIR
	rm -f -r $$INPUT_DIR
