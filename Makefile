# Making html dictionary

fkvnob.html: bin/fkvnob.html
bin/fkvnob.html: src/*fkvnob.xml
	@echo
	@echo "*** Making html file of the dictionary ***"
	@echo
	@xsltproc script/fkvnob.xsl src/*fkvnob.xml > bin/fkvnob.html


# "make clean" is there to remove the binary files at will.

clean:
	@rm -f bin/*.fst bin/*.save bin/*.bin bin/*.html
