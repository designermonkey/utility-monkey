<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Master HTML Stylesheet
	Import into pages for 

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Import the utilities file
-->
<xsl:import href="../utilities/utilities.xsl" />


<!--
	Import the templates files
-->
<xsl:import href="../utilities/get-page-title.xsl" />
<xsl:import href="../utilities/get-header.xsl" /> <!-- includes get-navigation.xsl -->
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


<!--
	Define any global parameter fallbacks
-->
<xsl:param name="device-categorizr" />


<!--
	Root template
-->
<xsl:template match="/">

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
	<xsl:comment><![CDATA[[if IE 6]><html lang="en" class="no-js ]]><xsl:value-of select="$pages"/><xsl:text> </xsl:text><xsl:value-of select="$device-categorizr"/><![CDATA[ ie ie6 lt-ie9 lt-ie8 lt-ie7"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 7]><html lang="en" class="no-js ]]><xsl:value-of select="$pages"/><xsl:text> </xsl:text><xsl:value-of select="$device-categorizr"/><![CDATA[ ie ie7 lt-ie9 lt-ie8"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 8]><html lang="en" class="no-js ]]><xsl:value-of select="$pages"/><xsl:text> </xsl:text><xsl:value-of select="$device-categorizr"/><![CDATA[ ie ie8 lt-ie9"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if IE 9]><html lang="en" class="no-js ]]><xsl:value-of select="$pages"/><xsl:text> </xsl:text><xsl:value-of select="$device-categorizr"/><![CDATA[ ie ie9"><![endif]]]></xsl:comment>
	<xsl:comment><![CDATA[[if !(lte IE 9)]><!]]></xsl:comment><html lang="en" class="no-js {$pages} {$device-categorizr}"><xsl:comment><![CDATA[<![endif]]]></xsl:comment>

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


	<meta name="description" content="Arc is a full service Brand Activation agency, built on the three specialist disciplines of shopper, experiential and sponsorship"/>
	<meta name="author" content="Produced by Airlock (airlock.com) in London, England."/>
	<meta name="generator" content="Symphony CMS"/>
	<!-- Added max and min scale to prevent page from scaling on orientation change -->
	<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no"/>
	<xsl:call-template name="page-title"/>
	<link rel="shortcut icon" href="{$workspace}/assets/img/favicon.ico"/>
	<link rel="canonical" href="{$root}"/>
	<meta name="apple-mobile-web-app-capable" content="yes"/>
</xsl:template>


<!--
	Global CSS template
-->
<xsl:template match="data" mode="global-css">
	<xsl:choose>
		<xsl:when test="$environment = 'development'">
			<link href="{$workspace}/assets/js/video-js/video-js.min.css" rel="stylesheet"/>
			<link rel="stylesheet/less" type="text/css" href="{$workspace}/assets/less/styles.less"/>
		</xsl:when>
		<xsl:when test="$environment = 'staging'">
			<link href="{$workspace}/assets/js/video-js/video-js.min.css" rel="stylesheet"/>
			<link rel="stylesheet/less" type="text/css" href="{$workspace}/assets/less/styles.less"/>
		</xsl:when>
		<xsl:when test="$environment = 'production'">
			<link href="{$workspace}/assets/js/video-js/video-js.min.css" rel="stylesheet"/>
			<link rel="stylesheet/less" type="text/css" href="{$workspace}/assets/less/styles.less"/>
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
			<script src="{$workspace}/assets/js/less-1.3.0.min.js" type="text/javascript"></script>
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

	<!-- Get Google hosted copy of jQuery or local -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <script>window.jQuery || document.write('&lt;script src="{$workspace}/assets/js/jquery-1.8.0.min.js"><\/script>')</script>
    <!--<script src="{$workspace}/assets/js/jquery-ui-1.8.20.custom.min.js" type="text/javascript"></script>-->
	
	<!-- Replacement animation function, which allows CSS3 transitions -->
	<!--<script src="{$workspace}/assets/js/jquery.transit.min.js" type="text/javascript"></script>-->

	<!-- Get hosted copy of VideoJS or local -->
	<!--<script src="http://vjs.zencdn.net/c/video.js"></script>-->
	<!--<script>window.VideoJS || document.write('&lt;script src="{$workspace}/assets/js/videojs.js"><\/script>')</script>-->
	<!--<script>VideoJS.options.flash.swf = "<xsl:value-of select="$workspace"/>/assets/js/video-js/video-js.swf";</script>-->

	<script src="{$workspace}/assets/js/js-monkey.js" type="text/javascript"></script>
	
</xsl:template>


</xsl:stylesheet>
