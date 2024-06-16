# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit python-single-r1 xdg

DESCRIPTION="LADI Claudia is Qt frontend for LADISH"
HOMEPAGE="https://gitea.ladish.org/LADI/claudia"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitea.ladish.org/LADI/claudia"
else
	MY_P="${P}-gec496b4" # 2.5.1
	SRC_URI="https://dl.ladish.org/ladi-claudia/${MY_P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~arm64 ~arm"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="a2jmidid"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# jack2[dbus] is direct dependency for ladi-jack2settings
# and indirect for ladi-claudia which depends directly
# on media-sound/ladish, while media-sound/ladish depends on jackdbus.
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/PyQt5[dbus,gui,svg,widgets,${PYTHON_USEDEP}]
	')
	media-sound/ladish
	media-sound/jackdbus
	a2jmidid? ( media-sound/a2jmidid[dbus] )
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s/python3/${EPYTHON}/" \
		data/ladi-jack2settings \
		data/ladi-claudia || die "sed failed"

	default
}

src_compile() {
	emake "${myemakeargs[@]}"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${ED}" install

	python_fix_shebang "${ED}"
}
