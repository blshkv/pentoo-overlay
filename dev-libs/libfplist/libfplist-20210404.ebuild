# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for plist format"
HOMEPAGE="https://github.com/libyal/libfplist"
SRC_URI="https://github.com/libyal/libfplist/releases/download/${PV}/${PN}-experimental-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls +threads debug"

DEPEND="
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	dev-libs/libcdata[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcthreads[nls=]
	dev-libs/libfguid[nls=]
	dev-libs/libfvalue[nls=]
	dev-libs/libuna[nls=]
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \
		$(use_enable threads multi-threading-support) \

}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}