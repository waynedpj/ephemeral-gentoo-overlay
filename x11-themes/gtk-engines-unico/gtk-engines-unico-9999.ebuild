# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools bzr

DESCRIPTION="Gtk+ engine that aims to be the more complete yet powerful theming engine for Gtk+ 3.0 and newer"
HOMEPAGE="https://launchpad.net/unico"
EBZR_REPO_URI="lp:unico"

LICENSE=""
SLOT="3"
KEYWORDS="~amd64"

IUSE=""

DEPEND=">=x11-libs/gtk+-3.1.6:3
		dev-libs/glib:2
		x11-libs/cairo
		dev-util/pkgconfig"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}


# The following src_compile function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
# For EAPI < 2 src_compile runs also commands currently present in
# src_configure. Thus, if you're using an older EAPI, you need to copy them
# to your src_compile and drop the src_configure function.
#src_compile() {
	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, because some makefiles have bugs
	# related to parallelism, in these cases, use emake -j1 to limit
	# make to a single process.  The -j1 is a visual clue to others
	# that the makefiles have bugs that have been worked around.

	#emake || die
#}

# The following src_install function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
# For EAPI < 4 src_install is just returing true, so you need to always specify
# this function in older EAPIs.
#src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	#emake DESTDIR="${D}" install || die

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die
#}
