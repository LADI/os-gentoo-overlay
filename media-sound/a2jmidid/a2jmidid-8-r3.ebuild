# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Exposing ALSA sequencer applications in JACK MIDI system"
HOMEPAGE="https://github.com/LADI/a2jmidid"
SRC_URI="https://web.archive.org/web/20170203210903/http://download.gna.org/a2jmidid/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="dbus"

RDEPEND="media-libs/alsa-lib
	virtual/jack
	dbus? ( sys-apps/dbus )
	dev-lang/python:2.7"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=(AUTHORS README NEWS internals.txt)

PATCHES=(
		"${FILESDIR}"/a2jmidid-8.nosigsegv.patch
		"${FILESDIR}"/a2jmidid-8.py2shebang.patch
)

src_configure() {
	if use dbus ; then
		python2 ./waf configure --prefix=/usr
	else
		python2 ./waf configure --prefix=/usr --disable-dbus
	fi
}

src_compile() {
	python2 ./waf
}

src_install() {
	python2 ./waf install --destdir="${D}"
}
