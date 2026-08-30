# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A tool to abuse Exchange services"
HOMEPAGE="https://github.com/sensepost/ruler"
SRC_URI="
	https://github.com/sensepost/ruler/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="CC-BY-NC-SA-4.0"
SLOT=0
IUSE=""
KEYWORDS="amd64 ~arm arm64"

DEPEND=""
RDEPEND=""

src_compile() {
	GOBIN="${S}/bin" ego install ./... ||
		die "compile failed"
}

src_install(){
	dobin bin/ruler
	newbin bin/webdav ruler_webdav
}
