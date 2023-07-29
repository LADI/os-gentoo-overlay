EAPI=8

PYTHON_COMPAT=( python3_{6..11} )
PYTHON_REQ_USE='threads(+)'

inherit python-single-r1 meson xdg-utils git-r3

DESCRIPTION="JACK audio mixer with GTK interface."
HOMEPAGE="https://rdio.space/jackmixer/"
LICENSE="GPL-2"

#SRC_URI="https://rdio.space/jackmixer/tarballs/${P}.tar.xz"
#RESTRICT="mirror"

EGIT_REPO_URI="https://github.com/LADI/jack_mixer.git"
EGIT_BRANCH="main"
EGIT_COMMIT=b71543b57d319b0a7d6c54d705ff6cc8e1c0b4e9

KEYWORDS="amd64 arm arm64 ~loong ~ppc ~ppc64 ~riscv ~sparc x86"

SLOT="0"

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	virtual/jack
	dev-libs/glib
	dev-python/cython
	dev-python/pygobject
	dev-python/pycairo
	dev-python/pyxdg"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README.md CHANGELOG.md )

src_install() {
	meson_src_install
	python_optimize
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
