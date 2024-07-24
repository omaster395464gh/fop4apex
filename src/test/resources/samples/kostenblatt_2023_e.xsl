<?xml version = '1.0' encoding = 'utf-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink">
    <!-- Oliver.Warz@pdv.de
         TMIL / TLBV
         2024-03-16 Stand 2023 hybrid  https://tlf.thueringen.de/fileadmin/tlf/fahrdienst/DKfzRL_Stand_2023_-_nichtamtl._Lesefassung.pdf
		 2022-06-25 Halter dynamisch
		 2022-04-26 Kostenblatt 2020 Hybrid / Prozentzeichen entfernt
		 2021-09-14 Kostenblatt 2020 Hybrid
         2019-02-08 Initiale Version
    -->
    <xsl:variable name="_XDOFOPOS" select="''"/>
    <xsl:variable name="_XDOFOPOS2" select="number(1)"/>
    <xsl:variable name="_XDOFOTOTAL" select="number(1)"/>
    <xsl:variable name="_XDOFOOSTOTAL" select="number(0)"/>
    <xsl:attribute-set name="padding">
        <xsl:attribute name="padding-bottom">0.25pt</xsl:attribute>
        <xsl:attribute name="padding-top">0.25pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="text">
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="orphans">2</xsl:attribute>
        <xsl:attribute name="start-indent">0.0pt</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="padding-top">0.0pt</xsl:attribute>
        <xsl:attribute name="end-indent">0.0pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">0.0pt</xsl:attribute>
        <xsl:attribute name="height">0.0pt</xsl:attribute>
        <xsl:attribute name="widows">2</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="align-left">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="align-center">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="align-right">
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footer">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="start-indent">5.4pt</xsl:attribute>
        <xsl:attribute name="end-indent">5.4pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="text_2">
        <xsl:attribute name="start-indent">5.4pt</xsl:attribute>
        <xsl:attribute name="end-indent">23.4pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="text_20">
        <xsl:attribute name="height">13.872pt</xsl:attribute>
        <xsl:attribute name="end-indent">5.4pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="text_0">
        <xsl:attribute name="end-indent">5.4pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="page-header">
    </xsl:attribute-set>
    <xsl:attribute-set name="page-footer">
    </xsl:attribute-set>
    <xsl:attribute-set name="body-font">
    </xsl:attribute-set>
    <xsl:attribute-set name="page-number">
        <xsl:attribute name="height">13.872pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="header-font">
        <xsl:attribute name="white-space-collapse">false</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="border">
        <xsl:attribute name="border-start-style">solid</xsl:attribute>
        <xsl:attribute name="border-end-style">solid</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell">
        <xsl:attribute name="padding-start">5.15pt</xsl:attribute>
        <xsl:attribute name="vertical-align">top</xsl:attribute>
        <xsl:attribute name="padding-top">0.0pt</xsl:attribute>
        <xsl:attribute name="padding-end">5.15pt</xsl:attribute>
        <xsl:attribute name="number-columns-spanned">1</xsl:attribute>
        <xsl:attribute name="height">0.0pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">0.0pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="header-color">
    </xsl:attribute-set>
    <!-- Attribut-Sets fuer Tabellenzellen -->
    <xsl:attribute-set name="cell-style">
        <xsl:attribute name="font-size">7pt</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="block-style">
        <xsl:attribute name="font-size">7pt</xsl:attribute>
        <xsl:attribute name="line-height">16pt</xsl:attribute>
        <xsl:attribute name="start-indent">1mm</xsl:attribute>
        <xsl:attribute name="end-indent">  1mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="block-style-5">
        <xsl:attribute name="font-size">6pt</xsl:attribute>
        <xsl:attribute name="line-height">16pt</xsl:attribute>
        <xsl:attribute name="start-indent">1mm</xsl:attribute>
        <xsl:attribute name="end-indent">  1mm</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="block-style-8">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="line-height">16pt</xsl:attribute>
        <xsl:attribute name="start-indent">1mm</xsl:attribute>
        <xsl:attribute name="end-indent">  1mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="block-style-none">
        <xsl:attribute name="start-indent">1mm</xsl:attribute>
        <xsl:attribute name="end-indent">  1mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="block-style-none">
        <xsl:attribute name="start-indent">1mm</xsl:attribute>
        <xsl:attribute name="end-indent">  1mm</xsl:attribute>
    </xsl:attribute-set>
   
    <xsl:attribute-set name="cell-style-header-a">
        <xsl:attribute name="font-size">8.0pt</xsl:attribute>
        <xsl:attribute name="height">8.0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Helvetica</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="background-color">#d6d6d6</xsl:attribute>      
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell-style-header-b">
        <xsl:attribute name="font-size">6.0pt</xsl:attribute>
        <xsl:attribute name="height">6.0pt</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>      
        <xsl:attribute name="background-color">#e3e3e3</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell-style-text-black">
        <xsl:attribute name="font-size">14.0pt</xsl:attribute>
        <xsl:attribute name="height">14.0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Helvetica</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell-style-text-red">
        <xsl:attribute name="font-size">14.0pt</xsl:attribute>
        <xsl:attribute name="height">14.0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Helvetica</xsl:attribute>
        <xsl:attribute name="border-width">0.0pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="color">#E83716</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell-style-text-none">
        <xsl:attribute name="font-size">3pt</xsl:attribute>
        <xsl:attribute name="height">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Helvetica</xsl:attribute>
        <xsl:attribute name="border-width">0.0pt</xsl:attribute>
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell-style-text-8">
        <xsl:attribute name="font-size">8.0pt</xsl:attribute>
        <xsl:attribute name="height">8.0pt</xsl:attribute>
        <xsl:attribute name="font-family">Helvetica</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cell-style-text-7">
        <xsl:attribute name="font-size">7pt</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
    </xsl:attribute-set>
   
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="master0" margin-left="60.6pt" margin-right="66.6pt" page-height="595.3pt" page-width="841.9pt" margin-top="16.0pt" margin-bottom="16.0pt">
                    <fo:region-body region-name="region-body" margin-top="24.0pt" margin-bottom="34.0pt"/>
                    <fo:region-before region-name="region-header" extent="54.0pt"/>
                    <fo:region-after region-name="region-footer" extent="54.0pt" display-align="after"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="master0">
                <xsl:variable name="_PW" select="number(841.9)"/>
                <xsl:variable name="_PH" select="number(595.3)"/>
                <xsl:variable name="_ML" select="number(72.0)"/>
                <xsl:variable name="_MR" select="number(72.0)"/>
                <xsl:variable name="_MT" select="number(90.0)"/>
                <xsl:variable name="_MB" select="number(90.0)"/>
                <xsl:variable name="_HY" select="number(36.0)"/>
                <xsl:variable name="_FY" select="number(36.0)"/>
                <xsl:variable name="_SECTION_NAME" select="string('master0')"/>
                <!--                <fo:static-content flow-name="region-footer">
                                    <fo:block xsl:use-attribute-sets="text footer">
                                        <fo:inline xsl:use-attribute-sets="body-font page-number">
                                            <fo:page-number/>
                                        </fo:inline>
                                    </fo:block>
                                    <fo:block xsl:use-attribute-sets="text text_2">
                                        <fo:inline xsl:use-attribute-sets="page-footer">PAGE_FOOTER</fo:inline>
                                    </fo:block>
                                </fo:static-content>
                -->
                <fo:flow flow-name="region-body">
                    <fo:table border-style="none" table-layout="fixed" width="100">
                        <fo:table-column column-width="5.4cm"/>
                        <fo:table-column column-width="15.7cm"/>
                        <fo:table-column column-width="4.8cm"/>
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="left">Amtliches Kennzeichen</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>                                             
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="center"></fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="left" >Jahr</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-text-black">
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">
                                        <xsl:value-of select="//KENNZEICHEN"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-text-red">  
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">
                                        <fo:inline>Dienstkraftfahrzeug-Kostenblatt (Elektrofahrzeuge)</fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-text-black">
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">
                                        <xsl:value-of select="//JAHR"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-text-none">
                                    <fo:block/>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-text-none">
                                    <fo:block/>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-text-none">
                                    <fo:block/>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                    <fo:table border-style="solid" table-layout="fixed" width="100">
                        <fo:table-column column-width="0.6cm"/>
                        <fo:table-column column-width="3.6cm"/>
                        <fo:table-column column-width="1.2cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.66cm"/>                  
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="center"></fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-a" number-columns-spanned="15">
                                    <fo:block xsl:use-attribute-sets="block-style-none" text-align="left"  >allgemeine Angaben</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right">1</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"  >Eigentümer</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">LAND</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">Halterdienststelle</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right"><xsl:value-of select="//LABEL_HALTER"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">Nutzung</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style-5" text-align="right" >(Nah/Fern)</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style"  number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//NUTZUNG"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right">2</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"  >Fahrzeugart und -typ</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//FAHRZEUGTYP"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">Anschaffungskosten EUR</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//NEUPREIS"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b"  number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">Fahrzeug-Ident-Nr</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style"  number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//FAHRGESTELLNR"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right">3</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"  >Erstzulassung</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style-5" text-align="right" >(Datum)</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//DAT_ZULASSUNG"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">Übernahme</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//DAT_UEBERNAHME"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b"  number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">Aussonderung</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style"  number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//DAT_AUSSONDERUNG"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
 
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right">4</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"  >überwiegend Selbstfahrer?</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//FAHRERTYP_SELBSTFAHRER"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"></fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right"></fo:block>
                                </fo:table-cell>

                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"></fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style"  number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right"></fo:block>
                                </fo:table-cell>

                            </fo:table-row>

                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right">5</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left"  >km-Stand Jahresanfang</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//KMSTAND_JA"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">km-Stand Jahresende</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//KMSTAND_JE"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style-header-b" number-columns-spanned="2">
                                    <!-- <fo:block xsl:use-attribute-sets="block-style" text-align="left">Auslastungsquote (x)</fo:block> -->
									<fo:block xsl:use-attribute-sets="block-style" text-align="left"><xsl:value-of select="//LABEL_AUSLASTUNGSQUOTE"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell-style"  number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                                        <xsl:value-of select="//AUSLASTUNGSQUOTE"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>                                                                                   
                        </fo:table-body>
                    </fo:table>
                    <xsl:apply-templates/>

                    <fo:table border-style="none" table-layout="fixed" width="100">
                        <fo:table-column column-width="0.6cm"/>
                        <fo:table-column column-width="3.6cm"/>
                        <fo:table-column column-width="1.2cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.57cm"/>
                        <fo:table-column column-width="1.66cm"/>  
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell xsl:use-attribute-sets="cell">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right"/>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell" number-columns-spanned="2">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="left">DKfzRL (Anlage 2a); Stand: 2023</fo:block>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell" number-columns-spanned="10">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="center"/>
                                </fo:table-cell>
                                <fo:table-cell xsl:use-attribute-sets="cell" number-columns-spanned="3">
                                    <fo:block xsl:use-attribute-sets="block-style" text-align="right">
                                        <xsl:value-of select="//DATUM"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

                    <fo:block id="LastPage"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>  
   
    <!-- Tabellenkopf -->
    <xsl:template name="table-head">
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center"></fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="left"  >Einsatz</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="right" >Monat</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Jan</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Feb</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Mrz</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Apr</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Mai</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Jun</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Jul</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Aug</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Sep</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Okt</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Nov</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Dez</fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-none" text-align="center">Summen</fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template match="ROWSET">
        <fo:table border-style="solid" table-layout="fixed" width="100">
            <fo:table-column column-width="0.6cm"/>
            <fo:table-column column-width="3.6cm"/>
            <fo:table-column column-width="1.2cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.57cm"/>
            <fo:table-column column-width="1.66cm"/>
            <fo:table-header>
                <xsl:call-template name="table-head"/>
            </fo:table-header>
            <fo:table-body>
                <xsl:apply-templates select="ROW"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="ROW">
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                <fo:block xsl:use-attribute-sets="block-style" text-align="right">
                    <xsl:value-of select="DATEN_NO"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                <fo:block xsl:use-attribute-sets="block-style" text-align="left"> 
                    <xsl:value-of select="EINSATZ"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-b">
                <fo:block xsl:use-attribute-sets="block-style-5" text-align="right">
                    <xsl:value-of select="EINHEIT"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="JAN"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="FEB"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="MRZ"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="APR"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="MAI"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="JUN"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="JUL"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="AUG"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="SEP"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="OKT"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="NOV"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell-style">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="DEZ"/>
                </fo:block>
            </fo:table-cell>
            <!--            <xsl:variable name="r" select="position()"/>
            <xsl:if test="$r mod 17 = 0"><xsl:attribute name="page-break-after">always</xsl:attribute></xsl:if>
            -->
            <fo:table-cell xsl:use-attribute-sets="cell-style-header-a">
                <fo:block xsl:use-attribute-sets="block-style-8" text-align="right">
                    <xsl:value-of select="SUMME"/><!--xx <xsl:value-of select="$r"/><xsl:if test="$r mod 17 = 0">break</xsl:if>--> 
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
</xsl:stylesheet>
