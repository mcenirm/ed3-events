<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version='1.0'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
    xmlns:atom='http://www.w3.org/2005/Atom'
    xmlns:cap='urn:oasis:names:tc:emergency:cap:1.1'
    xmlns:ha='http://www.alerting.net/namespace/index_1.0'
    >
<xsl:output method='xml' indent='yes' omit-xml-declaration='yes'/>
<xsl:strip-space elements='*'/>
<xsl:template match='/'>
  <xsl:apply-templates select='atom:feed/atom:entry[normalize-space(cap:event)]'/>
</xsl:template>
<xsl:template match="atom:entry">
  <xsl:copy-of select='document(atom:link/@href)'/>
  <xsl:text>&#127;</xsl:text>
</xsl:template>
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>
</xsl:stylesheet>
