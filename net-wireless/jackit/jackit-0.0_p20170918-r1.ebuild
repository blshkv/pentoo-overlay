# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Exploit Code for Mousejack"
HOMEPAGE="https://github.com/insecurityofthings/jackit"
COMMIT="1c057fad102af7daad537421d95e2695caeff2b7"
SRC_URI="https://github.com/insecurityofthings/jackit/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE=${PYTHON_REQUIRED_USE}

DEPEND=""
RDEPEND="${DEPEND}
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/pyusb[${PYTHON_USEDEP}]"
