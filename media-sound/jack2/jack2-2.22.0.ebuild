# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="threads(+)"
inherit flag-o-matic python-single-r1 waf-utils multilib-minimal
inherit git-r3

EGIT_REPO_URI="https://github.com/LADI/jack2.git"
EGIT_BRANCH="stable"
EGIT_COMMIT="79015efea2ca4b9d0fcda5703e999a2a938d2590"
KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"

DESCRIPTION="LADI JACK2 is version of the jackdmp, a C++ version of the JACK low-latency audio server for multi-processor machines."
HOMEPAGE="https://github.com/LADI/jack2"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="2"
IUSE="+alsa doc ieee1394 libsamplerate metadata opus pam"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}"

DEPEND="
	alsa? ( media-libs/alsa-lib[${MULTILIB_USEDEP}] )
	sys-apps/dbus[${MULTILIB_USEDEP}]
	libsamplerate? ( media-libs/libsamplerate[${MULTILIB_USEDEP}] )
	ieee1394? ( media-libs/libffado[${MULTILIB_USEDEP}] )
	metadata? ( sys-libs/db:=[${MULTILIB_USEDEP}] )
	opus? ( media-libs/opus[custom-modes,${MULTILIB_USEDEP}] )"
RDEPEND="
	${DEPEND}
	pam? ( sys-auth/realtime-base )
	!media-sound/jack-audio-connection-kit
	!media-video/pipewire[jack-sdk(-)]"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"
PDEPEND=""

DOCS=( AUTHORS.rst NEWS.rst README.rst README_NETJACK2 )

PATCHES=( )

src_prepare() {
	default

	python_fix_shebang waf
	multilib_copy_sources
}

multilib_src_configure() {
	# clients crash if built with lto
	# https://github.com/jackaudio/jack2/issues/485
	filter-lto

	local wafargs=(
		--mandir="${EPREFIX}"/usr/share/man/man1 # override eclass' for man1

		--alsa=$(usex alsa)
		--celt=no
		--db=$(usex metadata)
		--doxygen=$(multilib_native_usex doc)
		--firewire=$(usex ieee1394)
		--iio=no
		--opus=$(usex opus)
		--portaudio=no
		--samplerate=$(usex libsamplerate)
		--systemd=no
		--winmme=no
	)

	waf-utils_src_configure "${wafargs[@]}"
}

multilib_src_compile() {
	waf-utils_src_compile
}

multilib_src_install() {
	waf-utils_src_install
}
