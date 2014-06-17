# Popo: <u>P</u>ers<u>o</u>nal <u>P</u>roject <u>O</u>verview generation from XML

Popo generates an overview of one's project experience as a searchable
HTML document.

The information included per project is:

* The kind of work that has been done for the project (mandatory information)
* The role one had when working in the project
* The tooling one has used
* The employer one has been employed by when working on the project
* The company that acted as an agency, if any
* The end customer, the beneficiary of the work, that is
* A description of the project and the work done
* A number of URLs relevant to the project
* The time (a period or a single point in time) one was working on the project

Popo generates static HTML documents, one for each language.

**Examples:** [profile\_en.html](profile_en.html), [profile\_de.html](profile_de.html)


## Presentation

Each project is displayed as a tile. All tiles are layed out using a
masonry layout algorithm (using Isotope.js).

## XML

Project information is stored in an XML file. A typical entry looks like this:

    <unit>
        <name>xz</name>
        <work xml:lang="de">Datenmanagement</work>
        <work xml:lang="en">Data management</work>
        <role xml:lang="de">Konzeption und Umsetzung</role>
        <role xml:lang="en">Conception and implementation</role>
        <tooling>Perl, SQLite, shell scripting</tooling>
        <endcustomer>Omni Consumer Products</endcustomer>
        <agency>Adventure Works</agency>
        <employer>CHOAM</employer>
        <description xml:lang="de">Entwicklung einer Middleware zur Verarbeitung regelmäßig aktualisierter Forschungsdaten</description>
        <description xml:lang="en">Development of a middleware to process regularly updated scientific data</description>
        <url>https://example.net</url>
        <starttime>2009</starttime>
        <endtime>2012</endtime>
    </unit>

See the [full example profile XML](profile.xml) for a detailed view.

## Transformation

The XML is transformed to HTML with an XSLT processor. An XSLT processor takes
the XML and an XSLT stylesheet as input files. Popo's main stylesheet is
[profile\_en.xslt](profile_en.xslt).

## Localization

Localization is realized by overwriting variables of the master stylesheet.
The master stylesheet is `profile_en.xslt` as of now. An example localization
can be found in `profile_de.xslt`.

## Dependencies

Popo depends on Saxon HE and Sass.


## XSLT processing

The number of open source XSLT processors capable of transforming XSLT 2.0
stylesheets is very limited. Saxon HE seems to be the only viable option
as of now.

As a consequence Popo depends on a Saxon HE JAR file lying around somewhere,
preferably in `/usr/share/java/Saxon-HE.jar`. If the file is saved under
another location Popo's Makefile has to be changed accordingly.


## TODO

* Media *print* stylesheet
* Different media *screen* stylesheets to chose from
* Packaging and dependency management (especially to get Saxon HE onto the
  system)
* Remove hard-coding of Saxon HE JAR path in [Makefile](Makefile)
* Cross-browser compatibility


## License

**Copyright (C) 2014-06 Tobias M.-Nissen <mailto:tn@movb.de>**

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the [GNU General Public License](LICENSE) for
more details.

