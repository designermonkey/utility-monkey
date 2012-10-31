<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Master Switchboard Stylesheet
	Chooses which format to use, HTML, XML or JSON depending on whether an API token is present

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Import the master files
-->
<xsl:import href="../utilities/master.html5.xsl" />
<xsl:import href="../utilities/master.xml.xsl" />
<xsl:import href="../utilities/master.json.xsl" />


<!--
	Import the utilities file globally
-->
<xsl:import href="../utilities/utilities.xsl" />


<!--
	Set the Switchboard keys
	Use a random key for this. <http://randomkeygen.com> is useful.
-->
<xsl:param name="expected-xml-token" select="'zCwtY3dn0NucoRw13xjQp60l59h54vz1'"/>
<xsl:param name="expected-json-token" select="'prOCQ334CuE1y40FN2mly1lUQZ5bYI9M'"/>


<!--
	Define any global parameter fallbacks

	@param	device-categorizr	Used to tell what device type is viewing the site. Use as a last minute fix for device specific layouts.
	@param	environment			Tells which environment the site is running under. Values: production, staging, development.
	@param	api-key				If provided, is tested against the expected key to switch the output mode.
-->
<xsl:param name="device-categorizr" />
<xsl:param name="environment" />
<xsl:param name="token"/>


<!--
	Widths for Image Output
	Used in conjunction with JIT Image templates to provide (slightly more) accurate image sizes, and retina images

	@param	image-width-tv		Width for images for TV categorised devices
	@param	image-width-desktop	Width for images for Desktop categorised devices
	@param	image-width-tablet	Width for images for Tablet categorised devices
	@param	image-width-mobile	Width for images for Mobile categorised devices
-->
<xsl:variable name="image-width-tv" select="960"/>
<xsl:variable name="image-width-desktop" select="960"/>
<xsl:variable name="image-width-tablet" select="768"/>
<xsl:variable name="image-width-mobile" select="480"/>


<!--
	Root Switchboard
-->
<xsl:template match="/">
	<xsl:choose>
		<!-- Call templates for Page content when in History mode -->
		<xsl:when test="$token = $expected-xml-token">
			<xsl:apply-templates select="." mode="xml"/>
		</xsl:when>
		<!-- Call templates for API -->
		<xsl:when test="$token = $expected-json-token">
			<xsl:apply-templates select="." mode="json"/>
		</xsl:when>
		<!-- Call normal HTML5 templates -->
		<xsl:otherwise>
			<xsl:apply-templates select="." mode="html5"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>
