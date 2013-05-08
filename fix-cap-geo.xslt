<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version='1.0'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
    xmlns='urn:oasis:names:tc:emergency:cap:1.1'
    xmlns:cap='urn:oasis:names:tc:emergency:cap:1.1'
    exclude-result-prefixes="cap"
    >
<xsl:output method='xml' indent='yes' omit-xml-declaration='yes'/>
<xsl:strip-space elements='*'/>
<xsl:param name='gazurl'/>
<xsl:template match='cap:area[not(normalize-space(cap:polygon))]'>
  <xsl:copy>
    <xsl:apply-templates select='cap:areaDesc'/>
    <xsl:apply-templates select='cap:polygon[normalize-space(.)]'/>
    <xsl:for-each select='cap:geocode'>
      <xsl:apply-templates mode='fix' select='document(concat($gazurl,"/",cap:valueName,"/",cap:value))'/>
    </xsl:for-each>
    <xsl:apply-templates select='cap:circle[normalize-space(.)]'/>
    <xsl:apply-templates select='cap:geocode'/>
    <xsl:apply-templates select='cap:altitude'/>
    <xsl:apply-templates select='cap:ceiling'/>
  </xsl:copy>
</xsl:template>
<xsl:template mode='fix' match='cap:area[cap:areaDesc != "Not found"]'>
  <polygon>
    <xsl:value-of select='cap:geocode[cap:valueName = "longitude"]/cap:value'/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "latitude"]/cap:value'/>
    <xsl:text> </xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "longitude"]/cap:value'/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "latitude"]/cap:value'/>
    <xsl:text> </xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "longitude"]/cap:value'/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "latitude"]/cap:value'/>
    <xsl:text> </xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "longitude"]/cap:value'/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select='cap:geocode[cap:valueName = "latitude"]/cap:value'/>
  </polygon>
</xsl:template>
<xsl:template mode='fix' match='cap:area[cap:areaDesc = "Not found"]'/>
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>
