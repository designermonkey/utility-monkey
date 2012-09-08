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

	@param node			XML image node
	@param mode			string normal or case-study, default is normal
	@param alt			alt tag string. default empty
-->	
<xsl:template name="jit-resize-image">
		
	<xsl:param name="node"/>
	<xsl:param name="alt" select="''"/>
	<xsl:param name="mode" select="'normal'"/>
	<xsl:param name="device" select="'desktop'"/>

	<xsl:variable name="path">
		<xsl:call-template name="jit-image-path">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="device" select="$device"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="width">
		<xsl:call-template name="jit-image-path">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="return" select="'width'"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="height">
		<xsl:call-template name="jit-image-path">
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="mode" select="$mode"/>
			<xsl:with-param name="device" select="$device"/>
			<xsl:with-param name="return" select="'height'"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="retina-path">
		<xsl:call-template name="jit-image-path">
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
	JIT Case Study Image

	@param node			XML image node
	@param mode			string normal, large
	@param alt			alt tag string. default empty
	@param device		string desktop, tablet, mobile, tv. default is desktop. Use $device-categorizr!
-->
<xsl:template name="jit-case-study-images">
	
	<xsl:param name="node"/>
	<xsl:param name="mode" select="'normal'"/>
	<xsl:param name="alt" select="''"/>
	<xsl:param name="device" select="'desktop'"/>

	<xsl:variable name="old-width" select="$node/meta/@width"/>

	<xsl:variable name="old-height">
		<xsl:choose>
			<xsl:when test="$mode = 'large-top'">
				<xsl:value-of select="415"/>		
			</xsl:when>
			<xsl:when test="$mode = 'large-bottom'">
				<xsl:value-of select="$node/meta/@height - 415"/>
			</xsl:when>
			<xsl:when test="$mode = 'normal'">
				<xsl:value-of select="$node/meta/@height"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="new-width">
		<xsl:choose>
			<xsl:when test="$device = 'mobile'">
				<xsl:value-of select="480"/>
			</xsl:when>
			<xsl:when test="$device = 'tablet'">
				<xsl:value-of select="655"/>
			</xsl:when>
			<xsl:when test="$device = 'desktop'">
				<xsl:value-of select="737"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<!-- Maths! (ugh.) -->
	<xsl:variable name="new-height">
		<xsl:value-of select="ceiling((number($old-height) div number($old-width)) * number($new-width))"/>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$mode = 'large-top'">

			<xsl:variable name="output-low" select="concat($root,'/image/2/',$new-width,'/',$new-height,'/2/fff',$node/@path,'/',$node/filename)"/>

			<xsl:variable name="output-high" select="concat($root,'/image/2/',$new-width * 2,'/',$new-height * 2,'/2/fff',$node/@path,'/',$node/filename)"/>

			<img class="lazy" src="{$workspace}/assets/img/trans.gif" data-low="{$output-low}" data-high="{$output-high}" alt="{$alt}" width="{$new-width}" height="{$new-height}" />
			<noscript>
				<img src="{$output-low}" alt="{$alt}" width="{$new-width}" height="{$new-height}" />
			</noscript>
		</xsl:when>
		<xsl:when test="$mode = 'large-bottom'">
			
			<xsl:variable name="output-low" select="concat($root,'/image/2/',$new-width,'/',$new-height,'/8/fff',$node/@path,'/',$node/filename)"/>

			<xsl:variable name="output-high" select="concat($root,'/image/2/',$new-width * 2,'/',$new-height * 2,'/8/fff',$node/@path,'/',$node/filename)"/>

			<img class="lazy" src="{$workspace}/assets/img/trans.gif" data-low="{$output-low}" data-high="{$output-high}" alt="{$alt}" width="{$new-width}" height="{$new-height}" />
			<noscript>
				<img src="{$output-low}" alt="{$alt}" width="{$new-width}" height="{$new-height}" />
			</noscript>
		</xsl:when>
		<xsl:when test="$mode = 'normal'">

			<xsl:variable name="output-low" select="concat($root,'/image/1/',$new-width,'/',$new-height,$node/@path,'/',$node/filename)"/>

			<xsl:variable name="output-high" select="concat($root,'/image/1/',$new-width * 2,'/',$new-height * 2,$node/@path,'/',$node/filename)"/>

			<img class="lazy" src="{$workspace}/assets/img/trans.gif" data-low="{$output-low}" data-high="{$output-high}" alt="{$alt}" width="{$new-width}" height="{$new-height}" />
			<noscript>
				<img src="{$output-low}" alt="{$alt}" width="{$new-width}" height="{$new-height}" />
			</noscript>

		</xsl:when>
	</xsl:choose>

</xsl:template>


<!--
	JIT Image Path

	@param node			XML image node
	@param mode			string normal or case-study. default is normal
	@param device		string desktop, tablet, mobile, tv. default is desktop. Use $device-categorizr!
	@param return		string path, width, height
-->
<xsl:template name="jit-image-path">
	
	<xsl:param name="node"/>
	<xsl:param name="mode" select="'normal'"/>
	<xsl:param name="retina" select="'no'"/>
	<xsl:param name="device" select="'desktop'"/>
	<xsl:param name="return" select="'path'"/>

	<xsl:variable name="old-width" select="$node/meta/@width"/>
	<xsl:variable name="old-height" select="$node/meta/@height"/>
	<xsl:variable name="new-width">
		<xsl:choose>
			<xsl:when test="$device = 'mobile' and $mode = 'normal'">
				<xsl:value-of select="480"/>
			</xsl:when>
			<xsl:when test="$device = 'mobile' and $mode = 'case-study'">
				<xsl:value-of select="480"/>
			</xsl:when>
			<xsl:when test="$device = 'tablet' and $mode = 'normal'">
				<xsl:value-of select="880"/>
			</xsl:when>
			<xsl:when test="$device = 'tablet' and $mode = 'case-study'">
				<xsl:value-of select="655"/>
			</xsl:when>
			<xsl:when test="$device = 'desktop' and $mode = 'normal'">
				<xsl:value-of select="990"/>
			</xsl:when>
			<xsl:when test="$device = 'desktop' and $mode = 'case-study'">
				<xsl:value-of select="737"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="990"/>
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
