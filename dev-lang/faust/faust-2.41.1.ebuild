# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="A functional programming language for realtime audio signal processing."
HOMEPAGE="https://faust.grame.fr/"
SRC_URI="https://github.com/grame-cncm/faust/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND="sys-devel/bison
		 sys-devel/flex"
DEPEND="sys-apps/sed"

src_compile() {
	sed -i "s\/usr/local\ ${D}/usr\ " Makefile
	emake || die "parallel make failed"
}

src_install() {
#	dodir ${D}/usr/lib/faust
	emake DESTDIR="${D}" install
	dodoc README.md
#	install faust_tutorial.pdf ${D}/usr/share/doc/${P}
}
