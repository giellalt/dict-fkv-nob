
This directory contains the XML data of the Sanakirja glossary.

Input file:  sanakirja.doc.db.xml
Output file: out_out_sanakirja.doc.db.xml (= dict_sanakirja.doc.db.xml)

Two scripts: 
    - dbxml2xml.xsl
    - mk_contNode.xsl

Usage:
 1. java -Xmx2048m net.sf.saxon.Transform -it main dbxml2xml.xsl toIndent=sanakirja.doc.db.xml 
 2. java -Xmx2048m net.sf.saxon.Transform -it main mk_contNode.xsl toIndent=out_sanakirja.doc.db.xml 




 Output structure (except for <noKeyWord>):

<dict> +{1,1}
   <letter name="AAA"> +{1}
      <entry> +{1}
         <keyWord/> +{1,1}
         <content> +{1,1}
            [ <text/> | <noKeyWord/> | <i/> ] +{1}
        </content>
      </entry>
</dict>



 Todo:

  - put HTML-links to the inner references (--> keyword): Ciprian

  - fix the marked nodes; search for:  (Trond & Kven folk)
     - todo="xxx"
     - <para>
     - <i>
     - <emphasis
     - <noKeyWord>
