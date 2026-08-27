# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/owasp-amass/amass"

SRC_URI="
	https://github.com/owasp-amass/amass/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/amass-${PV}/amass-${PV}-deps.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64"
IUSE="ae-isready amass-engine oam-assoc oam-enum oam-i2y oam-subs oam-track +oam-viz"

BDEPEND=">=dev-lang/go-1.26.0:="

src_compile() {
	CGO_ENABLED=0 ego build -trimpath -o amass ./cmd/amass

	use ae-isready   && CGO_ENABLED=0 ego build -trimpath -o ae_isready ./cmd/ae_isready
	use amass-engine && CGO_ENABLED=0 ego build -trimpath -o amass_engine ./cmd/amass_engine
	use oam-assoc    && CGO_ENABLED=0 ego build -trimpath -o oam_assoc ./cmd/oam_assoc
	use oam-enum     && CGO_ENABLED=0 ego build -trimpath -o oam_enum ./cmd/oam_enum
	use oam-i2y      && CGO_ENABLED=0 ego build -trimpath -o oam_i2y ./cmd/oam_i2y
	use oam-subs     && CGO_ENABLED=0 ego build -trimpath -o oam_subs ./cmd/oam_subs
	use oam-track    && CGO_ENABLED=0 ego build -trimpath -o oam_track ./cmd/oam_track
	use oam-viz      && CGO_ENABLED=0 ego build -trimpath -o oam_viz ./cmd/oam_viz
}

src_install() {
	dobin amass

	use ae-isready   && dobin ae_isready
	use amass-engine && dobin amass_engine
	use oam-assoc    && dobin oam_assoc
	use oam-enum     && dobin oam_enum
	use oam-i2y      && dobin oam_i2y
	use oam-subs     && dobin oam_subs
	use oam-track    && dobin oam_track
	use oam-viz      && dobin oam_viz
}
