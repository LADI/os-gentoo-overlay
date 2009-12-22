# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils subversion

DESCRIPTION="LADITools is a set of tools to improve desktop integration and user workflow of Linux audio systems"
HOMEPAGE="http://www.marcochapeau.org/software/laditools"

ESVN_REPO_URI="svn://svn.marcochapeau.org/laditools/trunk"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pygtk
	dev-python/pyxml
	|| ( >=media-sound/jack-audio-connection-kit-0.109.2-r2[dbus]
		media-sound/jackdmp[dbus] )
	x11-libs/vte[python]"
DEPEND="dev-lang/python"

DOCS="README"

#src_unpack() {
#	subversion_src_unpack
#	#epatch "${FILESDIR}/${P}-no_extra_docs.patch"
#}
