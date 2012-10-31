<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Master HTML5 Stylesheet
	Imported by the switchboard to output HTML5

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Import the HTML5 templates files
-->
<xsl:import href="../utilities/get-page-title.xsl" />
<xsl:import href="../utilities/get-navigation.xsl" />
<xsl:import href="../utilities/get-header.xsl" />
<xsl:import href="../utilities/get-footer.xsl" />


<!--
	Define the output
-->
<xsl:output method="xml" 
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
	omit-xml-declaration="yes" 
	encoding="UTF-8" 
	indent="yes"/>

<xsl:strip-space elements="*" />


<!--
	Root template
-->
<xsl:template match="/" mode="html5">

	<!-- Create page name classes -->
	<xsl:variable name="pages">
		<xsl:choose>
			<xsl:when test="$root-page = $current-page">
				<xsl:value-of select="$current-page"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($root-page, ' ', $current-page)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!-- Output IE versioned html tag -->
	<xsl:comment><![CDATA[[if IE 6]><html lang="en" class="no-js ]]><xsl:value-of select="concat($pages, ' ', $device-categorizr)"/><![CDATA[ ie ie6"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 7]><html lang="en" class="no-js ]]><xsl:value-of select="concat($pages, ' ', $device-categorizr)"/><![CDATA[ ie ie7"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 8]><html lang="en" class="no-js ]]><xsl:value-of select="concat($pages, ' ', $device-categorizr)"/><![CDATA[ ie ie8"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 9]><html lang="en" class="no-js ]]><xsl:value-of select="concat($pages, ' ', $device-categorizr)"/><![CDATA[ ie ie9"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if !(lte IE 9)]><!]]></xsl:comment>
	<html lang="en" class="no-js {$pages} {$device-categorizr}">
		<xsl:comment><![CDATA[<![endif]]]></xsl:comment>

		<head>
			<xsl:apply-templates mode="head-meta"/>
			<xsl:apply-templates mode="global-css"/>
			<xsl:apply-templates mode="page-css"/>
			<xsl:apply-templates mode="head-js"/>
		</head>

		<body>
			<xsl:apply-templates mode="header"/>
			<div class="wrapper">
				<xsl:apply-templates mode="body"/>
			</div>
			<xsl:apply-templates mode="footer"/>
			<xsl:apply-templates mode="foot-js"/>
			<xsl:apply-templates mode="page-js"/>
		</body>
	</html>
</xsl:template>


<!--
	Head Meta template
-->
<xsl:template match="data" mode="head-meta">
	<xsl:comment><![CDATA[[if lte IE 9]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/><![endif]]]></xsl:comment>

	<base href="{$root}"/>
	<meta name="description" content=""/>
	<meta name="author" content=""/>
	<meta name="generator" content="Symphony CMS"/>

	<meta name="viewport" content="width=device-width,minimum-scale=1.0,initial-scale=1.0"/>
	<meta name="HandheldFriendly" content="True"/>
	<meta name="MobileOptimized" content="320"/>
	<meta http-equiv="cleartype" content="on"/>

	<xsl:call-template name="page-title"/>

	<!-- Shortcut and Tile Icons -->
	<link rel="shortcut icon" href="{$workspace}/assets/img/favicon.ico"/>

	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/touch/apple-touch-icon-144x144-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/touch/apple-touch-icon-114x114-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/touch/apple-touch-icon-72x72-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" href="img/touch/apple-touch-icon-57x57-precomposed.png"/>
	<link rel="shortcut icon" href="img/touch/apple-touch-icon.png"/>

	<meta name="msapplication-TileImage" content="img/touch/apple-touch-icon-144x144-precomposed.png"/>
	<meta name="msapplication-TileColor" content="#222222"/>
		
</xsl:template>


<!--
	Global CSS template
-->
<xsl:template match="data" mode="global-css">
	<xsl:choose>
		<xsl:when test="$environment = 'development'">
			<link rel="stylesheet/less" type="text/css" href="{$workspace}/assets/less/styles.less"/>
		</xsl:when>
		<xsl:when test="$environment = 'staging'">
			<link rel="stylesheet/less" type="text/css" href="{$workspace}/assets/less/styles.less"/>
		</xsl:when>
		<xsl:when test="$environment = 'production'">
			<link rel="stylesheet/css" type="text/css" href="{$workspace}/assets/css/styles.css"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!--
	Template for Header JavaScript
-->
<xsl:template match="data" mode="head-js">
	<xsl:choose>
		<xsl:when test="$environment = 'development'">
			<!-- Less Debugging Mode -->
			<script>var less = {env: "development"};</script>
			<script src="{$workspace}/assets/js/less-1.3.0.js" type="text/javascript"></script>
			<script src="{$workspace}/assets/js/modernizr.js"></script>
		</xsl:when>
		<xsl:when test="$environment = 'staging'">
			<script src="{$workspace}/assets/js/less-1.3.0.min.js" type="text/javascript"></script>
			<script src="{$workspace}/assets/js/modernizr.min.js"></script>
		</xsl:when>
		<xsl:when test="$environment = 'production'">
			<script src="{$workspace}/assets/js/modernizr.min.js"></script>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!--
	Footer JavaScript
-->
<xsl:template match="data" mode="foot-js">

    <script src="{$workspace}/assets/js/jquery-1.8.0.min.js"></script>
	
	<!-- Replacement animation function, which allows CSS3 transitions -->
	<!--<script src="{$workspace}/assets/js/jquery.transit.min.js" type="text/javascript"></script>-->

	<script src="{$workspace}/assets/js/js-monkey.js" type="text/javascript"></script>
	
</xsl:template>


</xsl:stylesheet>
