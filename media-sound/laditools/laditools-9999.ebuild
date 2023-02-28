# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{6,7,8,9,10,11} )
inherit distutils-r1 git-r3

DESCRIPTION="Set of tools to use with jackdbus and other LADI components"
HOMEPAGE="https://ladish.org"

EGIT_REPO_URI="https://github.com/LADI/laditools.git"
EGIT_BRANCH="main"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pyyaml
	media-sound/jackdbus
	x11-libs/vte[introspection]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/python-distutils-extra"

DOCS="README"
