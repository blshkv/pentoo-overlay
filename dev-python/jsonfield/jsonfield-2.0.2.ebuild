# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A reusable Django field that allows you to store validated JSON "
HOMEPAGE="https://github.com/dmkoch/django-jsonfield/ https://django-filter.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
