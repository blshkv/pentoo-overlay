# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Logging formatter which produces well-formatted RFC5424 Syslog Protocol messages"
HOMEPAGE="https://github.com/easypost/syslog-rfc5424-formatter"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
