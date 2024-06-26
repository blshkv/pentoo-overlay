# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CKV="5.18.0_pre"
ETYPE="sources"
inherit kernel-2 git-r3

DESCRIPTION="Wireless integration testing tree"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-testing.git/"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-testing.git"
EGIT_CHECKOUT_DIR="linux-wireless-testing"

LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/linux-${PN}"
