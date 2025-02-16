# Copyright (c) 2024 Jema Technology and the openJema Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2015-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/nemtrif/utfcpp"
	EGIT_SUBMODULES=()
fi

DESCRIPTION="UTF-8 C++ library"
HOMEPAGE="https://github.com/nemtrif/utfcpp"
if [[ "${PV}" == "9999" ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/nemtrif/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 arm64 ppc ppc64 sparc x86 arm"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND=""
DEPEND="test? ( dev-cpp/gtest )"
RDEPEND=""

src_prepare() {
        cros_enable_cxx_exceptions
	sed -e "/add_subdirectory(extern\/gtest)/d" -i CMakeLists.txt || die
	sed -e "s/gtest_main/gtest &/" -i tests/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUTF8_SAMPLES=OFF
		-DUTF8_TESTS=$(usex test ON OFF)
	)

	cmake_src_configure
}
