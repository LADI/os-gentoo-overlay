# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg git-r3

DESCRIPTION="Small ALSA Library"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/salsa-lib.git"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/salsa-lib.git"
EGIT_BRANCH="master"
EGIT_TAG="v0.2.0"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

#CDEPEND=""
#DEPEND="${CDEPEND}"
#RDEPEND="${CDEPEND}"

DOCS=( AUTHORS README.md NEWS )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-rawmidi
		--enable-hwdep
		--enable-async
		--enable-chmap
		--enable-tlv
	)
	econf "${myeconfargs[@]}"
}
