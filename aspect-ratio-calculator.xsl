<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Aspect Ratio calculators

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Aspect Ratio by Width
	Given a width, height and output width, define the correct output height
-->
<xsl:template name="aspect-ratio-by-width">
	
	<xsl:param name="input-width"/>
	<xsl:param name="input-height"/>
	<xsl:param name="output-width"/>

	<xsl:variable name="ratio" select="$input-height div $input-width"/>

	<xsl:value-of select="ceiling($output-width * $ratio)"/>

</xsl:template>


<!--
	Aspect Ration by Height
	Given a width, height and output height, define the correct output width
-->
<xsl:template name="aspect-ratio-by-height">
	
	<xsl:param name="input-width"/>
	<xsl:param name="input-height"/>
	<xsl:param name="output-height"/>

	<xsl:variable name="ratio" select="$input-height div $input-width"/>

	<xsl:value-of select="ceiling($output-height div $ratio)"/>

</xsl:template>


</xsl:stylesheet>
