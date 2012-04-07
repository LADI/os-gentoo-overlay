# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit python distutils

DESCRIPTION="Robust enumerated type support in Python."
HOMEPAGE="http://pypi.python.org/pypi/enum/"
SRC_URI="mirror://pypi.python.org/packages/source/e/enum/enum-${PV}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
