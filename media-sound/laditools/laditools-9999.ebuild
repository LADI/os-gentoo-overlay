# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

DESCRIPTION="LADITools is a set of tools to improve desktop integration and user workflow of Linux audio systems"
HOMEPAGE="http://www.marcochapeau.org/software/laditools"

EGIT_REPO_URI="git://git.marcochapeau.org/laditools.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pygtk
	dev-python/pyyaml
	|| ( >=media-sound/jack-audio-connection-kit-0.109.2-r2[dbus]
		media-sound/jackdmp[dbus] )
	x11-libs/vte[python]"
DEPEND="dev-lang/python"

DOCS="README"
