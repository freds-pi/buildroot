################################################################################
#
# cargo
#
################################################################################

CARGO_VERSION = 0.45.0
CARGO_SITE = $(call github,rust-lang,cargo,$(CARGO_VERSION))
CARGO_LICENSE = Apache-2.0 or MIT
CARGO_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

HOST_CARGO_DEPENDENCIES = \
	$(BR2_CMAKE_HOST_DEPENDENCY) \
	host-pkgconf \
	host-openssl \
	host-libhttpparser \
	host-libssh2 \
	host-libcurl \
	host-rustc \
	host-cargo-bin

HOST_CARGO_SNAP_BIN = $(HOST_CARGO_BIN_DIR)/cargo/bin/cargo
HOST_CARGO_HOME = $(HOST_DIR)/share/cargo

HOST_CARGO_SNAP_OPTS = \
	--release \
	$(if $(VERBOSE),--verbose)

HOST_CARGO_ENV = \
	RUSTFLAGS="$(addprefix -Clink-arg=,$(HOST_LDFLAGS))" \
	CARGO_HOME=$(HOST_CARGO_HOME)

define HOST_CARGO_BUILD_CMDS
	(cd $(@D); $(HOST_MAKE_ENV) $(HOST_CARGO_ENV) $(HOST_CARGO_SNAP_BIN) \
		build $(HOST_CARGO_SNAP_OPTS))
endef

define HOST_CARGO_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/target/release/cargo $(HOST_DIR)/bin/cargo
	$(INSTALL) -D package/cargo/config.in \
		$(HOST_DIR)/share/cargo/config
	$(SED) 's/@RUSTC_TARGET_NAME@/$(RUSTC_TARGET_NAME)/' \
		$(HOST_DIR)/share/cargo/config
	$(SED) 's/@CROSS_PREFIX@/$(notdir $(TARGET_CROSS))/' \
		$(HOST_DIR)/share/cargo/config
endef

$(eval $(host-generic-package))
