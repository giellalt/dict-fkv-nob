<?xml version="1.0"?>
<!--+
    | 
    | compares (ped vs. smenob) and put ped-flags on smenob-entries 
    | Usage: java net.sf.saxon.Transform -it main cfSmeSmj.xsl
    +-->

<!-- java -Xmx2048m net.sf.saxon.Transform -it main cfPED_resources.xsl ped_file=xml/nouns.xml smenob_file=../src/nounCommon_smenob.xml -->
<!-- java -Xmx2048m net.sf.saxon.Transform -it main flagSmenob.xsl ped_file=xml/adjectives.xml smenob_file=../src/adjective_smenob.xml  -->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs local">

  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="para"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  
  <!-- Input files -->
  <xsl:param name="toIndent" select="'default.xml'"/>

  <!-- Output files -->
  <xsl:variable name="outputDir" select="'.'"/>
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_format" select="'xml'"/>
  <xsl:variable name="e" select="$output_format"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($toIndent, '/'))[last()], '.xml')"/>
  <xsl:variable name="test" select="'false'"/>
  <xsl:variable name="outFile" select="concat($outputDir, '/', 'out_', $file_name, '.', $e)"/>  
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="doc-available($toIndent)">
	<xsl:variable name="last_dict">
	  <dict>
	    <xsl:for-each select="doc($toIndent)/dict/letter">
	      <xsl:element name="{name()}">
		<xsl:copy-of select="./@*"/>
		
		<xsl:for-each select="./entry[not(normalize-space(.) = '')]">
		  <entry>
		    <xsl:copy-of select="./@*"/>
		    <xsl:copy-of select="./*[1]"/>
		    <content>
		      <xsl:copy-of select="./*[position() &gt; 1]"/>
		    </content>
		  </entry>
		</xsl:for-each>
	      </xsl:element>
	    </xsl:for-each>
	  </dict>
	</xsl:variable>
	
	<xsl:result-document href="{$outFile}" format="{$output_format}">
	  
	  <!-- 	  <xsl:copy-of select="normalize-space(doc($toIndent))"/> -->
	  
	  <xsl:copy-of select="$last_dict"/>
	  
	</xsl:result-document>
	
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$toIndent"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  
  
</xsl:stylesheet>

