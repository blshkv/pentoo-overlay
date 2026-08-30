# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

SRC_URI="
	https://github.com/PuerkitoBio/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"
DESCRIPTION="Simple, flexible web crawler that follows robots.txt policies and crawl delays"
HOMEPAGE="https://github.com/PuerkitoBio/fetchbot"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
