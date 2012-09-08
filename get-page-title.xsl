<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Page Title Template
-->
<xsl:template name="page-title">
	<title>
		<xsl:if test="$current-path != '/'">
			<xsl:value-of select="/data/params/page-title"/>
			<xsl:text> | </xsl:text>
		</xsl:if>
		<xsl:value-of select="/data/params/website-name"/>
	</title>
</xsl:template>

</xsl:stylesheet>
