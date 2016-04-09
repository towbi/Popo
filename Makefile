# Popo's makefile
#
# To generate an HTML file from XML and XSLT just type 'make'

P=profile
XSLTPROC=java -jar /usr/share/java/Saxon-HE.jar
LANGUAGES="de en"
README=README

all: $(P) css

$(P):
	@for lang in `echo ${LANGUAGES}`; do \
		echo XSLT processing for language $$lang ...; \
		cmdline="$(XSLTPROC) -s:$(P).xml -xsl:$(P)_$$lang.xslt > $(P)_$$lang.html"; \
		echo $$cmdline; \
		$(XSLTPROC) -s:$(P).xml -xsl:$(P)_$$lang.xslt > $(P)_$$lang.html; \
		echo; \
	done

css:
	@echo Generating CSS from SCSS ...
	sass $(P).scss > $(P).css
	sass $(P).print.scss > $(P).print.css
	@echo

.PHONY: clean
clean:
	-@for lang in `echo ${LANGUAGES}`; do \
		echo Removing generated HTML for language $$lang ...; \
	    rm $(P)_$$lang.html; \
	done
	@echo Removing generated CSS ...
	-rm $(P).css

$(README):
	@echo Generating $(README) from markdown ...
	@echo "<!DOCTYPE html><html><head><meta charset='utf-8'><title>README</title></head><body>" > $(README).html
	markdown $(README).md >> $(README).html
	@echo "</body></html>" >> $(README).html
	@echo

.PHONY: clean-$(README)
clean-$(README):
	@echo Removing generated $(README) ...
	-rm $(README).html

