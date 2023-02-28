# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="8"

PYTHON_COMPAT=( python3_{6,7,8,9,10,11} )
inherit distutils-r1 git-r3

DESCRIPTION="LADITools is a set of tools to improve desktop integration and user workflow of Linux audio systems"
HOMEPAGE="https://ladish.org"

EGIT_REPO_URI="https://github.com/LADI/laditools.git"
EGIT_BRANCH="main"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
IUSE=""

#	dev-python/pygtk
RDEPEND="dev-lang/python
	dev-python/pyyaml
	media-sound/jackdbus
	x11-libs/vte[python]"
DEPEND="dev-lang/python"

DOCS="README"
