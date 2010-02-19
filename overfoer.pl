#!/usr/bin/perl -w
#
# kvasikode
#
# Felt:
# #"Lemma","POS","trans","tPOS","1stamme","2stamme","syntrans","syntransPOS","syntrans2","syntrans2POS","syntrans3","syntrans3POS","syneks","syneks2","syneks3"
# 
# #"Lemma","POS","trans","tPOS","1stamme","2stamme","syntrans","syntransPOS","syntrans2","syntrans2POS","syntrans3","syntrans3POS","eks","syneks","syneks2","syneks3"
# 
# eks = "ord ord..."
# syneks = syneks2 = syneks3 = "ord"
# syneks = <vis_til>syneks</vis_til>
# eks = <exgr><ex>eks</ex><extr></extr></exgr>
# 
# <vis_til_gruppe><vis_til>tietenki</vis_til><vis_til>tietekki</vis_til><
# 
# 
# Les inn felta
# 
# Putt relevante felt inn i relevante stader i xml-strukturen
# 
# etter: syntrans3POS: 3 felt. Dei er av to typar, anten - eller:
# a. dei inneheld mellomrom: type e (exempel)
# b. dei inneheld ikkje mellomrom: type s (synonym)
# siste tre felt er
# xxe, xex, der x er tom og e er eksempel
# sss, der s = synonym eller tom
#   <entry>
#     <lemma decl="POS">Lemma</lemma>
#     <stem>1stamme</stem>
#     <stem>2stamme</stem>
#     <mgr>
#       <trgr>
#         <trans decl="tPOS">trans</trans>
#         <trans decl="syntransPOS">syntrans</trans>
#         <trans decl="syntrans2POS">syntrans2</trans>
#         <trans decl="syntrans3POS">syntrans3</trans>
#         <exgr>
#           <ex>syneks</ex>
#           <extr>MANGLAR_I_INPUT</extr>
#         </exgr>
#         <exgr>
#           <ex>syneks2</ex>
#           <extr>MANGLAR_I_INPUT</extr>
#         </exgr>
#         <exgr>
#           <ex>syneks3</ex>
#           <extr>MANGLAR_I_INPUT</extr>
#         </exgr>
#       </trgr>
#     </mgr>
#   </entry>

########################################################

use encoding 'utf-8';

# File and directory variables:
$SRCDIR = ".";

$CSVF = $SRCDIR . "/inn_ord.csv";
$DICT = $SRCDIR . "/dictionary.xml";

open CSVF or die "Can't find file $CSVF: $!\n";
open DICT, ">$DICT" or die "Can't find file $DICT: $!\n";

print DICT "<dictionary >\n";

$line = <CSVF> ;

while ( $line = <CSVF> ) {
	chomp $line;
	($Lemma,
     $POS,
     $trans,
     $tPOS,
     $stamme1,
     $stamme2,
     $syntrans,
     $syntransPOS,
     $syntrans2,
     $syntrans2POS,
     $syntrans3,
     $syntrans3POS,
     $syneks,
     $syneks2,
     $syneks3)
	   = split /"?,"?/, $line ;
#    print "Lina er: $line\n";
#    print "Lemma er: $Lemma\n";
    $Lemma =~ s/"\W?(\w)/$1/; # rens $Lemma for " og ^L
    print DICT "\t<entry>\n";
    print DICT "\t  <lemma decl=\"$POS\">$Lemma</lemma>\n";
    if ($stamme1 =~ /\w/) { print DICT "\t  <stem>$stamme1</stem>\n"; }
    if ($stamme2 =~ /\w/) { print DICT "\t  <stem>$stamme2</stem>\n"; }
    print DICT "\t  <mgr>\n";
    print DICT "\t    <trgr>\n";
    print DICT "\t      <trans decl=\"$tPOS\">$trans</trans>\n";
    if ($syntrans =~ /\w/) { print DICT "\t      <trans decl=\"$syntransPOS\">$syntrans</trans>\n";   }
    if ($syntrans =~ /\w/) { print DICT "\t      <trans decl=\"$syntrans2POS\">$syntrans2</trans>\n"; }
    if ($syntrans =~ /\w/) { print DICT "\t      <trans decl=\"$syntrans3POS\">$syntrans3</trans>\n"; }
    if ($syneks =~ /\s/ || $syneks2 =~ /\s/ || $syneks3 =~ /\s/) {
        print DICT "\t      <exgr>\n";
        print DICT "\t        <ex>$syneks$syneks2$syneks3</ex>\n";
        print DICT "\t        <extr></extr>\n";
        print DICT "\t      </exgr>\n";
    } elsif ($syneks =~ /\w/ || $syneks2 =~ /\w/ || $syneks3 =~ /\w/) {
        print DICT "\t      <syngr>\n";
        if ($syneks =~ /\w/) { print DICT "\t        <syn>$syneks</syn>\n";  }
        if ($syneks =~ /\w/) { print DICT "\t        <syn>$syneks2</syn>\n"; }
        if ($syneks =~ /\w/) { print DICT "\t        <syn>$syneks3</syn>\n"; }
        print DICT "\t      </syngr>\n";
    }
    print DICT "\t    </trgr>\n";
    print DICT "\t  </mgr>\n";
    print DICT "\t</entry>\n";
}

print DICT "</dictionary>\n";
close DICT;
close CSVF;

# Note: Desse blir feil og skal fiksast:
# Dei blir merka som exgr, skal vers syneks
# "levoton paikka","louhikkonen",
# "tykköö","Hän oon minun tykkönä",
# "tykköö","Hän oon minun tykkönä",
# "himmee","Himmi sää oon umpu sää",
# "himmee","Himmi sää oon umpu sää",
# "tykönä","Hän oon minun tykköö",
# "tykönä","Hän oon minun tykköö",
# 
# "Nahka kun menee ",,
# "Tehe nyt sen valmhiiksi!",,
# "Tehe nyt sen valmhiiksi!",,
# "Ole vaiti!",,
# 
