################################################################################
#
# fmt
#
################################################################################

FMT_VERSION = 7.0.3
FMT_SITE = $(call github,fmtlib,fmt,$(FMT_VERSION))
FMT_LICENSE = MIT with exception
FMT_LICENSE_FILES = LICENSE.rst
FMT_INSTALL_STAGING = YES

FMT_CONF_OPTS = \
	-DFMT_INSTALL=ON \
	-DFMT_TEST=OFF

$(eval $(cmake-package))
