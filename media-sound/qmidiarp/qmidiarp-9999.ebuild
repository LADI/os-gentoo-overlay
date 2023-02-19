# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools qmake-utils xdg git-r3

DESCRIPTION="Arpeggiator, sequencer and MIDI LFO for ALSA"
HOMEPAGE="http://qmidiarp.sourceforge.net/"
EGIT_REPO_URI="https://github.com/emuse/qmidiarp.git"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
IUSE="lv2 nls osc"

BDEPEND="
	nls? ( dev-qt/linguist-tools:5 )
	virtual/pkgconfig"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/alsa-lib
	virtual/jack
	lv2? ( media-libs/lv2 )
	osc? ( media-libs/liblo )"
DEPEND="${RDEPEND}"

src_configure() {
	eautoreconf
	export PATH="$(qt5_get_bindir):${PATH}"

	local myeconfargs=(
		$(use_enable lv2 lv2plugins)
		$(use_enable nls translations)
		$(use_enable osc nsm)
	)
	econf "${myeconfargs[@]}"
}
