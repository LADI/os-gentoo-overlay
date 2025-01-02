# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1

DESCRIPTION="A Python wrapper for the liblo OSC library"
HOMEPAGE="https://gitea.ladish.org/LADI/pyliblo3.git"
inherit git-r3
EGIT_REPO_URI="https://gitea.ladish.org/LADI/pyliblo3.git"
EGIT_BRANCH="main"
EGIT_COMMIT="9739751f93dc7893cb99715ae17806f6cce0ce10" # git prepatched 0.16.2
KEYWORDS=""
EGIT_SUBMODULES=()

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND=">=media-libs/liblo-0.27
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/cython"

distutils_enable_tests unittest
