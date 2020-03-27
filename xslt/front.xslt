<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  <xsl:output encoding="UTF-8" method="xml" indent="yes" />
  <xsl:template match="/">
    <tei xml:space="preserve">
      <teiHeader>
        <fileDesc xml:id="0" />
      </teiHeader>
      <xsl:value-of select="/tei/header"></xsl:value-of>
      <text>
        <front>
          <xsl:copy-of select="/tei/text/front/node()" />
          <xsl:copy-of select="/tei/text/body/node()" />
        </front>
      </text>
    </tei>
  </xsl:template>
</xsl:stylesheet>
