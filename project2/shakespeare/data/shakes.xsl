<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exist="http://exist.sourceforge.net/NS/exist" version="1.0">
    <xsl:variable name="play" select="PLAY/PLAYSUBT"/>
    <xsl:variable name="this" select="concat('plays/', $play,'.html')"/>
    <xsl:template match="PLAY/TITLE">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    <xsl:template match="PLAY">
        <xsl:apply-templates select="TITLE"/>
        <xsl:apply-templates select="PLAYSUBT"/>
        <p>
            <b>Table of Contents</b>
        </p>
        <ul>
            <xsl:for-each select="ACT">
                <xsl:variable name="act" select="./position()"/>
                <li>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat($this,'#', generate-id())"/>
                        </xsl:attribute>
                        <xsl:value-of select="TITLE"/>
                    </a>
                </li>
                <ul>
                    <xsl:call-template name="toc_scene">
                        <xsl:with-param name="act" select="position()"/>
                    </xsl:call-template>
                </ul>
            </xsl:for-each>
        </ul>
        <xsl:apply-templates select="PERSONAE"/>
        <xsl:apply-templates select="ACT"/>
    </xsl:template>
    <xsl:template name="toc_scene">
        <xsl:param name="act"/>
        <xsl:for-each select="SCENE">
            <li>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat($this, '#', generate-id())"/>
                    </xsl:attribute>
                    <xsl:value-of select="TITLE"/>
                </a>
                <ul>
                    <xsl:call-template name="toc_speaker">
                        <xsl:with-param name="act" select="$act"/>
                        <xsl:with-param name="scene" select="position()"/>
                    </xsl:call-template>
                </ul>
            </li>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="toc_speaker">
        <xsl:param name="act"/>
        <xsl:param name="scene"/>
        <xsl:for-each select="distinct-values(SPEECH/SPEAKER)">
            <li>
                <a href="parts/{$play}/{.}/{$act}/{$scene}">
                    <xsl:value-of select="."/>
                </a>
                <a href="parts/{$play}/{.}/{$act}/" class="smaller">
                 (act-parts)
                </a>
            </li>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="PERSONAE">
        <hr/>
        <h2>
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <xsl:value-of select="TITLE"/>
            </a>
        </h2>
        <table border="0" cellpadding="5">
            <xsl:apply-templates select="PERSONA|PGROUP"/>
        </table>
    </xsl:template>
    <xsl:template match="ACT">
        <hr/>
        <h1>
            <a id="a{TITLE}">
                <xsl:attribute name="name">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <xsl:value-of select="TITLE"/>
            </a>
        </h1>
        <xsl:apply-templates select="SCENE">
            <xsl:with-param name="act" select="TITLE"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="SCENE">
        <xsl:param name="act"/>
        <h3>
            <a id="s{TITLE}">
                <xsl:attribute name="name">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <xsl:value-of select="TITLE"/>
            </a>
        </h3>
        <xsl:apply-templates select="SPEECH|STAGEDIR"/>
    </xsl:template>
    <xsl:template match="SPEECH">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <td width="20%" valign="top">
                    <div class="speaker">
                        <a href="plays/{$play}#p{SPEAKER}">
                            <xsl:apply-templates select="SPEAKER"/>
                        </a>
                    </div>
                </td>
                <td width="4%"/>
                <td width="76%" valign="top">
                    <verse>
                        <xsl:apply-templates select="LINE|STAGEDIR"/>
                    </verse>
                </td>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="SPEAKER">
        <xsl:value-of select="text()"/>
        <br/>
    </xsl:template>
    <xsl:template match="LINE">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="LINE/STAGEDIR">[<b>
            <xsl:apply-templates/>
        </b>]</xsl:template>
    <xsl:template match="SCENE/STAGEDIR">
        <tr>
            <td colspan="3">
                <b>
                    <xsl:apply-templates/>
                </b>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="SUBHEAD">
        <tr>
            <td colspan="3">
                <h4>
                    <xsl:apply-templates/>
                </h4>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="PLAYSUBT">
        <h3>
            <em>
                <xsl:apply-templates/>
            </em>
        </h3>
    </xsl:template>
    <xsl:template match="SCNDESCR">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    <xsl:template match="PERSONAE/PERSONA">
        <tr>
            <td id="p{text()}" colspan="2">
                <xsl:apply-templates/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="PGROUP">
        <tr>
            <td>
                <xsl:for-each select="PERSONA">
                    <span id="p{text()}">
                        <xsl:value-of select="text()"/>
                    </span>
                    <br/>
                </xsl:for-each>
            </td>
            <td>
                <xsl:value-of select="GRPDESCR"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="P">
        <tt>
            <xsl:apply-templates/>
        </tt>
        <br/>
    </xsl:template>
</xsl:stylesheet>