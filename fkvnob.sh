
# Dette skal bli ei makefil for å lage fkvnob.fst, 
# ei fst-fil som tar fkv og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage fkvnob.fst

# sh fkvnob.sh

echo ""
echo ""
echo "---------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/fkvnob.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/fkvnob.fst"
echo "---------------------------------------------------"
echo ""
echo ""

echo "LEXICON Root" > bin/fkvnob.lexc
cat src/*_fkvnob.xml | \
grep '^ *<[lt][ >]'  | \
sed 's/^ *//g;'      | \
sed 's/<l /™/g;'     | \
tr '\n' '£'          | \
sed 's/£™/€/g;'      | \
tr '€' '\n'          | \
tr '<' '>'           | \
cut -d'>' -f2,6      | \
tr '>' ':'           | \
tr ' ' '_'           | \
sed 's/$/ # ;/g;'    >> bin/fkvnob.lexc        

#xfst -e "read lexc < bin/fkvnob.lexc"

printf "read lexc < bin/fkvnob.lexc \n\
invert net \n\
save stack bin/fkvnob.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile



