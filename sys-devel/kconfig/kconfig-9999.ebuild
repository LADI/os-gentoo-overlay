# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="threads(+)"

inherit autotools python-single-r1

DESCRIPTION="Standalone implementation of the Linux Kconfig parser and frontends"
HOMEPAGE="https://gitlab.com/ymorin/kconfig-frontends"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/ymorin/kconfig-frontends"
else
	MY_P="kconfig-frontends-df6a283f24aa146ab862950503db9542a12dab7a" #
	SRC_URI="https://gitlab.com/ymorin/kconfig-frontends/-/archive/df6a283f24aa146ab862950503db9542a12dab7a/kconfig-frontends-df6a283f24aa146ab862950503db9542a12dab7a.tar.bz2"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~arm64 ~arm"
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
		qt-dev/qtcore:5
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
