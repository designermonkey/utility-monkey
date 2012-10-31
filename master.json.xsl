<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Master HTML5 Stylesheet
	Imported by the switchboard to output JSON

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Import the JSON templates files
-->
<xsl:import href="../utilities/jsonml.xsl" />
<xsl:import href="../utilities/xml-to-jsonml.xsl" />


<!--
	Define the output
-->
<xsl:output method="text" 
	omit-xml-declaration="yes" 
	encoding="UTF-8" 
	indent="no"/>

<xsl:strip-space elements="*" />


<!--
	Root template
-->
<xsl:template match="/" mode="json">

	<xsl:text>{</xsl:text>
		<xsl:apply-templates select="data" mode="json"/>
	<xsl:text>}</xsl:text>

</xsl:template>


</xsl:stylesheet>
