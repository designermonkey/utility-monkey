<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Page Title Template

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->
<xsl:template name="page-title">
	<title>
		<xsl:if test="not($current-path = '/')">
			<xsl:value-of select="/data/params/page-title"/>
			<xsl:text> | </xsl:text>
		</xsl:if>
		<xsl:value-of select="/data/params/website-name"/>
	</title>
</xsl:template>

</xsl:stylesheet>
