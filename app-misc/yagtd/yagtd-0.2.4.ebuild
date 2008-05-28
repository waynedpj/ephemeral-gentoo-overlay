# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Console text todo list manager incorporating major features from Allen's 'Getting Things Done' philosophy and Stephen Covey's 'Seven Habits of Highly Effective People'."
HOMEPAGE="https://gna.org/projects/yagtd/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

src_install() {
	distutils_src_install
	dosym /usr/bin/yagtd.py /usr/bin/yagtd
}