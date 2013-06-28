<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version='1.0' exclude-result-prefixes='nhc gml'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
    xmlns='urn:oasis:names:tc:emergency:cap:1.1'
    xmlns:cap='urn:oasis:names:tc:emergency:cap:1.1'
    xmlns:nhc='http://www.nhc.noaa.gov'
    xmlns:gml='http://www.opengis.net/gml'
    >
<xsl:output method='xml' indent='yes' omit-xml-declaration='yes'/>
<!--xsl:namespace-alias stylesheet-prefix='cap' result-prefix='#default'/-->
<xsl:strip-space elements='*'/>
<xsl:template match='/'>
  <xsl:apply-templates select='rss/channel/item[nhc:Cyclone]'/>
</xsl:template>
<xsl:template match='item'>
  <xsl:variable name='lon' select='substring-after(gml:Point/gml:pos," ")'/>
  <xsl:variable name='lat' select='substring-before(gml:Point/gml:pos," ")'/>
  <xsl:variable name='lonlat' select='concat($lon,",",$lat)'/>
  <xsl:variable name='dt1' select='normalize-space(nhc:Cyclone/nhc:datetime/text())'/>
  <xsl:variable name='dt-hour' select='substring-before($dt1,":")'/>
  <xsl:variable name='dt2' select='substring-after($dt1,":")'/>
  <xsl:variable name='dt-min' select='substring-before($dt2," ")'/>
  <xsl:variable name='dt3' select='substring-after($dt2," ")'/>
  <xsl:variable name='dt-ampm' select='substring-before($dt3," ")'/>
  <xsl:variable name='dt4' select='substring-after($dt3," ")'/>
  <xsl:variable name='dt-tz' select='substring-before($dt4," ")'/>
  <xsl:variable name='dt5' select='substring-after($dt4," ")'/>
  <xsl:variable name='dt-wd' select='substring-before($dt5," ")'/>
  <xsl:variable name='dt6' select='substring-after($dt5," ")'/>
  <xsl:variable name='dt-mon' select='document("lookup-months.xml")/lookup/month[@mmm = substring-before($dt6," ")]/@number'/>
  <xsl:variable name='dt-day' select='substring-after($dt6," ")'/>
  <xsl:variable name='dt-yr' select='substring(nhc:Cyclone/nhc:atcf,5)'/>
  <xsl:variable name='dt-hh'>
    <xsl:choose>
      <xsl:when test='$dt-ampm = "PM"'>
        <xsl:value-of select='$dt-hour + 12'/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select='format-number($dt-hour,"00")'/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name='dt-off' select='document("lookup-timezones.xml")/lookup/timezone[@zzz = $dt-tz]/@off'/>
  <xsl:variable name='dt' select='concat($dt-yr,"-",$dt-mon,"-",$dt-day,"T",$dt-hh,":",$dt-min,":00",$dt-off)'/>
  <xsl:element name='alert' namespace='urn:oasis:names:tc:emergency:cap:1.1'>
    <!--alert-->
    <identifier>
      <xsl:text>urn:</xsl:text>
      <xsl:value-of select='guid'/>
    </identifier>
    <sender>
      <xsl:value-of select='substring-before(../managingEditor," ")'/>
    </sender>
    <sent>
      <xsl:value-of select='$dt'/>
    </sent>
    <status>Actual</status>
    <msgType>Alert</msgType>
    <scope>Public</scope>
    <note>
      <xsl:value-of select='title'/>
    </note>
    <info>
      <category>Met</category>
      <event>
        <xsl:value-of select='nhc:Cyclone/nhc:type'/>
        <xsl:text> WARNING</xsl:text>
      </event>
      <urgency>Immediate</urgency>
      <severity>Severe</severity>
      <certainty>Observed</certainty>
      <eventCode>
        <valueName>SAME</valueName>
        <value>HUW</value>
      </eventCode>
      <!--
      <effective></effective>
      -->
      <senderName>National Hurricane Center</senderName>
      <headline>
        <xsl:value-of select='nhc:Cyclone/nhc:headline'/>
      </headline>
      <description>
        <xsl:value-of select='description'/>
      </description>
      <!--
      <instruction/>
      -->
      <parameter>
        <valueName>NHC Type</valueName>
        <value>
          <xsl:value-of select='nhc:Cyclone/nhc:type'/>
        </value>
      </parameter>
      <parameter>
        <valueName>Pressure</valueName>
        <value>
          <xsl:value-of select='nhc:Cyclone/nhc:pressure'/>
        </value>
      </parameter>
      <parameter>
        <valueName>Wind</valueName>
        <value>
          <xsl:value-of select='nhc:Cyclone/nhc:wind'/>
        </value>
      </parameter>
      <area>
        <areaDesc>
          <xsl:value-of select='$lonlat'/>
        </areaDesc>
        <polygon>
          <xsl:value-of select='$lonlat'/>
          <xsl:text> </xsl:text>
          <xsl:value-of select='$lonlat'/>
          <xsl:text> </xsl:text>
          <xsl:value-of select='$lonlat'/>
          <xsl:text> </xsl:text>
          <xsl:value-of select='$lonlat'/>
        </polygon>
      </area>
    </info>
    <!--/alert-->
  </xsl:element>
  <xsl:text>&#127;</xsl:text>
</xsl:template>
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>
