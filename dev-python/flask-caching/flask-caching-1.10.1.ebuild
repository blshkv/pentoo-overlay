# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Continuation of the Flask-Cache Extension"
HOMEPAGE="https://github.com/sh4nks/flask-caching"
SRC_URI="https://github.com/sh4nks/flask-caching/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
RESTRICT="test"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/flask[${PYTHON_USEDEP}]"
