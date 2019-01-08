<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>

    <xsl:template match="/documentation">
        <html>
            <head>
                <title><xsl:value-of select="@title"/></title>
                <link rel="stylesheet" href="documentation.css" type="text/css"/>
            </head>

            <body>
                <h1><xsl:value-of select="@title"/></h1>
                <xsl:apply-templates select="." mode="toc" />
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/documentation" mode="toc">
        <xsl:for-each select="section">
            <a>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@key" />
                </xsl:attribute>
                <xsl:number format="1 " level="multiple" />
                <xsl:value-of select="@title" />
            </a><br/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="section">
        <a><xsl:attribute name="name"><xsl:value-of select="@key" /></xsl:attribute></a>

        <xsl:variable name="titleSize"><xsl:value-of select="count(ancestor::section) + 2" /></xsl:variable>
        <xsl:element name="h{$titleSize}">
            <xsl:number format="1 " level="multiple" />
            <xsl:value-of select="@title"/>
        </xsl:element>

        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="itemization">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>

    <xsl:template match="item">
        <li><xsl:apply-templates/></li>
    </xsl:template>

    <xsl:template match="bold">
        <span class="bold"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="italic">
        <span class="italic"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="code">
        <div class="code"><xsl:value-of select="."/></div>
    </xsl:template>

    <xsl:template match="ref">
        <xsl:variable name="searchedKey" select="@key"/>
        <xsl:variable name="foundTitle">
            <xsl:value-of select="//section[@key=$searchedKey]/@title"/>
        </xsl:variable>

        <a>
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="@key"/>
            </xsl:attribute>
            <xsl:value-of select="$foundTitle"/>
        </a>
    </xsl:template>

</xsl:stylesheet>
