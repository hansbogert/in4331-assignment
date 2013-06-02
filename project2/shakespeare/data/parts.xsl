<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exist="http://exist.sourceforge.net/NS/exist" version="1.0">
    <xsl:import href="shakes.xsl"/>
    <xsl:param name="act"/>
    <xsl:param name="char"/>
    <xsl:param name="scene"/>
    <xsl:template match="/">
        <h1>
                Parts for the <xsl:value-of select="$char"/>
                - act: <xsl:value-of select="$act"/>
                - scene: <xsl:value-of select="$scene"/>
        </h1>
        <xsl:apply-templates select="//ACT[position()=$act]"/>
    </xsl:template>
    <xsl:template match="ACT">
        <h2>
            <a href="{$this}#a{TITLE}">
                <xsl:apply-templates select="TITLE"/>
            </a>
        </h2>
        <xsl:if test="not($scene)">
            <xsl:apply-templates select="SCENE[SPEECH/SPEAKER=$char]"/>
        </xsl:if>
        <xsl:if test="$scene">
            <xsl:apply-templates select="SCENE[position()=$scene]"/>
        </xsl:if>
        <xsl:apply-templates select="SCENE[position()=$scene]"/>
    </xsl:template>
    <xsl:template match="SCENE">
        <h3>
            <a href="{$this}#s{TITLE}">
                <xsl:apply-templates select="TITLE"/>
            </a>
        </h3>
        <xsl:apply-templates select="SPEECH[SPEAKER=$char]"/>
    </xsl:template>
    <xsl:template match="SPEECH">
            ...
            <p>
            <xsl:apply-templates select="LINE"/>
        </p>
    </xsl:template>
</xsl:stylesheet>