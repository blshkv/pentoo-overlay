# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Runtime mobile exploration"
HOMEPAGE="https://github.com/sensepost/objection"
#to re-generate node_modules run "npm build agent/" in WORKDIR
SRC_URI="https://github.com/sensepost/objection/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/objection-1.9.5-node_modules.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="patchapk"

RDEPEND=">=dev-util/frida-tools-7.0.0[${PYTHON_USEDEP}]
	virtual/frida[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.3[${PYTHON_USEDEP}] <dev-python/prompt-toolkit-4.0.0[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	>=dev-python/semver-2[${PYTHON_USEDEP}]
	dev-python/delegator[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	>=dev-db/litecli-1.3.0[${PYTHON_USEDEP}]
	net-libs/nodejs[npm]
	patchapk? (
		dev-util/android-sdk-build-tools
		dev-util/android-tools
		virtual/jdk:*
		dev-util/apktool
	)"
#patchapk
#https://github.com/sensepost/objection/wiki/Patching-Android-Applications#patching---dependencies
#patchipa
#https://github.com/sensepost/objection/wiki/Patching-iOS-Applications#patching---dependencies

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	rm -r tests
	# https://github.com/sensepost/objection/issues/652
	sed -i "s|semver>=2,<3|semver>=2|" requirements.txt || die
	mv "${WORKDIR}/node_modules" "${S}/agent/" || die "unable to move node_modules"
	eapply_user
}

python_compile() {
	addpredict /etc/npm
	emake frida-agent
	distutils-r1_python_compile
}
