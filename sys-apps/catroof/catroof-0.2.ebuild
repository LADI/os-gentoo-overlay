# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="threads(+)"
inherit flag-o-matic python-single-r1 waf-utils

inherit git-r3

EGIT_REPO_URI="https://github.com/LADI/catroof.git"
EGIT_BRANCH="main"
EGIT_COMMIT=9c1368d3b36ac66d3fa74cae58d8417a9b66f65e

DESCRIPTION="Manager for audio, midi and surface control devices"
HOMEPAGE="https://catroof.ladish.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"

DEPEND="
	media-libs/alsa-lib
	dev-lang/lua"
RDEPEND="
	${DEPEND}"
BDEPEND="
	${PYTHON_DEPS}"
PDEPEND=""

DOCS=( README.adoc )

src_configure() {
	local wafargs=(
#		--doxygen=$(usex doc)
	)

	waf-utils_src_configure "${wafargs[@]}"
}

src_compile() {
	waf-utils_src_compile
}

src_install() {
	waf-utils_src_install
}
