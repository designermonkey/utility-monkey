<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Symphony JIT Image Templates
	Output images easily using these templates, supports retina displays

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	JIT Basic Image

	Provided images are uploaded twice the dimension required for output, allowing a standard size, and retina size

	@param node			XML image node
	@param alt			alt tag string. default empty
	@param classes		provide class names to add to the img tag
	@param do-retina	whether to provide retina sizes
	@param do-lazy-load	whether to use a lazy loading JavaScript
-->
<xsl:template name="jit-basic-image">
	
	<xsl:param name="node"/>
	<xsl:param name="alt" select="''"/>
	<xsl:param name="classes" select="''"/>
	<xsl:param name="do-retina" select="true()"/>
	<xsl:param name="do-lazy-load" select="false()"/>
	<xsl:param name="placeholder" select="concat($workspace, '/assets/img/trans.gif')"/>

	<xsl:variable name="data-low" select="concat($root, '/image/1/', $node/meta/@width div 2, '/', $node/meta/@height div 2, '/', $node/@path, '/', $node/filename/text())"/>
	<xsl:variable name="data-high" select="concat($root, '/image/1/', $node/meta/@width, '/', $node/meta/@height, '/', $node/@path, '/', $node/filename/text())"/>

	<xsl:choose>
		<xsl:when test="$do-lazy-load">
			<xsl:choose>
				<xsl:when test="$do-retina">
					<img class="lazyload {$classes}" src="{$placeholder}" data-low="{$data-low}" data-high="{$data-high}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:when>
				<xsl:otherwise>
					<img class="lazyload {$classes}" src="{$placeholder}" data-low="{$data-low}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:otherwise>
			</xsl:choose>
			<noscript>
				<img class="{$classes}" src="{$data-low}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
			</noscript>
		</xsl:when>
		<xsl:otherwise>
				<xsl:when test="$do-retina">
					<img class="{$classes}" src="{$data-high}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:when>
				<xsl:otherwise>
					<img class="{$classes}" src="{$data-low}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:otherwise>
		</xsl:otherwise>
	</xsl:choose>

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
	<xsl:param name="classes" select="''"/>
	<xsl:param name="device" select="$device-categorizr"/>
	<xsl:param name="specific-width" select="''"/>
	<xsl:param name="do-retina" select="true()"/>
	<xsl:param name="do-lazy-load" select="false()"/>

	<xsl:variable name="path">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="specific-width" select="$specific-width"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="width">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="specific-width" select="$specific-width"/>
			<xsl:with-param name="return" select="'width'"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="height">
		<xsl:call-template name="jit-image-meta">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="specific-width" select="$specific-width"/>
			<xsl:with-param name="return" select="'height'"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:if test="$do-retina">
		<xsl:variable name="retina-path">
			<xsl:call-template name="jit-image-meta">
				<xsl:with-param name="node" select="$node"/>
				<xsl:with-param name="retina" select="true()"/>
				<xsl:with-param name="device" select="$device"/>
				<xsl:with-param name="specific-width" select="$specific-width"/>
			</xsl:call-template>
		</xsl:variable>
	</xsl:if>

	<xsl:choose>
		<xsl:when test="$do-lazy-load">
			<xsl:choose>
				<xsl:when test="$do-retina">
					<img class="lazyload {$classes}" src="{$workspace}/assets/img/trans.gif" data-low="{$path}" data-high="{$retina-path}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:when>
				<xsl:otherwise>
					<img class="lazyload {$classes}" src="{$data-low}/assets/img/trans.gif" data-low="{$path}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:otherwise>
			</xsl:choose>
			<noscript>
				<img class="{$classes}" src="{$path}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
			</noscript>
		</xsl:when>
		<xsl:otherwise>
				<xsl:when test="$do-retina">
					<img class="{$classes}" src="{$retina-path}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:when>
				<xsl:otherwise>
					<img class="{$classes}" src="{$path}" width="{$node/meta/@width div 2}" height="{$node/meta/@height div 2}" alt="{$alt}"/>
				</xsl:otherwise>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>


<!--
	JIT Image Meta
	Provides different meta for JIT sized images

	@param node			XML image node
	@param retina		Whether to output retina image data
	@param device		string desktop, tablet, mobile, tv. default $device-categorizr!
	@param specific-width	override the device setting with a specific width number()
	@param return		string path, width, height
-->
<xsl:template name="jit-image-meta">
	
	<xsl:param name="node"/>
	<xsl:param name="retina" select="false()"/>
	<xsl:param name="device" select="$device-categorizr"/>
	<xsl:param name="specific-width" select="''"/>
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
			<xsl:when test="not($specific-width = '')">
				<xsl:value-of select="$specific-width"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="new-height">
		<xsl:value-of select="ceiling((number($old-height) div number($old-width)) * number($new-width))"/>
	</xsl:variable>

	<xsl:variable name="output-width">
		<xsl:choose>
			<xsl:when test="$retina">
				<xsl:value-of select="$new-width"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$new-width div 2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="output-height">
		<xsl:choose>
			<xsl:when test="$retina">
				<xsl:value-of select="$new-height"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$new-height div 2"/>
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
