# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils git-r3

DESCRIPTION="Coil64 is inductance coil calculator"
HOMEPAGE="https://coil32.net/"
LICENSE="GPL-3+"

EGIT_REPO_URI="https://github.com/radioacoustick/Coil64.git"
EGIT_BRANCH="master"
KEYWORDS="amd64 ~arm arm64 ~loong ~ppc ppc64 ~riscv ~x86"
SLOT="0"
DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_configure() {
	eqmake5 PREFIX="/usr" Coil64.pro
}

src_install() {
	dobin Coil64
}
