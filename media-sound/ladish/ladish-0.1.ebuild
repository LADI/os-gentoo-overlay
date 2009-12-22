# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/a2jmidid/a2jmidid-5.ebuild,v 1.1 2009/06/17 07:09:14 aballier Exp $

EAPI=2

inherit eutils

DESCRIPTION="LADI Session Handler - a session management system for JACK applications"
HOMEPAGE="http://ladish.org/"
SRC_URI="http://ladish.org/download/ladish-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-sound/jack-audio-connection-kit[dbus]
	x11-libs/flowcanvas
	sys-apps/dbus
	dev-lang/python"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	ls -l
	epatch "${FILESDIR}/fixwarnings.patch"
}

src_compile() {
	./waf configure --prefix=/usr || die "failed to configure"
	./waf || die "failed to build"
}

src_install() {
	./waf --destdir="${D}" install || die "install failed"
	dodoc AUTHORS README NEWS
}
