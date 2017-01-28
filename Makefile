all:
	pdflatex paper.tex && \
	bibtex paper && \
	pdflatex paper.tex
	

clean:
	rm *.log *.aux *.out *.pdf
