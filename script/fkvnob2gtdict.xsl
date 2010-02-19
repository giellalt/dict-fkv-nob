<?xml version="1.0"?>
<!--+
    | Transforms termcenter.xml files into tab-separated entries of sme-nob.
    | Usage: xsltproc termc2txt.xsl termcenter.xml
    | 
    +-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng"
  xmlns:www="http://www.w3.org/1999/xhtml"
  version="2.0"
  exclude-result-prefixes="xsl d www">
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
	      encoding="UTF-8"
	      indent="yes"/>
  
  <xsl:param name="posVar"/>
  
  <xsl:template match="rootdict">
    <r>
      <xsl:apply-templates/>
    </r>
  </xsl:template>
  
  <xsl:template match="entry">
    <e>
      <xsl:apply-templates/>
    </e>
  </xsl:template>
  
  <xsl:template match="lemma">
    <lg>
      <l>
	<xsl:copy-of select="./@*"/>
	<xsl:value-of select="."/>
      </l>
      <xsl:copy-of select="../stem"/>
      <xsl:apply-templates/>
    </lg>
  </xsl:template>
  
  <xsl:template match="mgr">
    <mg>
      <xsl:apply-templates/>
    </mg>
  </xsl:template>
  
  <xsl:template match="trgr">
    <tg>
      <xsl:apply-templates/>
    </tg>
  </xsl:template>

  <xsl:template match="trans">
    <t>
      <xsl:copy-of select="./@*"/>
      <xsl:value-of select="."/>
      <xsl:apply-templates/>
    </t>
  </xsl:template>
  
  <xsl:template match="exgr">
    <xg>
      <xsl:apply-templates/>
    </xg>
  </xsl:template>

  <xsl:template match="ex">
    <x>
      <xsl:value-of select="."/>
      <xsl:apply-templates/>
    </x>
  </xsl:template>
  
  <xsl:template match="extr">
    <xt>
      <xsl:value-of select="."/>
      <xsl:apply-templates/>
    </xt>
  </xsl:template>

  <xsl:template match="node()|@*">
  </xsl:template>

  
</xsl:stylesheet>



