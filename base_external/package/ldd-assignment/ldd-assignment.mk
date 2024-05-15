
##############################################################
#
# LDD-ASSIGNMENT
#
##############################################################

LDD_ASSIGNMENT_VERSION = b0be8362524fca1a586b860b2d672bd543688385
LDD_ASSIGNMENT_SITE = git@github.com:cu-ecen-aeld/assignment-7-Andrej220.git
#LDD_ASSIGNMENT_OVERRIDE_SRCDIR = $(TOPDIR)/../../../assignment7
#'#GITHUB REPOSITORY LINK'
LDD_ASSIGNMENT_SITE_METHOD = git
LDD_ASSIGNMENT_GIT_SUBMODULES = YES

LDD_ASSIGNMENT_MODULE_SUBDIRS = misc-modules scull
LDD_ASSIGNMENT_MODULE_MAKE_OPTS = ARCH=$(KERNEL_ARCH) KVERSION=$(LINUX_VERSION_PROBED) 
#EXTRA_CFLAGS += -I$(BUILDROOT_KERNEL_HEADERS_PATH)

define LDD_ASSIGNMENT_BUILD_CMDS
	$(info WORK_DIR=$(@D))
$(MAKE) $(TARGET_CONFIGURE_OPTS) $(LDD_ASSIGNMENT_MODULE_MAKE_OPTS) -C $(@D) SUBDIRS="$(LDD_ASSIGNMENT_MODULE_SUBDIRS)" KERNELDIR=$(LINUX_DIR)
endef

$(eval $(kernel-module))
define LDD_ASSIGNMENT_INSTALL_TARGET_CMDS
		$(INSTALL) -d $(TARGET_DIR)/lib/modules/
        	$(INSTALL) -m 0644 $(@D)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/
        	$(INSTALL) -m 0644 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/
        	$(INSTALL) -m 0644 $(@D)/scull/scull.ko $(TARGET_DIR)/lib/modules/
endef
LDD_ASSIGNMENT_POST_BUILD_HOOKS += LDD_ASSIGNMENT_INSTALL_TARGET_CMDS LDD_ASSIGNMENT_BUILD_CMDS
$(eval $(generic-package))
