# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for LASH session handler"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ia64 ~loong ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris"

RDEPEND="
		|| (
				media-sound/ladish[lash]
				media-sound/lash
		)"
