<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:p="http://www.evolus.vn/Namespace/Pencil"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                </title>
                <link rel="stylesheet" type="text/css" href="Resources/style.css"/>
                <script type="text/javascript" src="Resources/path.min.js">
                    //
                </script>
            </head>
            <body>
                <xsl:apply-templates select="/p:Document/p:Pages/p:Page" />

                <script type="text/javascript" src="Resources/main.js">
                    //
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="p:Page">
        <div class="page" id="{p:Properties/p:Property[@name='fid']/text()}">
            <img src="pages/{p:Properties/p:Property[@name='fid']/text()}.png"
                width="{p:Properties/p:Property[@name='width']/text()}"
                height="{p:Properties/p:Property[@name='height']/text()}"
                usemap="#map_{p:Properties/p:Property[@name='fid']/text()}"/>
            <xsl:if test="p:Note/node()">
                <div class="notes">
                    <span class="open" title="Show Notes">?</span>
                    <span class="close" title="Hide Notes">X</span>
                    <div class="content">
                        <xsl:apply-templates select="p:Note/node()" mode="processing-notes"/>
                    </div>
                </div>
            </xsl:if>
            <map name="map_{p:Properties/p:Property[@name='fid']/text()}">
                <xsl:apply-templates select="p:Links/p:Link" />
            </map>
        </div>
    </xsl:template>

    <xsl:template match="p:Link">
        <area shape="rect"
            coords="{@x},{@y},{@x+@w},{@y+@h}" href="#/page/{@targetFid}" title="{@targetName}"/>
    </xsl:template>
    
    <xsl:template match="html:*" mode="processing-notes">
        <xsl:copy>
            <xsl:copy-of select="@*[local-name() != '_moz_dirty']"/>
            <xsl:apply-templates mode="processing-notes"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="html:a[@page-fid]" mode="processing-notes">
        <a href="#/page/{@page-fid}" title="{@page-name}">
            <xsl:copy-of select="@class|@style"/>
            <xsl:apply-templates mode="processing-notes"/>
        </a>
    </xsl:template>
</xsl:stylesheet>
