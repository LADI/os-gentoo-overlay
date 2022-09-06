# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="A functional programming language for realtime audio signal processing."
HOMEPAGE="https://faust.grame.fr/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/grame-cncm/faust.git"
	inherit git-r3
else
	SRC_URI="https://github.com/grame-cncm/faust/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="arm64"
fi

BDEPEND="
	>=dev-util/cmake-3.7.2
"
RDEPEND="
	>=sys-devel/llvm-8
"
DEPEND="${DEPEND}"

src_configure() {
	# prevent static libs from being mangled with LTO
	#CXXFLAGS+=' -ffat-lto-objects'
	cmake \
		-C build/backends/all.cmake \
		-C build/targets/all.cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DLIBSDIR=lib64 \
		-DCMAKE_BUILD_TYPE=Release \
		-DINCLUDE_DYNAMIC=OFF \
		-DINCLUDE_STATIC=OFF \
		-DINCLUDE_ITP=OFF \
		-W no-dev \
		-S build \
		-B "${P}-build" || die
}

src_compile() {
	emake VERBOSE=1 -C "${P}-build"
#	make VERBOSE=1 -C tools/sound2faust
}

src_install() {
#	emake DESTDIR="${D}" install
	emake VERBOSE=1 -C "${P}-build" DESTDIR="${D}" install
	dodoc README.md
#	install faust_tutorial.pdf ${D}/usr/share/doc/${P}
}
