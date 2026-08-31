# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module flag-o-matic

DESCRIPTION="A fast port scanner written in go with a focus on reliability and simplicity."
HOMEPAGE="https://github.com/projectdiscovery/naabu https://projectdiscovery.io"
SRC_URI="
	https://github.com/projectdiscovery/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="test"

RDEPEND=""

DEPEND="${RDEPEND}"
BDEPEND="
	net-libs/libpcap
	dev-lang/go
"

QA_PREBUILD="*"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	default
}

src_unpack() {
	go-module_src_unpack
}

src_compile() {

local naabu_ldflags=(
		"-s"
		"-w"
		"-X main.Version=${PV}"
		"-X main.BuildTime=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
	)

	ego build \
		-trimpath \
		-buildmode=pie \
		-mod=readonly \
		-modcacherw \
		-ldflags "${naabu_ldflags[*]}" \
		-o ${PN} \
		./cmd/${PN}
}

src_install() {
	newbin ${PN} ${PN}

	# Man page if present.
	if [[ -f man/man1/naabu.1 ]]; then
		doman man/man1/naabu.1
	fi
}

pkg_postinst() {
	elog "More informations:"
	elog "  - Documentation: https://docs.projectdiscovery.io/opensource/naabu/overview#naabu-overview"
	elog ""
}
