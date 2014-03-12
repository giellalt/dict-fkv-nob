
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
echo "invert"
echo "save bin/fkvnob.fst"
echo "quit"
echo ""
echo "LEXICON Root" > bin/nobfkv.lexc

cat  src/*_nobfkv.xml | \

echo "LEXICON Root" > bin/fkvnob.lexc

cat src/*_fkvnob.xml | \
grep -v "creativecommons" | \
grep '^ *<' | \
grep -v xml | \
grep -v '_' | \
tr '\n' '™' | sed 's/<e/£/g;'| tr '£' '\n'| \
sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f6,16| \
tr ' ' '_'| sed 's/:/%/g;'|tr '>' ':'| \
grep -v '__'|sed 's/$/ # ;/g' >> bin/fkvnob.lexc

xfst -e "read lexc < bin/fkvnob.lexc"


# deretter gjer du dette i xfst:
# invert
# save bin/fkvnob.fst

