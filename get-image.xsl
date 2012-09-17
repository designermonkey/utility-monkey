<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	JIT Basic Image

	@param node			XML image node
	@param alt			alt tag string. default empty
-->
<xsl:template name="jit-basic-image">
	
	<xsl:param name="node"/>
	<xsl:param name="alt" select="''"/>

	<img class="lazy" src="{$workspace}/assets/img/trans.gif" data-low="{$root}/image/0/{$node/meta/@height}/{$node/meta/@width}/{$node/@path}/{$node/filename/text()}" data-high="{$root}/image/1/{$node/meta/@width * 2}/{$node/meta/@height * 2}{$node/@path}/{$node/filename/text()}" width="{$node/meta/@width}" height="{$node/meta/@height}" alt="{$alt}"/>
	<noscript>
		<img src="{$root}/image/0/{$node/meta/@height}/{$node/meta/@width}/{$node/@path}/{$node/filename/text()}" width="{$node/meta/@width}" height="{$node/meta/@height}" alt="{$alt}"/>
	</noscript>

</xsl:template>


<!--
	JIT Resize Image

	@param	node		XML image node
	@param	alt			alt tag string. default empty
	@param	device		string desktop, tablet, mobile, tv. default is $device-categorizr!
-->	
<xsl:template name="jit-resize-image">
		
	<xsl:param name="node"/>
	<xsl:param name="alt" select="''"/>
	<xsl:param name="device" select="$device-categorizr"/>

	<xsl:variable name="path">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="device" select="$device"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="width">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="return" select="'width'"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="height">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="return" select="'height'"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="retina-path">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="retina" select="'yes'"/>
			<xsl:with-param name="device" select="$device"/>
		</xsl:call-template>
	</xsl:variable>

	<img class="lazy" src="{$workspace}/assets/img/trans.gif" data-low="{$path}" data-high="{$retina-path}" width="{$width}" height="{$height}" alt="{$alt}"/>
	<noscript>
		<img src="{$path}" width="{$width}" height="{$height}" alt="{$alt}"/>
	</noscript>

</xsl:template>


<!--
	JIT Image Meta
	Provides different meta for JIT sized images

	@param node			XML image node
	@param device		string desktop, tablet, mobile, tv. default $device-categorizr!
	@param return		string path, width, height
-->
<xsl:template name="jit-image-meta">
	
	<xsl:param name="node"/>
	<xsl:param name="retina" select="'no'"/>
	<xsl:param name="device" select="$device-categorizr"/>
	<xsl:param name="return" select="'path'"/>

	<xsl:variable name="old-width" select="$node/meta/@width"/>
	<xsl:variable name="old-height" select="$node/meta/@height"/>
	<xsl:variable name="new-width">
		<xsl:choose>
			<xsl:when test="$device = 'mobile'">
				<xsl:value-of select="$image-width-mobile"/>
			</xsl:when>
			<xsl:when test="$device = 'tablet'">
				<xsl:value-of select="$image-width-tablet"/>
			</xsl:when>
			<xsl:when test="$device = 'desktop'">
				<xsl:value-of select="$image-width-desktop"/>
			</xsl:when>
			<xsl:when test="$device = 'tv'">
				<xsl:value-of select="$image-width-tv"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$image-width-desktop"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!-- Maths! (ugh.) -->
	<xsl:variable name="new-height">
		<xsl:value-of select="ceiling((number($old-height) div number($old-width)) * number($new-width))"/>
	</xsl:variable>

	<xsl:variable name="output-width">
		<xsl:choose>
			<xsl:when test="$retina = 'yes'">
				<xsl:value-of select="$new-width * 2"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$new-width"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="output-height">
		<xsl:choose>
			<xsl:when test="$retina = 'yes'">
				<xsl:value-of select="$new-height * 2"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$new-height"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$return = 'path'">
			<xsl:value-of select="concat($root, '/image/1/' ,$output-width, '/', $output-height, $node/@path, '/', $node/filename)"/>
		</xsl:when>
		<xsl:when test="$return = 'width'">
			<xsl:value-of select="$new-width"/>
		</xsl:when>
		<xsl:when test="$return = 'height'">
			<xsl:value-of select="$new-height"/>
		</xsl:when>
	</xsl:choose>
	

</xsl:template>

</xsl:stylesheet>
