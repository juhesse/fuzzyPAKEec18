# Makefile for conference paper

# Configuration

# see config.mk

# Tagets -> Files

# * main  -> main.tex/pdf:       main file for the paper (included by paper-full.tex/paper-conf.tex)
# * full  -> paper-full.tex/pdf: full version
# * conf  -> paper-conf.tex/pdf: conference version (multiple files)
# * final -> final/: final version (AUTOMATICALLY GENERATED)
#     paper.tex: merge of all tex files
#     paper.bbl: bbl file
#     paper.tgz: tgz file containing all files and dependencies

.PHONY: mrproper clean FORCE_MAKE main full conf final

PDF=paper-full.pdf paper-conf.pdf main.pdf

include config.mk

main: main.pdf

full: paper-full.pdf

conf: paper-conf.pdf

final: final/paper.tex final/paper.tgz

all: main full conf final

final/paper.tex: paper-conf.tex paper-conf.bbl $(DEPS) FORCE_MAKE
	perl latexexpand.pl $< $@
	cp $(DEPS) final

final/%: FORCE_MAKE
	cd final && $(MAKE) $(@F)

clean: clean-common final/clean

mrproper: mrproper-common final/mrproper

include latex.mk
