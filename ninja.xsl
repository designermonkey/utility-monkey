<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	XSLT Ninja Transformations
	
	@package	Utility Monkey
	@author		Nils Hörrmann <http://nilshoerrmann.de> based on a technique by Allen Chang <http://chaoticpattern.com>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--	
	@level		A number to adjust the headline hierarchy, defaults to 0
	@class		A string to adjust the headline hierarchy, defaults to 0
	@prefix		A string or node added as first child to the matched elements
	@suffix		A string or node added as last child to the matched elements
-->
<xsl:template match="//*" mode="ninja">
	<xsl:param name="level" select="0" />
	<xsl:param name="class" />
	<xsl:param name="prefix" />
	<xsl:param name="suffix" />
	
	<!-- Create element -->
	<xsl:element name="{name()}">
	
		<!-- Class -->
		<xsl:if test="$class != ''">
			<xsl:attribute name="class">
				<xsl:value-of select="$class" />
			</xsl:attribute>
		</xsl:if>
		
		<!-- Prefix -->
		<xsl:if test="position() = 1">
			<xsl:copy-of select="$prefix" />
		</xsl:if>
	
		<!-- Apply templates for inline elements, attributes and text nodes -->
		<xsl:apply-templates select="* | @* | text()" mode="ninja">
			<xsl:with-param name="level" select="$level" />
		</xsl:apply-templates>
		
		<!-- Suffix -->
		<xsl:if test="position() = last()">
			<xsl:copy-of select="$suffix" />
		</xsl:if>
	</xsl:element>
</xsl:template>

<!--
	Attributes 
-->
<xsl:template match="//@*" mode="ninja">
	<xsl:attribute name="{name(.)}">
		<xsl:value-of select="." />
	</xsl:attribute>
</xsl:template>

<!--
	Headlines 
-->
<xsl:template match="h1 | h2 | h3 | h4" mode="ninja" priority="1">
	<xsl:param name="level" select="0" />
	
	<!-- Change hierarchy -->
	<xsl:element name="h{substring-after(name(), 'h') + $level}">
		<xsl:apply-templates select="* | @* | text()" mode="ninja" />
	</xsl:element>
</xsl:template>


</xsl:stylesheet>
