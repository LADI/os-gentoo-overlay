# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )
inherit git-r3 python-single-r1

DESCRIPTION="\"clone\" your MIDI-capable instruments (LADI modifications)"
HOMEPAGE="https://github.com/surfacepatterns/synthclone https://gitea.ladish.org/LADI/synthclone"
EGIT_REPO_URI="https://gitea.ladish.org/LADI/synthclone"
EGIT_BRANCH="main"
#EGIT_COMMIT=36fa0fd867a9df9802d361b3ee9dbcac7bfcbc63

# this is doc? actually
EGIT_SUBMODULES=( doc/doxygen-awesome-css )

KEYWORDS="~amd64 ~arm arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
LICENSE="LGPL-2.1+ GPL-2+ portmedia? ( MIT )"
SLOT="0"

IUSE="+jack +lv2 h2 renoise portmedia doc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/designer:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	media-libs/libsamplerate
	media-libs/libsndfile
	jack? ( virtual/jack )
	portmedia? ( media-libs/portaudio media-libs/portmidi )
	lv2? (  media-libs/lv2
			dev-libs/serd
			dev-libs/sord
			media-libs/sratom
			media-libs/suil
			media-libs/lilv )
	h2? ( app-arch/libarchive )
	renoise? ( dev-libs/libzip )
	doc? ( app-doc/doxygen )"
DEPEND=${RDEPEND}

src_configure() {
	local args=( --prefix="/usr" )
	args+=( --lib-dir=lib64 )
	args+=( --qmake=qmake5 )
	use jack        || args+=( --skip-jack=1 )
	use portmedia   || args+=( --skip-portmedia=1 )
	use lv2         || args+=( --skip-lv2=1 )
	use h2          || args+=( --skip-hydrogen=1 )
	use renoise     || args+=( --skip-renoise=1 )
	use doc         || args+=( --skip-api-docs=1 )
	./configure "${args[@]}" || die
}

src_compile() {
	emake
}

src_install() {
	emake PREFIX="/usr" INSTALL_ROOT="${D}" install
}
