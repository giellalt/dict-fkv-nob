<?xml version="1.0"?>
<!--+
    | Transforms termcenter.xml files into tab-separated entries of sme-nob.
    | Usage: xsltproc termc2txt.xsl termcenter.xml
    | 
    +-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng"
    xmlns:myFn="http://whatever"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">

  <xsl:import href="mapPOS.xsl"/>
  
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
	      encoding="UTF-8"
	      indent="yes"/>


  <xsl:template match="r">
    <d:dictionary
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng">
      <xsl:apply-templates />
    </d:dictionary>
  </xsl:template>
  
  <xsl:template match="e">
    <d:entry d:title="{lg/l}">
      <xsl:attribute name="id">
	<xsl:variable name="attr_values">
	  <xsl:for-each select="lg/l/@*">
	    <xsl:text>_</xsl:text>
	    <xsl:value-of select="normalize-space(.)" />
	  </xsl:for-each>
	</xsl:variable>
	<xsl:value-of select="concat(lg/l, $attr_values)"/>
      </xsl:attribute>
      <d:index d:value="{lg/l}"/>
      <xsl:for-each select="lg/spellings/spv">
	<d:index d:value="{.}"/>	
      </xsl:for-each>
      
      <div d:priority="2"><h1><xsl:value-of select="lg/l"/></h1></div>
      <span class="syntax">
	<span d:pr="US">
	  <!-- it is a word form -->
	  <xsl:if test="lg/lemma_ref">
	    <a href="x-dictionary:r:{lg/lemma_ref/@lemmaID}">
	      <short_ref>
		<xsl:value-of select="normalize-space(lg/lemma_ref)"/>
	      </short_ref>
	    </a>
	    
	    <xsl:text>                    </xsl:text>
	    <i> (</i>
	    <pos_tag>
	      <i><xsl:value-of select="myFn:mapPOS(substring-before(normalize-space(lg/l/@pos),'_'))"/></i>
	    </pos_tag>
	    <i>)</i>
	  </xsl:if>
	  <xsl:if test="not(lg/lemma_ref)">
	    <pos_tag>
	      <i><xsl:value-of select="myFn:mapPOS(normalize-space(lg/l/@pos))"/></i>
	    </pos_tag>
	  </xsl:if>
	</span>
      </span>

      <div>
	<xsl:if test="lg/l/@pos = 'v' or substring-before(normalize-space(lg/l/@pos),'_') = 'v'">
	  <!-- 	  <xsl:text>mist </xsl:text> -->
	  <xsl:if test="normalize-space(lg/l/@stem) = 'odd' or not(normalize-space(lg/l/@class) = '')">
	    <xsl:text>Klasse </xsl:text>
	    <xsl:if test="not(normalize-space(lg/l/@class) = '')">
	      <i><xsl:value-of select="normalize-space(lg/l/@class)"/></i>
	    </xsl:if>
	    <xsl:if test="normalize-space(lg/l/@stem) = 'odd'">
	      <i><xsl:text>ulikest.</xsl:text></i>
	    </xsl:if>
	  </xsl:if>
	</xsl:if>
      </div>
      
      <div>
	<br/>
	<ol>
	  <xsl:apply-templates select="mg"/>
	</ol>
      </div>
      
      <div align="left" d:priority="2">
	<xsl:if test="./mg/tg/xg/x and ./mg/tg/xg/xt">
	  <table border="0" align="left">
	    <tr>
	      <td align="left">
		<prep_context>
		  <i>
		    <b>Eksempler:</b>
		  </i>
		</prep_context>
	      </td>
	      <td align="left"/>
	    </tr>
	    <tr>
	      <td align="left">
		<ul>
		  <!-- 		      <xsl:call-template name="exx"/> -->
		  <xsl:apply-templates select="./mg/tg/xg"/>
		</ul>
	      </td>
	    </tr>
	  </table>
	</xsl:if>
      </div>
      
      <div align="right" d:priority="2">
	<img class="alpha" src="Images/blank.jpg"/>
	<table border="0" align="right">
	  <tr>
	    <td align="right"></td>
	    <td align="right">Beta Version</td>
	  </tr>
	</table>
      </div>
      
    </d:entry>
    
  </xsl:template>
  
  <xsl:template match="mg">
    <xsl:variable name="tgCount" select="count(./tg)"/>
    <xsl:for-each select="./tg">
      <xsl:variable name="tgPos" select="position()"/>
      <li>
	<xsl:variable name="tCount" select="count(./t)"/>
	<xsl:for-each select="./t">
	  <bf><xsl:value-of select="normalize-space(.)"/></bf>
	  <!-- 				  if ($tgPos = $tgCount) then '.' -->
	  <xsl:value-of select="if (position() = $tCount) then 
				if ($tgPos = $tgCount) then ''
				else ';'
				else ', '"/>
	</xsl:for-each>
      </li>
    </xsl:for-each>
    
  </xsl:template>
  
  <xsl:template name="exx" match="xg">
    <li>
      <xsl:apply-templates select="./x"/>
    </li>
  </xsl:template>
  
  <xsl:template match="x">
    <i>
      <small>
	<xsl:value-of select="normalize-space(.)"/>
      </small>
    </i>
    <br/>
    <xsl:apply-templates select="../xt"/>
  </xsl:template>
  
  <xsl:template match="xt">
    <small>
      <xsl:value-of select="normalize-space(.)"/>
    </small>
  </xsl:template>
  
</xsl:stylesheet>
