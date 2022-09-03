# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="A functional programming language for realtime audio signal processing."
HOMEPAGE="https://faust.grame.fr/"
SRC_URI="https://github.com/grame-cncm/faust/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND=""
DEPEND=""

src_configure() {
	# prevent static libs from being mangled with LTO
	#CXXFLAGS+=' -ffat-lto-objects'
	cmake \
		-C build/backends/all.cmake \
		-C build/targets/all.cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=None \
		-DINCLUDE_DYNAMIC=ON \
		-DINCLUDE_STATIC=ON \
		-DINCLUDE_ITP=ON \
		-W no-dev \
		-S build \
		-B "${P}-build"
}

src_compile() {
	emake VERBOSE=1 -C "${P}-build"
#	make VERBOSE=1 -C tools/sound2faust
}

src_install() {
#	dodir ${D}/usr/lib/faust
#	emake DESTDIR="${D}" install
	emake VERBOSE=1 -C "${P}-build" DESTDIR="${D}" install
#	dodoc README.md
#	install faust_tutorial.pdf ${D}/usr/share/doc/${P}
}
