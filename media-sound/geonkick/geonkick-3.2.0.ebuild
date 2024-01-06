# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Percussion sythesizer"
HOMEPAGE="https://geonkick.org"

LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"

inherit git-r3
EGIT_REPO_URI="https://github.com/Geonkick-Synthesizer/geonkick"
EGIT_BRANCH="main"
EGIT_COMMIT=305a743af6bc762874098619e258c301c52adc5e

IUSE="+jack +lv2"

REQUIRED_USE="
	|| ( jack lv2 )"

CDEPEND="dev-libs/rapidjson
	x11-libs/cairo
	media-libs/libsndfile
	jack? ( virtual/jack )
	lv2? ( media-libs/lv2 )"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGKICK_STANDALONE=$(usex jack)
		-DGKICK_PLUGIN=$(usex lv2)
		-DGKICK_PLUGIN_LV2=$(usex lv2)
	)

	cmake_src_configure
}
