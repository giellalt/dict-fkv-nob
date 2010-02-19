# Making html dictionary

fkvnob.html: ../bin/fkvnob.html
../bin/fkvnob.html: inc/fkvnob.xml
	@echo
	@echo "*** Making html file of the dictionary ***"
	@echo
	@xsltproc inc/fkvnob.xsl inc/fkvnob.xml > ../bin/fkvnob.html


# "make clean" is there to remove the binary files at will.

clean:
	@rm -f ../bin/*.fst ../bin/*.save ../bin/*.bin ../bin/*.html
