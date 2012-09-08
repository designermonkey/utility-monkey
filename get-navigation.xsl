<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Navigation Templates
	Provides navigation based on page type

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Template for navigation

	@param	classes	Class names to apply to all ul elements
-->
<xsl:template name="navigation">

	<xsl:param name="page-type"/>
	<xsl:param name="classes"/>

	<nav class="navigation {$page-type}">
		<ul>
			<xsl:if test="$classes">
				<xsl:attribute name="class">
					<xsl:value-of select="$classes"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="page[types/type = $page-type and not(types/type = 'hidden')]">
				<xsl:with-param name="classes" select="$classes"/>
			</xsl:apply-templates>
		</ul>
	</nav>
</xsl:template>


<!--
	Template for single navigation links

	@param	classes	Class names to apply to all ul elements
-->
<xsl:template match="page">

	<xsl:param name="classes"/>

	<xsl:variable name="page-url">
		<xsl:choose>
			<xsl:when test="types/type = 'index'">
				<xsl:value-of select="concat($root,'/')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($root,'/',@handle,'/')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<li>
		<a href="{$page-url}">
			<xsl:if test="@handle = $current-page or @handle = $root-page">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="name"/>
		</a>
		<xsl:if test="page and not(page/types/type = 'hidden')">
			<nav class="navigation nested">
				<ul>
					<xsl:if test="$classes">
						<xsl:attribute name="class">
							<xsl:value-of select="$classes"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="page[not(types/type = 'hidden')]">
						<xsl:with-param name="classes" select="$classes"/>
					</xsl:apply-templates>
				</ul>
			</nav>
		</xsl:if>
	</li>
</xsl:template>


</xsl:stylesheet>
