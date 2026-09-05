# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="sensepost/hostapd-mana"
GITHUB_TAG="${PV}"
inherit toolchain-funcs savedconfig github-archive

MY_PN="hostapd"
S="${S}/${MY_PN}"

DESCRIPTION="SensePost's modified hostapd for wifi attacks"
HOMEPAGE="https://w1f1.net https://github.com/sensepost/hostapd-mana"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="internal-tls netlink sqlite"

DEPEND="
	internal-tls? ( dev-libs/libtommath )
	!internal-tls? ( dev-libs/openssl:0=[-bindist(-)] )
	kernel_linux? (
		dev-libs/libnl:3
	)
	netlink? ( net-libs/libnfnetlink )
	sqlite? ( >=dev-db/sqlite-3 )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	sed -e "s:/etc/hostapd:/etc/${PN}:g" -i ./hostapd.conf || die

	pushd ../ >/dev/null || die
	default
	eapply "${FILESDIR}"/update_hostapd.conf.patch
	popd >/dev/null || die
}

src_configure() {
	local CONFIG="${S}"/.config
	restore_config "${CONFIG}"
	if [[ ! -f "${CONFIG}" ]]; then
		cp defconfig "${CONFIG}" || die
	fi
	# Ensure the Gentoo toolchain wrapper is used (fixes calling cc/gcc directly)
	sed -i '/^CC\s*=/d' "${CONFIG}"
	echo "CC = $(tc-getCC)" >> "${CONFIG}" || die
}

src_compile() {
	emake V=1
}

src_install() {
	insinto "/etc/${PN}"
	doins ${MY_PN}.{conf,accept,deny,eap_user,radius_clients,sim_db,wpa_psk}

	newsbin ${MY_PN} hostapd-mana
	newbin ${MY_PN}_cli hostapd-mana_cli

	fperms -R 600 "/etc/${PN}"

	dodoc ChangeLog README

	save_config .config
}
