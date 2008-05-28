# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_PV=$(replace_version_separator _ -)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An adaptive playlist framework that tracks your listening patterns and dynamically adapts to your taste."
HOMEPAGE="http://www.luminal.org/wiki/index.php/IMMS/IMMS"
SRC_URI="http://www.luminal.org/files/imms/${MY_P}.tar.bz2"

LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE="analyzer audacious bmpx vorbis remote"
DEPEND=">=dev-db/sqlite-3
>=dev-libs/glib-2
dev-libs/libpcre
|| ( media-libs/id3lib media-libs/taglib )
analyzer? ( >=sci-libs/fftw-3.0 sci-libs/torch >=media-sound/sox-14.0 )
remote? ( >=gnome-base/libglade-2.0 >=x11-libs/gtk+-2 )
vorbis? ( media-libs/libvorbis )
audacious? ( media-sound/audacious )
bmpx? ( media-sound/bmpx )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-soxcmdline.patch"
}

src_compile() {
	cd "${S}"
	econf \
		--disable-queuecontrol \
		$(use_enable analyzer ) \
		$(use_enable remote immsremote ) \
		$(use_with audacious ) \
		$(use_with bmpx bmp ) \
		$(use_with vorbis ) \
		|| die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
	cd "${S}"
	dobin build/immsd || die
	dobin build/immstool || die
	if use analyzer
	then
		dobin build/analyzer || die
	fi
	if use remote
	then
		dobin build/immsremote || die
		insinto /usr/share/${PN}
		doins immsremote/immsremote.glade
	fi

	if use bmpx
	then
		exeinto "/usr/lib/bmpx/plugins/imms"
		doexe build/libbmpimms*.so || die
	fi
	if use audacious
	then
		exeinto "/usr/lib/audacious/General"
		doexe build/libaudaciousimms*.so || die
	fi
	dodoc README AUTHORS
}