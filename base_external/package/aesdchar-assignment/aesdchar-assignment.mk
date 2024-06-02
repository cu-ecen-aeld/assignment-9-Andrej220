
##############################################################
#
# AESDCHAR-ASSIGNMENT
#
##############################################################

AESDCHAR_ASSIGNMENT_VERSION = 9b5133d8c080d3074e5f1a925251697ec62dd95d
AESDCHAR_ASSIGNMENT_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-Andrej220.git
#AESDCHAR_ASSIGNMENT_OVERRIDE_SRCDIR = $(TOPDIR)/../../assignments-3-and-later-Andrej220/aesd-char-driver
#'#GITHUB REPOSITORY LINK'
AESDCHAR_ASSIGNMENT_SITE_METHOD = git
AESDCHAR_ASSIGNMENT_GIT_SUBMODULES = YES

AESDCHAR_ASSIGNMENT_MODULE_SUBDIRS = 
AESDCHAR_ASSIGNMENT_MODULE_MAKE_OPTS = ARCH=$(KERNEL_ARCH) KVERSION=$(LINUX_VERSION_PROBED) 
#EXTRA_CFLAGS += -I$(BUILDROOT_KERNEL_HEADERS_PATH)

define AESDCHAR_ASSIGNMENT_BUILD_CMDS
	$(info WORK_DIR=$(@D))
$(MAKE) $(TARGET_CONFIGURE_OPTS) $(AESDCHAR_ASSIGNMENT_MODULE_MAKE_OPTS) -C $(@D)/aesd-char-driver SUBDIRS="$(AESDCHAR_ASSIGNMENT_MODULE_SUBDIRS)" KERNELDIR=$(LINUX_DIR)
endef

$(eval $(kernel-module))
define AESDCHAR_ASSIGNMENT_INSTALL_TARGET_CMDS
		$(INSTALL) -d $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/char/
		$(INSTALL) -m 0644 $(@D)/aesd-char-driver/aesdchar.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/char/
		$(INSTALL) -m 0744 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/etc/init.d/S96aesdchar_load

endef
AESDCHAR_ASSIGNMENT_POST_BUILD_HOOKS += AESDCHAR_ASSIGNMENT_INSTALL_TARGET_CMDS AESDCHAR_ASSIGNMENT_BUILD_CMDS
$(eval $(generic-package))
