# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN}-standalone"
MY_PV="${PV/_beta/b}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Jython is an implementation of the Python programming language written in Java"
HOMEPAGE="https://www.jython.org/"
SRC_URI="https://repo1.maven.org/maven2/org/python/${MY_PN}/${MY_PV}/${MY_P}.jar"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="|| ( virtual/jre virtual/jdk )"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/${MY_P}.jar" || die
}

src_install() {
	insinto "/opt/${MY_PN}/"
	doins "${MY_P}.jar"
	dosym -r "${EPREFIX}/opt/${MY_PN}/${MY_P}.jar" "/opt/${MY_PN}/${MY_PN}.jar"
}
