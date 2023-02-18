# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=APOCAL

inherit perl-module

DESCRIPTION="An easy to use SOAP/1.1 daemon for POE-enabled programs"
HOMEPAGE="http://metacpan.org/release/POE-Component-Server-SOAP"
#SRC_URI="https://cpan.metacpan.org/authors/id/A/AP/APOCAL/POE-Component-Server-SOAP-1.14.tar.gz"
RESTRICT="mirror"


SLOT="0"
KEYWORDS="~amd64 ~arm arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
IUSE=""

RDEPEND="dev-perl/POE-Component-Server-SimpleHTTP"
DEPEND="${RDEPEND}"
BDEPEND="dev-perl/Module-Build"
