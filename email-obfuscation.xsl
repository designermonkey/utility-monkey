<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Email Obfuscation
	Requires JavaScript to re-compile the email address

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->
<xsl:template name="obfuscated-email">
	
	<xsl:param name="node"/>

	<xsl:variable name="string">
		<xsl:choose>
			<xsl:when test="$node/@href">
				<xsl:value-of select="@href"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$node/text()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:element name="a">
		<xsl:choose>
			<xsl:when test="starts-with($string, 'mailto')">
				<xsl:attribute name="data-identity"><xsl:value-of select="substring-after(substring-before($string,'@'), ':')"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="data-domain"><xsl:value-of select="substring-after($string,'@')"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute name="data-domain"><xsl:value-of select="substring-after($string,'@')"/></xsl:attribute>
		<xsl:attribute name="class">obfuscated</xsl:attribute>
		<xsl:attribute name="href">#</xsl:attribute>
	</xsl:element>

</xsl:template>


</xsl:stylesheet>
