# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit cmake flag-o-matic python-single-r1

DESCRIPTION="plain-C Protocol Buffers for embedded/memory-constrained systems"
HOMEPAGE="https://jpa.kapsi.fi/nanopb/ https://github.com/nanopb/nanopb"
SRC_URI="https://github.com/nanopb/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="doc examples +pb-malloc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/protobuf
	$(python_gen_cond_dep '
		dev-python/grpcio-tools[${PYTHON_USEDEP}]
	')
"
DEPEND="
	dev-build/scons
	${RDEPEND}
"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	use pb-malloc && append-cppflags "-DPB_ENABLE_MALLOC"

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_optimize
}

src_test() {
	cd "${S}"/tests
	scons
}
