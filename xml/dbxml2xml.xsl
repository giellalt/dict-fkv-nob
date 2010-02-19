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
  
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="doc-available($toIndent)">
	<xsl:variable name="dict">
	  <dict>
	    <xsl:for-each select="doc($toIndent)/dict/letter">
	      <xsl:element name="{name()}">
		<xsl:copy-of select="./@*"/>

		<xsl:for-each select="./para[not(normalize-space(.) = '')]">
		  <entry>
		    

		    
		      <xsl:variable name="allElem" select="count(./node())"/>
		      <xsl:variable name="bold" select="count(./emphasis[@role='bold'])"/>
		      <xsl:variable name="italic" select="count(./emphasis[not(@role)])"/>
		      <xsl:variable name="underline" select="count(./emphasis[@role='underline'])"/>
		      
		      <xsl:variable name="b_pos">
			<xsl:value-of select="./emphasis[@role='bold']/position()"/> 
		      </xsl:variable>
		      
		      <xsl:variable name="i_pos">
			<xsl:value-of select="./emphasis[not(@role)]/position()"/> 
		      </xsl:variable>

		      <xsl:variable name="u_pos">
			<xsl:value-of select="./emphasis[@role='underline']/position()"/> 
		      </xsl:variable>
		      
<!-- 		      <xsl:attribute name="allElem"> -->
<!-- 			<xsl:value-of select="$allElem"/> -->
<!-- 		      </xsl:attribute> -->

<!-- 		      <xsl:attribute name="b_pos"> -->
<!-- 			<xsl:value-of select="$b_pos"/> -->
<!-- 		      </xsl:attribute> -->


		    <xsl:if test="$test = 'true'">
		      <xsl:attribute name="bold">
			<xsl:value-of select="$bold"/>
		      </xsl:attribute>
		      <xsl:attribute name="italic">
			<xsl:value-of select="$italic"/>
		      </xsl:attribute>
		      <xsl:attribute name="underline">
			<xsl:value-of select="$underline"/>
		      </xsl:attribute>
		      <xsl:attribute name="b_pos">
			<xsl:value-of select="$b_pos"/>
		      </xsl:attribute>
		      <xsl:attribute name="i_pos">
			<xsl:value-of select="$i_pos"/>
		      </xsl:attribute>
		      <xsl:attribute name="u_pos">
			<xsl:value-of select="$u_pos"/>
		      </xsl:attribute>
		      
		      <xsl:if test="count(./emphasis[@role='bold']) = 0">
			<xsl:variable name="noBold_and_dash">
			  <xsl:value-of select="starts-with(normalize-space(.), '–')"/> 
			</xsl:variable>
			
			<xsl:attribute name="dashed">
			  <xsl:value-of select="$noBold_and_dash"/>
			</xsl:attribute>
		      </xsl:if>
		      
		    </xsl:if>
		    
		    <xsl:copy-of select="./@*"/>
				    
		    <xsl:for-each select="node()">
		      <xsl:if test=".=../text() and not(normalize-space(.)='')">
			<text>
<!-- 			  <xsl:attribute name="pos"> -->
<!-- 			    <xsl:value-of select="position()"/> -->
<!-- 			  </xsl:attribute> -->
			  <xsl:copy-of select="normalize-space(.)"/>
			</text>
		      </xsl:if>
		      
		      <xsl:if test="not(.=../text())">

			<xsl:variable name="elemName">
			  <xsl:variable name="currentName" select="name()"/>
			  <xsl:choose>
			    <xsl:when test="$currentName='noKeyWord'">
			      <xsl:value-of select="$currentName"/>
			    </xsl:when>
			    <xsl:when test="$currentName='emphasis'">
			      <xsl:choose>
				<xsl:when test="./.[not(@role)]">
				  <xsl:value-of select="'i'"/>
				</xsl:when>
				<xsl:when test="./.[@role='bold']">
				  <xsl:value-of select="'b'"/>
				</xsl:when>
				<xsl:when test="./.[@role='underline']">
				  <xsl:value-of select="'u'"/>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select="'attr_xxx'"/>
				</xsl:otherwise>
			      </xsl:choose>
			    </xsl:when>
			    <xsl:otherwise>
			      <xsl:value-of select="'elem_xxx'"/>
			    </xsl:otherwise>
			  </xsl:choose>
			</xsl:variable>

			<xsl:if test="position()=2">
			  <keyWord>
			    <xsl:for-each select="@*">
			      <xsl:if test="not(name()='role')">
			      <xsl:copy-of select="."/>
			      </xsl:if>
			    </xsl:for-each>
			    
			    <xsl:copy-of select="./node()"/>
			  </keyWord>
			</xsl:if>
			
			<xsl:if test="position() &gt; 2">
			    <xsl:element name="{$elemName}">
			      
<!-- 			      <xsl:attribute name="pos"> -->
<!-- 				<xsl:value-of select="position()"/> -->
<!-- 			      </xsl:attribute> -->

			      <xsl:copy-of select="./node()"/>
			    </xsl:element>
			</xsl:if>

		      </xsl:if>
		      
		    </xsl:for-each>		


		    
		  </entry>
		</xsl:for-each>
		
	      </xsl:element>
	    </xsl:for-each>
	  </dict>
	</xsl:variable>

	<xsl:variable name="outFile" select="concat($outputDir, '/', 'out_', $file_name, '.', $e)"/>

	<!-- indent document -->
<!-- 	<xsl:result-document href="{$outputDir}/out_{$file_name}.{$e}" format="{$output_format}"> -->

	<xsl:result-document href="{$outFile}" format="{$output_format}">

	  <!-- 	  <xsl:copy-of select="normalize-space(doc($toIndent))"/> -->

	  <xsl:copy-of select="$dict"/>

	</xsl:result-document>

      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$toIndent"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

<!--   <xsl:template name="gogo" match="text()"> -->
<!--     <xsl:analyze-string select="." regex="\(.+?\)"> -->
<!--       <xsl:matching-substring> -->
<!-- 	<ex><xsl:value-of select="translate(., '()', '')"/></ex> -->
<!--       </xsl:matching-substring> -->
<!--       <xsl:non-matching-substring> -->
<!-- 	<xsl:value-of select="."/> -->
<!--       </xsl:non-matching-substring> -->
<!--     </xsl:analyze-string> -->
<!--   </xsl:template> -->
  
  
  
</xsl:stylesheet>

