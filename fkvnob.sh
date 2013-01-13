
# Dette skal bli ei makefil for å lage fkvnob.fst, 
# ei fst-fil som tar fkv og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.

# Kommando for å lage fkvnob.fst
echo "LEXICON Root" > bin/fkvnob.lexc
cat src/*_fkvnob.xml | grep '<[lt] '|tr '\n' '™' | sed 's/<l /£/g;'| tr '£' '\n'| grep -v '\!'|sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f2,6| tr ' ' '_'| tr '>' ':'| grep -v '__'|sed 's/$/ # ;/g' >> bin/fkvnob.lexc
#xfst -e "read lexc < bin/fkvnob.lexc"

printf "read lexc < bin/fkvnob.lexc \n\
save stack bin/nobfkv.fst \n\
invert net \n\
save stack bin/fkvnob.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile

# deretter i xfst:
# invert
# save bin/fkvnob.fst
