.SUFFIXES: .tex .pdf .view

DOCS = vo
VCS_STAMP = gitid.tex

PDFLATEX = pdflatex

build: $(DOCS:=.pdf)

view: vo.view

vo.pdf: $(VCS_STAMP)

$(VCS_STAMP):
	echo '{\\tt ' >$@
	pwd | sed 's%.*/%%' >>$@
	echo '{\\jobname}.tex ' >>$@
	echo `git log -1 --pretty="format:%h %ci" | sed "s/ [+-].*//"`>>$@
	echo '}' >>$@

clean:
	rm -f $(VCS_STAMP)
	rm -f $(DOCS:=.aux) $(DOCS:=.log) $(DOCS:=.out) $(DOCS:=.pdf)

veryclean: clean
	rm -f $(STILTS_JAR)

.tex.pdf:
	$(PDFLATEX) $< && \
        $(PDFLATEX) $< || \
        rm -f $@

.pdf.view:
	test -f $< && \
        okular $< 2>/dev/null


