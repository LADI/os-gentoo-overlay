# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE='threads(+)'

inherit flag-o-matic python-single-r1 waf-utils xdg-utils

DESCRIPTION="LADI Session Handler - a session management system for JACK applications"
HOMEPAGE="https://ladish.org"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LADI/ladish.git"

	if [[ ${PV} == 9999 ]] ; then
		EGIT_BRANCH="main"
	elif [[ ${PV} == 1.9999 ]] ; then
		EGIT_BRANCH="1-stable"
	elif [[ ${PV} == 2.9999 ]] ; then
		EGIT_BRANCH="2-stable"
	fi
	EGIT_SUBMODULES=()
	KEYWORDS=""
else
	if [[ ${PV} == 1.1 ]] ; then
		MY_P="${P}-g36c489e4"
		KEYWORDS="~amd64 ~arm arm64 ~x86"
	fi
	if [[ ${PV} == 1.2 ]] ; then
		MY_P="${P}-g4dcd67d7"
		KEYWORDS="~amd64 ~arm arm64 ~x86"
	fi
	if [[ ${PV} == 1.3 ]] ; then
		MY_P="${P}-gfcd24852"
		KEYWORDS="~amd64 ~arm arm64 ~x86"
	fi
	SRC_URI="https://dl.ladish.org/ladish/${MY_P}.tar.bz2"
	S="${WORKDIR}/${MY_P}"
fi

# common/klist.h is linked list code borrowed from linux kernel, and thus is GPL2 only
# otherwise it is GPL-2+ code
#LICENSE="GPL-2 GPL-2+"
LICENSE="GPL-2"
SLOT="0"

#RESTRICT="mirror"

IUSE="debug doc +lash gtk a2jmidid"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	a2jmidid? (
		media-libs/alsa-lib
		media-sound/a2jmidid[dbus]
	)
	virtual/jack
	media-sound/jackdbus
	sys-apps/dbus
	dev-libs/expat
	lash? ( !media-sound/lash )
	gtk? (
		dev-libs/glib
		dev-libs/dbus-glib
		x11-libs/gtk+:2
		dev-cpp/gtkmm:2.4
		>=dev-cpp/libgnomecanvasmm-2.6.0
	)
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
	virtual/pkgconfig"

DOCS=( AUTHORS README.adoc NEWS )

# libalsapid.so is version-less by upstream design
QA_SONAME=( ".*/libalsapid.so" )

src_configure() {
	local -a mywafconfargs=(
		--distnodeps
		$(usex debug --debug '')
		$(usex doc --doxygen '')
		$(usex gtk '--enable-gladish' '')
		$(usex lash '--enable-liblash' '')
		$(usex a2jmidid '' '--disable-alsapid')
	)
	waf-utils_src_configure "${mywafconfargs[@]}"
}

src_install() {
	use doc && HTML_DOCS="${S}/build/default/html/*"
	waf-utils_src_install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
