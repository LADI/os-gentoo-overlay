# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg git-r3

DESCRIPTION="LADISH frontend and/or JACK (jackdbus) patchbay in flow matrix style"
HOMEPAGE="https://gitea.ladish.org/LADI/patchmatrix"

if [[ ${PV} == *9999* ]] ; then
	EGIT_REPO_URI="https://gitea.ladish.org/LADI/patchmatrix"
	EGIT_BRANCH=ladi
elif [[ ${PF} == ladi-patchmatrix-0.56.1-r2 ]] ; then
#	MY_P="${P}-gXXXXXXX" # maj.min.patch
#	SRC_URI="https://dl.ladish.org/ladi-patchmatrix/${MY_P}.tar.xz"
#	S="${WORKDIR}/${MY_P}"

	EGIT_REPO_URI="https://gitea.ladish.org/LADI/patchmatrix"
	EGIT_BRANCH=ladi
	#4ac9d53=0.56.1
	EGIT_COMMIT=4ac9d53292c378a8babc49c3880ec4a5c5ae6fc4

	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
#elif [[ ${PV} == maj.min.patch-r1 ]] ; then
#	MY_P="${P}-gXXXXXXX" # maj.min.patch
#	SRC_URI="https://dl.ladish.org/ladi-patchmatrix/${MY_P}.tar.xz"
#	S="${WORKDIR}/${MY_P}"
fi

LICENSE="Artistic-2 GPL-2"
SLOT="0"
IUSE="+ladish"

# jack2[dbus] (or jackdbus+pipewire) is runtime required (but not build time) dependency
# ladish is optional but recommended runtime required (but not build time) dependency
RDEPEND="${PYTHON_DEPS}
	media-sound/jackdbus
	ladish? ( media-sound/ladish )
"
DEPEND="sys-apps/dbus
	sys-libs/cdbus
	media-libs/libglvnd[X]"
