# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1

DESCRIPTION="ASGI Middleware for serving Static File"
HOMEPAGE="https://github.com/rexzhang/asgi-middleware-static-file"
SRC_URI="https://github.com/rexzhang/asgi-middleware-static-file/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="
	>=dev-python/aiofiles-25.1.0[${PYTHON_USEDEP}]
	dev-python/asgiref[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	sed -i -e 's/"--cov.*/""/' pyproject.toml
	distutils-r1_src_prepare
}

python_install_all() {
	if use examples; then
		dodoc -r example
		docompress -x /usr/share/doc/${PF}/example
	fi
	distutils-r1_python_install_all
}
