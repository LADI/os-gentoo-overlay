EAPI=8

PYTHON_COMPAT=( python3_11 )

inherit autotools xdg-utils

DESCRIPTION="JACK audio mixer with GTK interface."
HOMEPAGE="https://rdio.space/jackmixer/"
LICENSE="GPL-2"

SRC_URI="https://rdio.space/jackmixer/tarballs/${P}.tar.gz"
RESTRICT="mirror"

#EGIT_REPO_URI="https://github.com/LADI/jack_mixer.git"
#EGIT_BRANCH="main"
#EGIT_COMMIT=94b4b21d4c0db2d2cc9bf8ee059ea6888c13cdc0

KEYWORDS="amd64 arm arm64 ~loong ~ppc ~ppc64 ~riscv ~sparc x86"

SLOT="0"

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	virtual/jack
	dev-libs/glib
	dev-python/pygobject
	dev-python/pycairo
	dev-python/pyxdg"
DEPEND="${RDEPEND}"

PATCHES=(
	${FILESDIR}/noschemas.patch
)

DOCS=( AUTHORS README NEWS )

src_prepare() {
		default
		eautoreconf
}

src_configure() {
		econf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
