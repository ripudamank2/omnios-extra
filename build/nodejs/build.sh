#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}

# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=node
VER=8.11.4
VERHUMAN=$VER
PKG=ooce/runtime/node-811
SUMMARY="Node.js is an evented I/O framework for the V8 JavaScript engine."
DESC="Node.js is an evented I/O framework for the V8 JavaScript engine.\
It is intended for writing scalable network programs such as web servers."

BUILDARCH=64

MAJVER=${VER%.*}           # M.m
sMAJVER=${MAJVER//./}      # Mm

OPREFIX=$PREFIX
PREFIX+=/$PROG-$MAJVER

# objdump is needed to build nodejs
PATH=$PATH:/usr/gnu/i386-pc-solaris2.11/bin

CXXFLAGS+="-ffunction-sections -fdata-sections"
MAKE_ARGS="CC=$CC"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DVERSION=$MAJVER
    -DsVERSION=$sMAJVER
"

CONFIGURE_OPTS_64=" \
    --with-dtrace \
    --dest-cpu=x64 \
    --prefix=$PREFIX \
"
BUILDDIR=$PROG-v$VER
BUILD_DEPENDS_IPS="developer/gnu-binutils"

init
download_source $PROG $PROG v$VER
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
