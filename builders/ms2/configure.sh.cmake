#!/bin/sh

export CC=@LINPHONE_BUILDER_TOOLCHAIN_CC@
export CXX=@LINPHONE_BUILDER_TOOLCHAIN_CXX@
export LD=@LINPHONE_BUILDER_TOOLCHAIN_LD@
export AR=@LINPHONE_BUILDER_TOOLCHAIN_AR@
export RANLIB=@LINPHONE_BUILDER_TOOLCHAIN_RANLIB@
export STRIP=@LINPHONE_BUILDER_TOOLCHAIN_STRIP@
export NM=@LINPHONE_BUILDER_TOOLCHAIN_NM@

export CPPFLAGS="@LINPHONE_BUILDER_TOOLCHAIN_CPPFLAGS@ @EP_ms2_EXTRA_CPPFLAGS@"
export CFLAGS="@LINPHONE_BUILDER_TOOLCHAIN_CFLAGS@ @EP_ms2_EXTRA_CFLAGS@"
export CXXFLAGS="@LINPHONE_BUILD_TOOLCHAIN_CXXFLAGS@ @EP_ms2_EXTRA_CXXFLAGS@"
export LDFLAGS="@LINPHONE_BUILDER_TOOLCHAIN_LDFLAGS@ @EP_ms2_EXTRA_LDFLAGS@"

export PKG_CONFIG_PATH="@LINPHONE_BUILDER_PKG_CONFIG_PATH@"
export PKG_CONFIG_LIBDIR="@LINPHONE_BUILDER_PKG_CONFIG_LIBDIR@"

cd @ep_build@

if [ ! -f mediastreamer-config.h ]
then
	@ep_source@/autogen.sh
	@ep_source@/configure "--prefix=@CMAKE_INSTALL_PREFIX@" "--host=@LINPHONE_BUILDER_TOOLCHAIN_HOST@" @ep_ms2_config_options@
fi
