fkv.fst: bin/fkv.fst
bin/fkv.fst: bin/fkv.txt #bin/fkvnob.html
	@echo
	@echo "*** html and fkv fst *** "
	@echo
	@xfst -e "read text < bin/fkv.txt" \
			-e "save stack bin/fkv.fst" \
			-stop 


fkv.txt: bin/fkv.txt
bin/fkv.txt: src/*_fkvnob.xml
	@echo
	@echo "*** Making txt file of the lemmas of the dictionary ***"
	@echo
	@xsltproc script/fkv.xsl src/*_fkvnob.xml > bin/fkv.txt


# Making html dictionary

#fkvnob.html: bin/fkvnob.html
#bin/fkvnob.html: src/*fkvnob.xml
#	@echo
#	@echo "*** Making html file of the dictionary ***"
#	@echo
#	@xsltproc script/fkvnob.xsl src/*fkvnob.xml > bin/fkvnob.html


# "make clean" is there to remove the binary files at will.

clean:
	@rm -f bin/*.fst bin/*.save bin/*.bin bin/*.html
