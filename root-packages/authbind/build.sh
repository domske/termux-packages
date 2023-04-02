TERMUX_PKG_HOMEPAGE=https://www.chiark.greenend.org.uk/ucgi/~ian/git/authbind.git
TERMUX_PKG_DESCRIPTION="Bind sockets to privileged ports without root"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.1.2
TERMUX_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/authbind/authbind_${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=7dfb138b6ceeab34d58906be2598812d6dcc83885e650f93414d4851027c968c
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_MAKE_INSTALL_TARGET="install install_man"

termux_step_pre_configure() {
	sed -i 's|/\.$|/|g' Makefile
}

termux_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$TERMUX_PREFIX/bin/sh
		mkdir -p $TERMUX_PREFIX/etc/authbind/byaddr
		mkdir -p $TERMUX_PREFIX/etc/authbind/byport
		mkdir -p $TERMUX_PREFIX/etc/authbind/byuid
		echo
		echo "********"
		echo "Remember to setuid root the helper program"
		echo
		echo "    $TERMUX_PREFIX/libexec/authbind/helper"
		echo "********"
		echo
	EOF
}