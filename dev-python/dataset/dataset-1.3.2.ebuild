# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Easy-to-use data handling for SQL data stores"
HOMEPAGE="https://github.com/pudo/dataset"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=dev-python/sqlalchemy-1.3.2[${PYTHON_USEDEP}]
	>=dev-python/alembic-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/banal-1.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
