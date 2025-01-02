# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..13} )
PYTHON_REQ_USE='threads(+)'

inherit python-single-r1 waf-utils git-r3

DESCRIPTION="cdbus - libdbus helper library (in plain C)"
HOMEPAGE="https://github.com/LADI/cdbus/"

EGIT_REPO_URI="https://github.com/LADI/cdbus.git"
EGIT_BRANCH="main"

if [[ ${PF} == cdbus-1.1 ]] ; then
	# 6530c885844223501535e159db0b073e280b3773=1.1
	EGIT_COMMIT="6530c885844223501535e159db0b073e280b3773"
fi

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
fi
EGIT_SUBMODULES=()

LICENSE="GPL-2"
SLOT="0"

IUSE="debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="sys-apps/dbus
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS README.adoc NEWS.adoc )

PATCHES=(
)

src_configure() {
	local -a mywafconfargs=(
		$(usex debug --debug '')
	)
	waf-utils_src_configure "${mywafconfargs[@]}"
}

src_install() {
	waf-utils_src_install
}
