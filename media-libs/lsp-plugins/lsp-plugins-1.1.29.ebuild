# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="Linux Studio Plugins"
HOMEPAGE="https://lsp-plug.in"

SRC_URI="https://github.com/sadko4u/lsp-plugins/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 arm arm64 ~ppc ~ppc64 x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc +jack ladspa +lv2 test"
REQUIRED_USE="|| ( jack ladspa lv2 )
	test? ( jack )"

RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/expat
	media-libs/libsndfile
	media-libs/libglvnd[X]
	doc? ( dev-lang/php:* )
	jack? (
		virtual/jack
		x11-libs/cairo[X]
	)
	ladspa? ( media-libs/ladspa-sdk )
	lv2? (
		media-libs/lv2
		x11-libs/cairo[X]
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/${PN}-1.1.29_armv8a-dsp.patch
)

src_compile() {
	use doc && MODULES+="doc"
	use jack && MODULES+=" jack"
	use ladspa && MODULES+=" ladspa"
	use lv2 && MODULES+=" lv2"
	emake BUILD_MODULES="${MODULES}"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${ED}" LIB_PATH="/usr/$(get_libdir)" install
}
