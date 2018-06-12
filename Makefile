TMP_DIR=aux
PDFLATEX_FLAGS=-interaction=nonstopmode -output-directory $(TMP_DIR)
ASY_FLAGS=-o $(TMP_DIR)/ -q -tex pdflatex -offscreen -gray -noprc


all: compile

aux:
	mkdir -p $(TMP_DIR)

compile: $(TMP_DIR)
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	asy $(ASY_FLAGS) $(TMP_DIR)/*.asy > /dev/null || true
	bibtex $(TMP_DIR)/thesis > /dev/null || true
	makeglossaries -d $(TMP_DIR) thesis > /dev/null || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	mv $(TMP_DIR)/thesis.pdf .

bib: aux
	bibtex $(TMP_DIR)/thesis > /dev/null || true
	makeglossaries -d $(TMP_DIR) thesis > /dev/null || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	mv $(TMP_DIR)/thesis.pdf .

update: aux
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	mv $(TMP_DIR)/thesis.pdf .

figure:
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	asy $(ASY_FLAGS) $(TMP_DIR)/*.asy > /dev/null || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex > /dev/null || true
	mv $(TMP_DIR)/thesis.pdf .

clean: $(TMP_DIR)
	rm -rf $(TMP_DIR)

debug: $(TMP_DIR)
	pdflatex $(PDFLATEX_FLAGS) thesis.tex || true
	asy $(ASY_FLAGS) $(TMP_DIR)/*.asy || true
	bibtex $(TMP_DIR)/thesis  || true
	makeglossaries -d $(TMP_DIR) thesis || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex || true
	pdflatex $(PDFLATEX_FLAGS) thesis.tex || true
	cp $(TMP_DIR)/thesis.pdf .
