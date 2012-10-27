<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Master HTML5 Stylesheet
	Imported by the switchboard to output XML

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Import the XML templates files
-->


<!--
	Define the output
-->
<xsl:output method="xml" 
	omit-xml-declaration="no" 
	encoding="UTF-8" 
	indent="yes"/>

<xsl:strip-space elements="*" />


<!--
	Root template
-->
<xsl:template match="/" mode="xml">

	<data>
		<xsl:apply-templates select="data" mode="xml"/>
	</data>

</xsl:template>


</xsl:stylesheet>
