# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A tool to brute-force URIs and DNS subdomains"
HOMEPAGE="https://github.com/OJ/gobuster"
SRC_URI="
	https://github.com/OJ/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND=">=dev-lang/go-1.10"
RDEPEND="${DEPEND}"

src_install() {
	dobin gobuster
}
