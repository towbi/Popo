<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:movb="http://movb.de">

    <xsl:output method="html"
        doctype-system="about:legacy-compat"
        encoding="UTF-8"
        indent="yes" />

    <!-- localization -->
    <xsl:variable name="lang" select="'en'"/>
    <xsl:variable name="lang.name" select="'Project name'"/>
    <xsl:variable name="lang.role" select="'Role'"/>
    <xsl:variable name="lang.period" select="'Time period'"/>
    <xsl:variable name="lang.time" select="'Time'"/>
    <xsl:variable name="lang.work" select="'Work'"/>
    <xsl:variable name="lang.employer" select="'Employer'"/>
    <xsl:variable name="lang.tooling" select="'Tooling'"/>
    <xsl:variable name="lang.agency" select="'Agency'"/>
    <xsl:variable name="lang.endcustomer" select="'End customer'"/>
    <xsl:variable name="lang.description" select="'Description'"/>
    <xsl:variable name="lang.url" select="'URL'"/>
    <xsl:variable name="lang.profileof" select="'Profile of'"/>
    <xsl:variable name="lang.search" select="'Search'"/>

    <!-- function that either picks the node with the correct language or the
         one without a lang attribute -->
    <xsl:function name="movb:getstr">
        <xsl:param name="node" />
        <xsl:for-each select="$node">
            <xsl:if test="lang($lang)">
                <xsl:value-of select="$node[lang($lang)]" />
            </xsl:if>
        </xsl:for-each>
        <xsl:value-of select="$node[not(@xml:lang)]" />
    </xsl:function>

    <!-- TODO: if there is no agency, the endcustomer is just a customer -->

    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//profile/@title"/></title>
                <link rel="stylesheet" href="profile.css" />
                <!-- <link href='http://fonts.googleapis.com/css?family=Roboto:300' rel='stylesheet' type='text/css' /> -->
            </head>
            <body>
                <div id="wrappy">
                    <div id="container">
                        <div class="cell head">
                            <h1>
                                <xsl:value-of select="$lang.profileof" /> 
                                <xsl:text disable-output-escaping="yes"> </xsl:text>
                                <xsl:value-of select="//profile/@title"/>
                            </h1>
                            <input type="text">
                                <xsl:attribute name="placeholder"><xsl:value-of select="$lang.search" /></xsl:attribute>
                            </input>
                            <a href="javascript:clearSearch()" title="clear search"><img src="img/Gnome-edit-clear.svg" /></a>
                        </div>
                        <xsl:for-each select="profile/unit">
                            <xsl:sort select="endtime" order="descending" />

                            <div class="cell">
                                <xsl:attribute name="data-endtime"><xsl:value-of select="movb:getstr(endtime)" /></xsl:attribute>
                                <div class="work">
                                    <span class="heading"><xsl:value-of select="movb:getstr(work)" /></span>
                                </div>

                                <div class="content">
                                    <table>
                                        <xsl:attribute name="class">
                                            profile
                                            <xsl:if test="position() = 1">
                                                grid-sizer
                                            </xsl:if>
                                        </xsl:attribute>

                                        <xsl:if test="name">
                                            <tr>
                                                <th><xsl:value-of select="$lang.name" /></th>
                                                <td><xsl:value-of select="movb:getstr(name)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="role">
                                            <tr>
                                                <th><xsl:value-of select="$lang.role" /></th>
                                                <td><xsl:value-of select="movb:getstr(role)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="tooling">
                                            <tr>
                                                <th><xsl:value-of select="$lang.tooling" /></th>
                                                <td><xsl:value-of select="movb:getstr(tooling)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="agency">
                                            <tr>
                                                <th><xsl:value-of select="$lang.agency" /></th>
                                                <td><xsl:value-of select="movb:getstr(agency)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="employer">
                                            <tr>
                                                <th><xsl:value-of select="$lang.employer" /></th>
                                                <td><xsl:value-of select="movb:getstr(employer)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="endcustomer">
                                            <tr>
                                                <th><xsl:value-of select="$lang.endcustomer" /></th>
                                                <td><xsl:value-of select="movb:getstr(endcustomer)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="description">
                                            <tr>
                                                <th><xsl:value-of select="$lang.description" /></th>
                                                <td><xsl:value-of select="movb:getstr(description)" /></td>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="endtime">
                                            <tr>
                                                <xsl:choose>
                                                    <xsl:when test="starttime">
                                                        <th><xsl:value-of select="$lang.period" /></th>
                                                        <td>
                                                            <xsl:value-of select="movb:getstr(starttime)" /> – <xsl:value-of select="movb:getstr(endtime)" />
                                                        </td>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <th><xsl:value-of select="$lang.time" /></th>
                                                        <td><xsl:value-of select="movb:getstr(endtime)" /></td>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </tr>
                                        </xsl:if>

                                        <xsl:if test="url">
                                            <tr>
                                                <th><xsl:attribute name='rowspan' select='count(url)' /><xsl:value-of select="$lang.url" /></th>
                                                <td><a><xsl:attribute name="href" select="movb:getstr(url[1])" /><xsl:value-of select="movb:getstr(url[1])" /></a></td>
                                            </tr>
                                            <xsl:for-each select="url">
                                                <xsl:if test="position() > 1">
                                                    <tr><td><a><xsl:attribute name="href" select="movb:getstr(.)" /><xsl:value-of select="movb:getstr(.)" /></a></td></tr>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </xsl:if>

                                    </table>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
                <script src="js/jquery-2.1.1.min.js"></script>
                <script src="js/isotope.pkgd.min.js"></script>
                <script>
                    // HSV gradient (generated here: http://www.perbang.dk/rgbgradient/)
                    var colors = ['#F4F2D7', '#EDF3D7', '#E4F3D7', '#DCF3D7', '#D7F3DB', '#D7F3E3',
                                  '#D7F3EB', '#D7F2F3', '#D7EAF3', '#D7E2F3'];

                    var iso = new Isotope('#container', {
                        itemSelector: '.cell',
                        masonry: {
                            columnWidth: '.grid-sizer',
                            isFitWidth: true,
                            gutter: 10
                        }
                    });

                    function sanitizeInput(str) {
                        // \[]()+*.^$?:|{}
                    }

                    var $searchInput = $(".head input");

                    function clearSearch() {
                        $searchInput.val('');
                        iso.arrange({filter: '*'});
                    }

                    $searchInput.on('keyup', function() {
                        var searchTerm = $searchInput.val();
                        iso.arrange({
                            filter: function() {
                                if ($(this).hasClass('search')) return true;
                                if ($(this).hasClass('head')) return true;
                                var regex = new RegExp(searchTerm, "i");
                                var found = false;
                                $(this).find('td').add($(this).find('.heading')).each(function() {
                                    if (regex.test($(this).text())) {
                                        found = true;
                                        return found;
                                    }
                                });
                                return found;
                            }
                        });
                    });

                    // color cell background according to project date
                    (function () {
                        var dates = $('.cell').map(function () { return $(this).data('endtime') });
                        var min = Math.min.apply(Math, dates);
                        var max = Math.max.apply(Math, dates);
                        var max_dist = max - min;

                        $('.cell').each(function () {
                            var endtime = $(this).data('endtime');
                            if (endtime != null) {
                                // pick color
                                var dist = max - endtime;
                                var color = colors[Math.floor((dist/max_dist)*(colors.length-1))];
                                $(this).css('background', color);
                            }
                            else {
                                $(this).css('background', colors[0]);
                                $(this).find('input').css('background' , '#F6F6F6');
                            }
                        });

                    })();

                </script>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

