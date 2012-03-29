# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils git-2

DESCRIPTION="LADITools is a set of tools to improve desktop integration and user workflow of Linux audio systems"
HOMEPAGE="http://www.marcochapeau.org/software/laditools"

EGIT_REPO_URI="git://repo.or.cz/laditools.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

PYTHON_DEPEND="2:2.6"

RDEPEND="dev-lang/python
	>=dev-python/enum-0.4.4
	>=media-sound/jack-audio-connection-kit-0.109.2-r2[dbus]
	>=x11-libs/vte-0.30.1[introspection]"

DOCS="README"
