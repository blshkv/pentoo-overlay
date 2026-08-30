# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/OWASP/Amass"

SRC_URI="
	https://github.com/OWASP/Amass/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

BDEPEND=">=dev-lang/go-1.13"

src_compile() {
	GOBIN="${S}/bin" ego install ./... || die "compile failed"
}

src_install() {
	dobin bin/${PN}
}
