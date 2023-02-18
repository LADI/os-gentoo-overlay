# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="IRC collaboration bot"
# KGB is an IRC bot, helping people work together by notifying an IRC channel
# when a commit occurs.
#
# It supports multiple repositories/IRC channels and is fully configurable.
#
# This package contains the server-side daemon, kgb-bot, which is responsible
# for relaying commit notifications to IRC.

HOMEPAGE="https://salsa.debian.org/kgb-team/kgb"
EGIT_REPO_URI="https://salsa.debian.org/kgb-team/kgb.git"
EGIT_BRANCH="master"
KEYWORDS=""
EGIT_SUBMODULES=()

LICENSE="GPL-2"
SLOT="0"

IUSE=""
#REQUIRED_USE=""

RDEPEND="dev-perl/Class-Accessor
	dev-perl/DBD-Pg
	dev-perl/IPC-Run
	dev-perl/IPC-System-Simple
	dev-perl/JSON-RPC
	dev-perl/Net-IP
	dev-perl/POE
	dev-perl/SOAP-Lite
	dev-perl/Text-Glob
	dev-perl/WWW-Shorten
	dev-perl/YAML
	dev-perl/File-Touch
	dev-perl/Schedule-RateLimiter
	dev-perl/POE-Component-IRC
	dev-perl/POE-Component-Server-SOAP
	dev-perl/Proc-PID-File"

DEPEND="${RDEPEND}"

DOCS=( Changes )

src_compile() {
	make build
}

src_install() {
	make install
}
