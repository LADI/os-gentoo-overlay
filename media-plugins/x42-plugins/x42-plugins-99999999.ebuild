# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Collection of LV2 plugins"
HOMEPAGE="https://github.com/x42/x42-plugins"

inherit git-r3
EGIT_REPO_URI="https://github.com/LADI/x42-plugins.git"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

RDEPEND="dev-libs/glib
	media-fonts/dejavu
	media-libs/ftgl
	media-libs/glu
	media-libs/liblo
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/libltc
	media-libs/lv2
	media-libs/zita-convolver
	sci-libs/fftw:3.0
	virtual/jack
	virtual/opengl
	x11-libs/cairo[X]
	x11-libs/pango
"
DEPEND="${RDEPEND}
	sys-apps/help2man"

src_compile() {
	emake CC="$(tc-getCC)" STRIP="#" FONTFILE="/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf" OPTIMIZATIONS="-O3 -ffast-math -fomit-frame-pointer -fno-finite-math-only -DNDEBUG"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
}
