TMP_DIR = aux
PDFLATEX_FLAGS = -interaction=nonstopmode -output-directory $(TMP_DIR)
ASY_FLAGS = -o figures/ -outformat pdf -q -tex pdflatex -offscreen -gray -noprc -render 0

SRC = thesis.tex
SRC += $(wildcard *.sty)
SRC += $(wildcard chapters/*.tex)
SRC += $(wildcard frontmatter/*.tex)

ASY = $(wildcard figures/*.asy)
FIGS = $(ASY:.asy=.pdf)

all: thesis.pdf

figs: $(FIGS)

thesis.pdf: aux aux/thesis.pdf
	mv $(TMP_DIR)/thesis.pdf .

aux/thesis.pdf: $(FIGS) aux/thesis.aux aux/thesis.bbl aux/thesis.acr
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true

aux/thesis.bbl: thesis.bib
	bibtex $(TMP_DIR)/thesis > /dev/null || true

aux/thesis.aux:
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true

aux/thesis.acr: aux/thesis.aux
	makeglossaries -d $(TMP_DIR) thesis > /dev/null || true

aux:
	mkdir -p $(TMP_DIR)

figures/%.pdf: figures/%.asy
	asy $(ASY_FLAGS) $<

clean: $(TMP_DIR)
	rm -rf $(TMP_DIR)
	
drive: thesis.pdf
	cp thesis.pdf ../PhDThesis_Fabio_CARRARA_Draft.pdf
	cd .. && drive push -no-prompt -ignore-conflict PhDThesis_Fabio_CARRARA_Draft.pdf 
