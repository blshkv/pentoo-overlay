# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="This tool generates Go language bindings of services in protobuf definition files for gRPC"
HOMEPAGE="https://pkg.go.dev/google.golang.org/grpc/cmd/protoc-gen-go-grpc"
SRC_URI="
	https://github.com/grpc/grpc-go/archive/refs/tags/cmd/protoc-gen-go-grpc/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"
LICENSE="BSD"
SLOT="0/${PVR}"
KEYWORDS="amd64 x86"
IUSE="test"
DEPEND="test? ( dev-libs/protobuf )"
RDEPEND=""
RESTRICT="!test? ( test )"

S="${WORKDIR}/grpc-go-cmd-protoc-gen-go-grpc-v${PV}/cmd/protoc-gen-go-grpc"
src_compile() {
	GOBIN="${S}/bin" ego install ./... ||
		die "compile failed"
}

src_install() {
	dobin bin/protoc-gen-go-grpc
}
