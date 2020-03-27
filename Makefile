#!make
include .env
export $(shell sed 's/=.*//' .env)

mkdir:
	mkdir -p $$INPUT_DIR
	mkdir -p $$OUTPUT_DIR

populate: mkdir
	# Copy PDF files into input dir.

prepare: populate
	# Take first page of each PDF in the input dir.
	for i in $$INPUT_DIR/*.pdf ; do pdftk $$i cat 1 output tmp.pdf && mv tmp.pdf $$i ; done

train: populate clear
	java -Xmx4G -jar $$GROBID_PATH/grobid-core/build/libs/grobid-core-0.6.0-SNAPSHOT-onejar.jar -gH $$GROBID_PATH/grobid-home/ -dIn $$INPUT_DIR -dOut $$OUTPUT_DIR -exe createTraining

autocorrect-segmentation:
	for i in $$OUTPUT_DIR/*.training.segmentation.tei.xml ; do xsltproc --novalid xslt/front.xslt $$i > temp.xsl 2> /dev/null && mv temp.xsl $$i ; done

train-segmentation: train autocorrect-segmentation

clear:
	rm -r $$OUTPUT_DIR/*

reset:
	rm -r $$OUTPUT_DIR
	rm -r $$INPUT_DIR
