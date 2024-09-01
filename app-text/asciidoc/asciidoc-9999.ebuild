# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..13} pypy3 )
inherit git-r3 distutils-r1 optfeature readme.gentoo-r1

DESCRIPTION="A plain text human readable/writable document format (LADI)"
HOMEPAGE="https://github.com/LADI/ladoc-py"
EGIT_REPO_URI="https://github.com/LADI/ladoc-py.git"
EGIT_BRANCH="ladi"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="app-text/docbook-xml-dtd:4.5
	>=app-text/docbook-xsl-stylesheets-1.75
	dev-libs/libxslt
	dev-libs/libxml2:2"

DOC_CONTENTS="
If you are going to use a2x, please also look at a2x(1) under
REQUISITES for a list of runtime dependencies.
"

src_install() {
	distutils-r1_src_install

	# TODO: Consider using Debian patch to allow /usr/share?
	insinto /usr/share/asciidoc
	doins -r asciidoc/resources/.

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog

	optfeature "music filter support" "media-sound/lilypond virtual/imagemagick-tools"
	optfeature "source filter support" "dev-util/source-highlight dev-python/pygments app-text/highlight"
	optfeature "latex filter support" "dev-texlive/texlive-latex app-text/dvipng" "dev-texlive/texlive-latex app-text/dvisvgm"
	optfeature "graphviz filter support" "media-gfx/graphviz"
}
