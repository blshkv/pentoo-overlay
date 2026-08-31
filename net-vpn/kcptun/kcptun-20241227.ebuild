# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

GO_SOURCE_VERSION="v0.0.0-20260208051026-39935d5307f0"

DESCRIPTION="A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
HOMEPAGE="https://pkg.go.dev/github.com/xtaci/kcptun"

SRC_URI="
	https://proxy.golang.org/github.com/xtaci/kcptun/@v/${GO_SOURCE_VERSION}.zip -> ${P}.zip
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"

KEYWORDS="~amd64 ~arm64"
LICENSE="MIT"
IUSE="+server"
SLOT="0"
S="${WORKDIR}/github.com/xtaci/${PN}@${GO_SOURCE_VERSION}"

src_compile() {
	local ldflags=(
		"-X main.VERSION=${PV}"
		"-w"
	)

	CGO_ENABLED=0 ego build -trimpath -ldflags "${ldflags[*]}" -o "${PN}-client" ./client
	use server && CGO_ENABLED=0 ego build -trimpath -ldflags "${ldflags[*]}" -o "${PN}-server" ./server
}

src_install() {
	dobin ${PN}-client
	use server && dobin ${PN}-server

	insinto "/etc/kcptun"
	for x in client $(usev server); do
		doins "${FILESDIR}"/example-${x}.json

		newinitd "${FILESDIR}"/kcptun-${x}.initd kcptun-${x}
		newconfd "${FILESDIR}"/kcptun-${x}.confd kcptun-${x}
	done
	default
}

pkg_postinst() {
	ewarn "\nSuggested \"/etc/sysctl.conf\" parameters for better handling of UDP packets:"
	ewarn "    net.core.rmem_max=26214400 // BDP - bandwidth delay product"
	ewarn "    net.core.rmem_default=26214400"
	ewarn "    net.core.wmem_max=26214400"
	ewarn "    net.core.wmem_default=26214400"
	ewarn "    net.core.netdev_max_backlog=2048 // proportional to -rcvwnd"

	einfo "\nSee documentation:"
	einfo "    https://pkg.go.dev/github.com/xtaci/kcptun"
	einfo "    https://github.com/skywind3000/kcp/blob/master/README.en.md\n"
}
