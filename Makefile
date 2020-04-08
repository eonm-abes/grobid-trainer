#!make
include .env
export $(shell sed 's/=.*//' .env)

# Image builder

build: 
	docker build . -t grobid-trainer:latest

run: build mkdir
	docker run -v "$$(pwd)"/$$INPUT_DIR:/opt/grobid/$$INPUT_DIR -v "$$(pwd)"/$$OUTPUT_DIR:/opt/grobid/$$OUTPUT_DIR -it grobid-trainer bash

mkdir:
	mkdir -p $$INPUT_DIR
	mkdir -p $$OUTPUT_DIR

#------------------------------------------------------------------------------
# GROBID trainer
#------------------------------------------------------------------------------

# Copy PDF files into input dir.
populate-pdf: mkdir

# Take first page of each PDF in the input dir
prepare: populate-pdf
	for i in $$INPUT_DIR/*.pdf ; do pdftk $$i cat 1 output tmp.pdf && mv tmp.pdf $$i ; done

# Call grobid  command
train: prepare populate-pdf clear
	java -Xmx4G -jar grobid-core-onejar.jar -gH grobid-home/ -dIn $$INPUT_DIR -dOut $$OUTPUT_DIR -exe createTraining

autocorrect-segmentation:
	for i in $$OUTPUT_DIR/*.training.segmentation.tei.xml ; do xsltproc --novalid xslt/front.xslt $$i > temp.xsl 2> /dev/null && mv temp.xsl $$i && rm -f temp.xsl ; done

train-segmentation: train autocorrect-segmentation

clear:
	rm -f -r $$OUTPUT_DIR/*

reset:
	rm -f -r $$OUTPUT_DIR
	rm -f -r $$INPUT_DIR
