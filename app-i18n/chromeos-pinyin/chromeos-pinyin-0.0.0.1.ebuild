# Copyright (c) 2024 Jema Technology and the openJema Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"
inherit eutils

DESCRIPTION="The Chinese Pinyin input engine for IME extension API"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

S="${WORKDIR}"

src_prepare () {
	cp -r ${FILESDIR}/chromeos-pinyin ${S}
}

src_install() {
	insinto /usr/share/chromeos-assets/input_methods/pinyin/
	doins -r ${WORKDIR}/chromeos-pinyin/*
}
