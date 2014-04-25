
# Dette skal bli ei makefil for å lage fkvnob.fst, 
# ei fst-fil som tar fkv og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage fkvnob.fst

# sh fkvnob.sh

echo 
echo "Etter at dette scriptet er ferdig står du i xfst med promten"
echo "xfst[1]"
echo 
echo "Gjör då dette:"
echo "save bin/fkv.fst"
echo "quit"
echo ""


echo "LEXICON Root" > bin/fkv.lexc

cat src/*_fkvnob.xml | \
grep '<l ' | \
tr '<' '>'| cut -d">" -f3 | \
tr ' ' '_' | \
sed 's/$/ # ;/g' \
>> bin/fkv.lexc

xfst -e "read lexc < bin/fkv.lexc"



