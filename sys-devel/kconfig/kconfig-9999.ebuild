# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
PYTHON_REQ_USE="threads(+)"

inherit autotools python-single-r1

DESCRIPTION="Standalone implementation of the Linux Kconfig parser and frontends"
HOMEPAGE="https://gitlab.com/ymorin/kconfig-frontends"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/ymorin/kconfig-frontends"
else
	MY_P="kconfig-frontends-${PV}"
	SRC_URI="https://bitbucket.org/nuttx/tools/downloads/${MY_P}.tar.bz2"
#	if [[ ${PV} == 4.11.0.1 ]] ; then
#		SRC_URI="https://gitlab.com/ymorin/kconfig-frontends/-/archive/cc2bad430e271f036afb0c13d68190cf9b96ac54/kconfig-frontends-cc2bad430e271f036afb0c13d68190cf9b96ac54.tar.bz2"
#	fi
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~arm ~arm64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+ncurses qt5"

DEPEND="
	sys-devel/flex
	sys-devel/bison
	dev-util/gperf
	ncurses? ( sys-libs/ncurses[tinfo] )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
	)
	virtual/pkgconfig
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}"/kconfig-frontends-configure-ac-tinfow.patch
)

src_prepare() {
	default
	rm -v "${S}"/libs/parser/[hly]conf.c
	eautoreconf
}

src_configure() {
	local myeconfargs=()

	myeconfargs+=("--enable-L10n")

	if use ncurses; then
		myeconfargs+=("--enable-mconf" "--enable-nconf")
	else
		myeconfargs+=("--disable-mconf" "--disable-nconf")
	fi

	myeconfargs+=("--disable-gconf")

	if use qt5; then
		myeconfargs+=("--enable-qconf")
	else
		myeconfargs+=("--disable-qconf")
	fi

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${ED}"/usr/ -name "*.la" -delete || die
}
