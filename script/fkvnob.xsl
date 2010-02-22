<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../../scripts/gt_dictionary.xsl"/>

<!--
xsltproc fkvnob.xsl fkvnob.xml > ../bin/fkvnob.html
.html
-->

<xsl:output method="html"/>

<xsl:template match="r">
<html>
 <head><meta charset="UTF-8"/>
 </head>
 <body>
  <xsl:apply-templates/>
 </body>
</html>
</xsl:template>

<xsl:template match="e">
  <xsl:apply-templates/>
 <br/>
</xsl:template>

<xsl:template match="l">
 <b>
  <xsl:apply-templates/>
 </b>
</xsl:template>

<!--
<xsl:template match="decl">
 <sup>
  <xsl:apply-templates/>
 </sup>
</xsl:template>
-->

<xsl:template match="stem">
  <xsl:text>(</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>)</xsl:text>
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

<xsl:template match="trans[not( position() = last() )]">
  <xsl:apply-templates/>,
</xsl:template>
<xsl:template match="t">
  <xsl:apply-templates/>
</xsl:template>

<!--
<xsl:template match="l2gramm">
 <sup>
  <xsl:apply-templates/>
 </sup>
</xsl:template>
-->

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
  ▸ <xsl:apply-templates/>
</xsl:template>

<xsl:template match="syn[not( position() = last() )]">
  <xsl:apply-templates/>,
</xsl:template>
<xsl:template match="syn">
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
