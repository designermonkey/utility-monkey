<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Date and Time utilities collection

	@package	Utility Monkey
	@author		John Porter <john@designermonkey.co.uk>
	@license	CC0 <http://creativecommons.org/publicdomain/zero/1.0/>
-->


<!--
	Get UTC From ISO Datetime
	Output a UTC (GMT0) Date and Time from any ISO-8601 Date and Time

	@param datetime	Accepts any ISO-8601 Date and Time with any timezone adjustment (eg. 2012-10-09T16:19:00+04:00)
	@return			Outputs a UTC (GMT0) Date and Time (eg. 2012-10-09T12:19:00+00:00)
-->
<xsl:template name="get-utc-from-iso-datetime">
	
	<xsl:param name="datetime"/>

	<xsl:variable name="modifier" select="substring($datetime, 20, 1)"/>
	<xsl:variable name="modify-by" select="number(substring($datetime, 21, 2))"/>
	<xsl:variable name="day" select="number(substring($datetime, 9, 2))"/>
	<xsl:variable name="hour" select="number(substring($datetime, 12, 2))"/>

	<xsl:variable name="output-day">
		<xsl:choose>
			<xsl:when test="($modifier = '-') and ((24 - $hour) &lt; $modify-by)">
				<xsl:value-of select="format-number(($day + 1), '00')"/>
			</xsl:when>
			<xsl:when test="($modifier = '+') and ($hour &lt; $modify-by)">
				<xsl:value-of select="format-number(($day - 1), '00')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($day, '00')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="output-hour">
		<xsl:choose>
			<xsl:when test="($modifier = '-') and (($hour + $modify-by) &gt; 24)">
				<xsl:value-of select="format-number(($modify-by - (24 - $hour)), '00')"/>
			</xsl:when>
			<xsl:when test="($modifier = '-') and (($hour + $modify-by) &lt; 24)">
				<xsl:value-of select="format-number(($hour + $modify-by), '00')"/>
			</xsl:when>
			<xsl:when test="($modifier = '+') and ($hour &lt; $modify-by)">
				<xsl:value-of select="format-number((24 - ($modify-by - $hour)), '00')"/>
			</xsl:when>
			<xsl:when test="($modifier = '+') and ($hour &gt; $modify-by)">
				<xsl:value-of select="format-number(($hour - $modify-by), '00')"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:value-of select="concat(substring($datetime,1,8),$output-day,'T',$output-hour,substring($datetime,14,6),'+00:00')"/>

</xsl:template>


<!--
	Get UTC From a String Datetime
	Output a UTC (GMT0) Date and Time from any ISO-8601 Date and Time

	@param datetime	Accepts a String Date and Time (eg. Mon, 09 Oct 2012 16:19:00 +0400)
	@return			Outputs an ISO-8601 Date and Time (eg. 2012-10-09T16:19:00+04:00)
-->
<xsl:template name="get-utc-from-string-datetime">
	
	<xsl:param name="datetime"/>

	<xsl:variable name="year" select="substring($datetime, 13, 4)"/>
	<xsl:variable name="month">
		<xsl:choose>
			<xsl:when test="contains($datetime,'Jan')">01</xsl:when>
			<xsl:when test="contains($datetime,'Feb')">02</xsl:when>
			<xsl:when test="contains($datetime,'Mar')">03</xsl:when>
			<xsl:when test="contains($datetime,'Apr')">04</xsl:when>
			<xsl:when test="contains($datetime,'May')">05</xsl:when>
			<xsl:when test="contains($datetime,'Jun')">06</xsl:when>
			<xsl:when test="contains($datetime,'Jul')">07</xsl:when>
			<xsl:when test="contains($datetime,'Aug')">08</xsl:when>
			<xsl:when test="contains($datetime,'Sep')">09</xsl:when>
			<xsl:when test="contains($datetime,'Oct')">10</xsl:when>
			<xsl:when test="contains($datetime,'Nov')">11</xsl:when>
			<xsl:when test="contains($datetime,'Dec')">12</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="day" select="substring($datetime, 6, 2)"/>
	<xsl:variable name="time" select="substring($datetime, 18, 8)"/>
	<xsl:variable name="zone" select="substring($datetime, 27, 3)"/>

	<xsl:value-of select="concat($year,'-',$month,'-',$day,'T',$time,$zone,':00')"/>

</xsl:template>


</xsl:stylesheet>
