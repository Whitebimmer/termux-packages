TERMUX_PKG_HOMEPAGE=https://matt.ucc.asn.au/dropbear/dropbear.html
TERMUX_PKG_DESCRIPTION="Small SSH server and client"
TERMUX_PKG_DEPENDS="libutil"
TERMUX_PKG_VERSION=2016.74
TERMUX_PKG_SRCURL=https://matt.ucc.asn.au/dropbear/releases/dropbear-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=2720ea54ed009af812701bcc290a2a601d5c107d12993e5d92c0f5f81f718891
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-syslog --disable-utmp --disable-utmpx --disable-wtmp"
# Avoid linking to libcrypt for server password authentication:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
TERMUX_PKG_EXTRA_MAKE_ARGS="MULTI=1"
TERMUX_PKG_BUILD_IN_SRC="yes"

termux_step_create_debscripts () {
        echo "mkdir -p $TERMUX_PREFIX/etc/dropbear" >> postinst
        echo "for a in rsa dss ecdsa; do" >> postinst
        echo "    KEYFILE=$TERMUX_PREFIX/etc/dropbear/dropbear_\${a}_host_key" >> postinst
        echo "    test ! -f \$KEYFILE && dropbearkey -t \$a -f \$KEYFILE" >> postinst
        echo "done" >> postinst
        echo "exit 0" >> postinst
        chmod 0755 postinst
}
