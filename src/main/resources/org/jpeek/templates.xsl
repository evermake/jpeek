<?xml version="1.0"?>
<!--
The MIT License (MIT)

Copyright (c) 2017 Yegor Bugayenko

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:template name="html">
    <xsl:param name="body"/>
    <xsl:param name="title"/>
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="description" content="jpeek metrics"/>
        <meta name="keywords" content="code quality metrics"/>
        <meta name="author" content="jpeek.org"/>
        <link rel="shortcut icon" href="http://www.jpeek.org/logo.png"/>
        <link rel="stylesheet" href="http://cdn.rawgit.com/yegor256/tacit/gh-pages/tacit-css-1.1.1.min.css"/>
        <link rel="stylesheet" href="jpeek.css"/>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/sortable/0.8.0/js/sortable.min.js">&#xA0;</script>
        <title>
          <xsl:value-of select="$title"/>
        </title>
      </head>
      <body>
        <p>
          <a href="http://i.jpeek.org">
            <img alt="logo" src="http://www.jpeek.org/logo.svg" style="height:60px"/>
          </a>
        </p>
        <xsl:apply-templates select="$body"/>
        <footer style="color:gray;font-size:75%;">
          <p>
            <xsl:text>This report was generated by </xsl:text>
            <a href="http://www.jpeek.org">
              <xsl:text>jpeek </xsl:text>
              <xsl:value-of select="$body/@version"/>
            </a>
            <xsl:text> on </xsl:text>
            <xsl:value-of select="$body/@date"/>
            <xsl:text>.</xsl:text>
          </p>
        </footer>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="color">
    <xsl:param name="name"/>
    <xsl:choose>
      <xsl:when test="$name='red'">
        <xsl:text>red</xsl:text>
      </xsl:when>
      <xsl:when test="$name='green'">
        <xsl:text>green</xsl:text>
      </xsl:when>
      <xsl:when test="$name='yellow'">
        <xsl:text>orange</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>inherit</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="bars">
    <xsl:param name="bars"/>
    <xsl:param name="w"/>
    <xsl:param name="h"/>
    <div>
      <xsl:attribute name="style">
        <xsl:text>background-color:#e8e8ee;</xsl:text>
        <xsl:text>border: 1px solid #ccc;</xsl:text>
        <xsl:text>position:relative;</xsl:text>
        <xsl:text>width:</xsl:text>
        <xsl:value-of select="$w + 4"/>
        <xsl:text>px;height:</xsl:text>
        <xsl:value-of select="$h + 4"/>
        <xsl:text>px;</xsl:text>
      </xsl:attribute>
      <xsl:if test="$bars/bar">
        <xsl:variable name="width" select="$w div count($bars/bar)"/>
        <xsl:variable name="max" select="max($bars/bar)"/>
        <xsl:for-each select="$bars/bar">
          <div>
            <xsl:attribute name="style">
              <xsl:text>position:absolute;</xsl:text>
              <xsl:text>background-color:</xsl:text>
              <xsl:call-template name="color">
                <xsl:with-param name="name" select="@color"/>
              </xsl:call-template>
              <xsl:text>;bottom:1px;</xsl:text>
              <xsl:text>width:</xsl:text>
              <xsl:value-of select="$width"/>
              <xsl:text>;left:</xsl:text>
              <xsl:value-of select="@x * $w + 1"/>
              <xsl:text>px;height:</xsl:text>
              <xsl:value-of select="$h * . div $max"/>
              <xsl:text>px;</xsl:text>
            </xsl:attribute>
          </div>
        </xsl:for-each>
      </xsl:if>
    </div>
  </xsl:template>
</xsl:stylesheet>
