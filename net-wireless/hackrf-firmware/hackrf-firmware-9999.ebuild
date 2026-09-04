# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hardware designs and software for HackRF"
HOMEPAGE="http://greatscottgadgets.com/hackrf/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/mossmann/hackrf.git"
	inherit git-r3
	KEYWORDS=""
	EGIT_CHECKOUT_DIR="${WORKDIR}/hackrf"
	S="${WORKDIR}/hackrf/firmware/hackrf_usb"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="~net-libs/libhackrf-${PV}:=
		~net-wireless/hackrf-tools-${PV}:=
		sys-devel/gcc-arm-none-eabi:0
		sci-libs/fftw:3.0="
RDEPEND="${DEPEND}
		!<net-wireless/hackrf-tools-${PV}"

src_configure() {
	# Clear all host flags - arm-none-eabi bare-metal cross-compile must not
	# receive host-specific flags (e.g. -march=x86-64-v3, -msse4.2)
	unset CFLAGS CXXFLAGS CPPFLAGS LDFLAGS
	cmake_src_configure
}

src_compile() {
	V=s cmake_src_compile
}

src_install() {
	insinto /usr/share/hackrf
	newins "${BUILD_DIR}/hackrf_usb.bin" hackrf_one_usb-${PV}.bin
	newins "${BUILD_DIR}/hackrf_usb.dfu" hackrf_one_usb-${PV}.dfu
	newins "${WORKDIR}/hackrf/firmware/cpld/sgpio_if/default.xsvf" hackrf_cpld_default-${PV}.xsvf
	ln -s hackrf_one_usb-${PV}.bin "${ED}/usr/share/hackrf/hackrf_one_usb_rom_to_ram.bin"
	ln -s hackrf_one_usb-${PV}.bin "${ED}/usr/share/hackrf/hackrf_one_usb.bin"
	ln -s hackrf_one_usb-${PV}.dfu "${ED}/usr/share/hackrf/hackrf_one_usb_ram.dfu"
	ln -s hackrf_one_usb-${PV}.dfu "${ED}/usr/share/hackrf/hackrf_one_usb.dfu"
}
