<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
xsltproc script/fkv.xsl src/*_fkvfkv.xml > bin/fkv.txt
-->

<xsl:output
     method="text"
     encoding="UTF-8"
     />

<!--
<xsl:template match="r">
<html>
 <head><meta charset="UTF-8"/>
 </head>
 <body>
  <xsl:apply-templates/>
 </body>
</html>
</xsl:template>
-->
<xsl:template match="e/lg/l">
<xsl:value-of select="." />
<xsl:text>
</xsl:text>
</xsl:template>


 <xsl:template match="node()|@*">
     <xsl:apply-templates/>
 </xsl:template>     

<!--
<xsl:template match="l">
 <b>
  <xsl:apply-templates/>
 </b>
</xsl:template>

<xsl:template match="decl">
 <sup>
  <xsl:apply-templates/>
 </sup>
</xsl:template>

<xsl:template match="mg">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="restrict">
  <xsl:text>(</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="tg">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="t">
  <xsl:apply-templates/>
</xsl:template>
-->

<!--
<xsl:template match="l2gramm">
 <sup>
  <xsl:apply-templates/>
 </sup>
</xsl:template>
-->
<!--
<xsl:template match="stem">
  <xsl:text>(</xsl:text>
 <i> <xsl:apply-templates/></i>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="xg">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="ex">
  <i><b><small>
   <xsl:apply-templates/>
 </small></b></i>
</xsl:template>

<xsl:template match="xt">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="syng">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="syn">
  <small>
  syn: <i><xsl:apply-templates/></i>
  </small>
</xsl:template>
-->
</xsl:stylesheet>
