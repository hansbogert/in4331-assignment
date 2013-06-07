<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exist="http://exist.sourceforge.net/NS/exist" version="1.0">
    <xsl:import href="shakes.xsl"/>
    <xsl:template match="PLAY">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('plays/',PLAYSUBT,'.html')"/>
            </xsl:attribute>
            <xsl:apply-templates select="TITLE"/>
        </a>
        A play by William Shakespeare
        <xsl:apply-templates select="PERSONAE"/>
        <h2>Stage directions</h2>
        <ul>
            <xsl:apply-templates select="//STAGEDIR"/>
        </ul>
    </xsl:template>
    <xsl:template match="STAGEDIR">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
</xsl:stylesheet>