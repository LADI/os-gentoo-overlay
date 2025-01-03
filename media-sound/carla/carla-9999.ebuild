# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit python-single-r1 xdg edo

DESCRIPTION="Fully-featured audio plugin host, supports many audio drivers and plugin formats"
HOMEPAGE="http://kxstudio.linuxaudio.org/Applications:Carla"
if [[ ${PV} == *9999 ]]; then
	# Disable submodules to prevent external plugins from being built and installed
	inherit git-r3
#	EGIT_REPO_URI="https://github.com/falkTX/Carla.git"
	EGIT_REPO_URI="https://gitea.ladish.org/LADI/carla.git"
	EGIT_BRANCH="ladi-qt6"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/falkTX/Carla/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	KEYWORDS="~amd64"
	S="${WORKDIR}/Carla-${PV}"
fi
LICENSE="GPL-2 LGPL-3"
SLOT="0"

IUSE="alsa opengl osc pulseaudio rdf sf2 sndfile X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pyqt6[gui,opengl?,svg,widgets,${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyqt5[gui,opengl?,svg,widgets,${PYTHON_USEDEP}]')
	virtual/jack
	alsa? ( media-libs/alsa-lib )
	x11-libs/gtk+:3
	x11-libs/gtk+:2
	osc? ( media-libs/liblo )
	pulseaudio? ( media-libs/libpulse )
	rdf? ( dev-python/rdflib )
	sf2? ( media-sound/fluidsynth )
	sndfile? ( media-libs/libsndfile )
	X? ( x11-base/xorg-server )"
DEPEND=${RDEPEND}

src_prepare() {
	sed -i -e "s|exec \$PYTHON|exec ${PYTHON}|" \
		data/carla \
		data/carla-control \
		data/carla-database \
		data/carla-jack-multi \
		data/carla-jack-single \
		data/carla-patchbay \
		data/carla-rack \
		data/carla-settings || die "sed failed"
	default
}

src_compile() {
	echo "LIBDIR=/usr/$(get_libdir)
SKIP_STRIPPING=true
FRONTEND_TYPE=6
HAVE_QT6=true
HAVE_QT5=true
HAVE_ALSA=$(usex alsa true false)
HAVE_FLUIDSYNTH=$(usex sf2 true false)
HAVE_LIBLO=$(usex osc true false)
HAVE_PULSEAUDIO=$(usex pulseaudio true false)
HAVE_SNDFILE=$(usex sndfile true false)
HAVE_X11=$(usex X true false)
HAVE_SDL=false
HAVE_SDL2=false
VERBOSE=1" > ${S}/Makefile.user.mk

	# Print which options are enabled/disabled
	еmake features PREFIX="/usr" "${myemakeargs[@]}"

	emake PREFIX="/usr" "${myemakeargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" "${myemakeargs[@]}" install
	if ! use osc; then
		find "${D}/usr" -iname "carla-control*" | xargs rm
	fi
}
