# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Rumpelrausch Taips AZR3 standalone Linux port"
HOMEPAGE="http://ll-plugins.nongnu.org/azr3"
SRC_URI="http://download.savannah.nongnu.org/releases/ll-plugins/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="lash"

DEPEND="media-sound/jack-audio-connection-kit
	dev-cpp/gtkmm
	lash? ( virtual/liblash )"
RDEPEND="${DEPEND}"

src_prepare() {
	use !lash && epatch "${FILESDIR}/drop_lash_support.patch"
	use lash && epatch "${FILESDIR}/azr3-jack-1.2.3-lash-runtime-optional.patch"
}

src_configure() {
	./configure \
		--prefix=/usr \
		--CFLAGS="${CFLAGS}" \
		--LDFLAGS="${LDFLAGS}" || die
}

src_compile() {
	emake || die
}

src_install() {
	dobin azr3/azr3
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins azr3/presets
	doins azr3/*.png
	dodoc AUTHORS README
}
