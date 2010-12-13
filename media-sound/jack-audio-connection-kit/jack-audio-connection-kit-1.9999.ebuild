# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils multilib git linux-info autotools

RESTRICT="strip mirror"
DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://www.jackaudio.org"

EGIT_REPO_URI="http://nedko.arnaudov.name/git/jack1.git"
EGIT_BRANCH="dbus"
EGIT_COMMIT="dbus"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="3dnow altivec alsa celt coreaudio cpudetection doc debug examples mmx oss sse netjack freebob ieee1394 dbus"

RDEPEND="
	>=media-libs/libsndfile-1.0.0
	sys-libs/ncurses
	celt? ( >=media-libs/celt-0.5.0 )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )
	freebob? ( sys-libs/libfreebob !media-libs/libffado )
	ieee1394? ( media-libs/libffado !sys-libs/libfreebob )
	netjack? ( media-libs/libsamplerate )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
	netjack? ( dev-util/scons )
	"

src_unpack() {
	git_src_unpack
	cd "${S}"
	eautoreconf
}

src_compile() {
	local myconf="--with-html-dir=/usr/share/doc/${PF}"

	# CPU Detection (dynsimd) uses asm routines which requires 3dnow, mmx and sse.
	if use cpudetection && use 3dnow && use mmx && use sse ; then
		einfo "Enabling cpudetection (dynsimd). Adding -mmmx, -msse, -m3dnow and -O2 to CFLAGS."
		myconf="${myconf} --enable-dynsimd"
		append-flags -mmmx -msse -m3dnow -O2
	fi

	use doc || export ac_cv_prog_HAVE_DOXYGEN=false

	econf \
		$(use_enable ieee1394 firewire) \
		$(use_enable freebob) \
		$(use_enable altivec) \
		$(use_enable alsa) \
		$(use_enable coreaudio) \
		$(use_enable debug) \
		$(use_enable mmx) \
		$(use_enable oss) \
		$(use_enable sse)  \
		$(use_enable dbus) \
		--disable-dependency-tracking \
		--with-default-tmpdir=/dev/shm \
		${myconf} || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS TODO README

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/example-clients"
	fi
}