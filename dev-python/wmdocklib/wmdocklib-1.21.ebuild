# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python distutils

DESCRIPTION="Library for windowmaker dockapps using python."
HOMEPAGE="http://pywmdockapps.sourceforge.net/old-index.html"
SRC_URI="http://downloads.sourceforge.net/pywmdockapps/pywmdockapps-${PV}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
src_unpack() {
	unpack ${A}
	cd pywmdockapps-${PV}
	epatch "${FILESDIR}/wmdocklib-only.patch"
}

src_compile() {
	cd pywmdockapps-${PV}
	distutils_src_compile
}

src_install() {
	cd pywmdockapps-${PV}
	distutils_src_install
}
