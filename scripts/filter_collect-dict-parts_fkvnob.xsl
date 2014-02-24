<?xml version="1.0"?>
<!--+
    | 
    | The parameter: the path to the collection of XML-files to compile
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_SCRIPT dir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0" 
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:param name="dir" select="'gogo'"/>

  <xsl:template match="/" name="main">

<!-- collection('PATH?recurse=yes;select=*.xml') -->
<!-- collection('PATH?select=*.xml') -->


    <r>
      <xsl:for-each select="collection(concat($dir, '?select=*.xml'))/r">
      <xsl:copy-of select="e[every $c in ./mg/tg/t satisfies not(contains($c, 'xxx'))]"/>
      </xsl:for-each>
    </r>
  </xsl:template>
  
</xsl:stylesheet>
