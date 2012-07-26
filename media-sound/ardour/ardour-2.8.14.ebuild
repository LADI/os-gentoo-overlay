# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils toolchain-funcs

RESTRICT="fetch"

DESCRIPTION="Digital Audio Workstation"
HOMEPAGE="http://ardour.org/"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
#SRC_URI="http://rfnx.com/gentoo/${P}.tar.bz2"
SRC_URI="${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="altivec curl debug nls lv2 sse"

# FIXME. Internal libsndfile, rubberband, vamp-plugin-sdk, and others.
RDEPEND="media-libs/aubio
	media-libs/liblo
	lv2? ( media-libs/lilv media-libs/suil )
	sci-libs/fftw:3.0
	media-libs/freetype:2
	>=dev-libs/glib-2.10.1:2
	>=x11-libs/gtk+-2.8.1:2
	>=dev-libs/libxml2-2.6
	>=media-libs/libsamplerate-0.1
	media-libs/libsndfile
	media-libs/libsoundtouch
	media-libs/flac
	>=media-libs/raptor-2.0.0
	>=media-libs/liblrdf-0.4
	>=media-sound/jack-audio-connection-kit-0.109
	>=gnome-base/libgnomecanvas-2
	media-libs/vamp-plugin-sdk
	dev-libs/libxslt
	dev-libs/libsigc++:2
	>=dev-cpp/gtkmm-2.16
	>=dev-cpp/libgnomecanvasmm-2.26
	media-libs/alsa-lib
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/pkgconfig
	>=dev-util/scons-1
	nls? ( sys-devel/gettext )"

pkg_nofetch() {
	einfo "Please download ${P}.tar.bz2 (Ardour ${PV} source code for all platforms)"
	einfo "from ${HOMEPAGE} and place it in ${DISTDIR}"
	einfo
}

src_prepare() {
	epatch "${FILESDIR}/ardour-2.8.8-ladish-L1.patch"
}

ardour_use_enable() {
	use ${2} && echo "${1}=1" || echo "${1}=0"
}

src_compile() {
	local FPU_OPTIMIZATION=$((use altivec || use sse) && echo 1 || echo 0)
	tc-export CC CXX
	mkdir -p "${D}"

	scons \
		${SCONSOPTS} \
		CFLAGS="${CFLAGS}" \
		$(ardour_use_enable DEBUG debug) \
		DESTDIR="${D}" \
		$(ardour_use_enable FREESOUND curl) \
		FPU_OPTIMIZATION="${FPU_OPTIMIZATION}" \
		$(ardour_use_enable NLS nls) \
		PREFIX=/usr \
		SYSLIBS=1 \
		$(ardour_use_enable LV2 lv2) \
		|| die "scons failed"
}

src_install() {
	scons install || die "scons install failed"
	newicon icons/icon/ardour_icon_mac.png ${PN}.png
	make_desktop_entry ardour2 Ardour
}
