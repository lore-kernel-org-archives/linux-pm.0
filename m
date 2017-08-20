From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] kbuild: use $(abspath ...) instead of $(shell cd ... && /bin/pwd)
Date: Sun, 20 Aug 2017 15:04:11 +0900
Message-ID: <1503209051-16477-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>, =?UTF-8?q?Bj=C3=B8rn=20Forsman?= <bjorn.forsman@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-pm@vger.kernel.org, Kieran Bingham <kieran@bingham.xyz>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
List-Id: linux-pm@vger.kernel.org

Kbuild conventionally uses $(shell cd ... && /bin/pwd) idiom to get
the absolute path of the directory because GNU Make 3.80, the minimal
supported version at that time, did not support $(abspath ...) or
$(realpath ...).

Commit 37d69ee30808 ("docs: bump minimal GNU Make version to 3.81")
dropped the GNU Make 3.80 support, so we are now allowed to use those
make-builtin helpers.

This conversion will provide better portability without relying on
the pwd command or its location /bin/pwd.

I am intentionally using $(realpath ...) instead $(abspath ...) in
some places.  The difference between the two is $(realpath ...)
returns an empty string if the given path does not exist.  It is
convenient in places where we need to error-out if the makefile fails
to create an output directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                       | 12 ++++++------
 scripts/gdb/linux/Makefile     |  2 +-
 tools/power/cpupower/Makefile  |  2 +-
 tools/scripts/Makefile.include |  6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 90da7bdc3f45..dfb6c88ea859 100644
--- a/Makefile
+++ b/Makefile
@@ -130,8 +130,8 @@ endif
 ifneq ($(KBUILD_OUTPUT),)
 # check that the output directory actually exists
 saved-output := $(KBUILD_OUTPUT)
-KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
-								&& /bin/pwd)
+$(shell [ -d $(KBUILD_OUTPUT) ] || mkdir -p $(KBUILD_OUTPUT))
+KBUILD_OUTPUT := $(realpath $(KBUILD_OUTPUT))
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))
 
@@ -978,7 +978,7 @@ ifdef CONFIG_HEADERS_CHECK
 	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
 endif
 ifdef CONFIG_GDB_SCRIPTS
-	$(Q)ln -fsn `cd $(srctree) && /bin/pwd`/scripts/gdb/vmlinux-gdb.py
+	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
 endif
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
@@ -1237,7 +1237,7 @@ _modinst_:
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/source
 	@mkdir -p $(MODLIB)/kernel
-	@ln -s `cd $(srctree) && /bin/pwd` $(MODLIB)/source
+	@ln -s $(abspath $(srctree)) $(MODLIB)/source
 	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
 		rm -f $(MODLIB)/build ; \
 		ln -s $(CURDIR) $(MODLIB)/build ; \
@@ -1629,11 +1629,11 @@ image_name:
 # Clear a bunch of variables before executing the submake
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/ $*
 
 # Single targets
 # ---------------------------------------------------------------------------
diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index 8b00031f5349..ab3cfe727a4e 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -1,6 +1,6 @@
 always := gdb-scripts
 
-SRCTREE := $(shell cd $(srctree) && /bin/pwd)
+SRCTREE := $(abspath $(srctree))
 
 $(obj)/gdb-scripts:
 ifneq ($(KBUILD_SRC),)
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index d6e1c02ddcfe..4c5a481a850c 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -26,7 +26,7 @@ endif
 
 ifneq ($(OUTPUT),)
 # check that the output directory actually exists
-OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
+OUTDIR := $(realpath $(OUTPUT))
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index ccad8ce925e4..57a850978cef 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -1,7 +1,7 @@
 ifneq ($(O),)
 ifeq ($(origin O), command line)
-	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
-	ABSOLUTE_O := $(shell cd $(O) ; pwd)
+	ABSOLUTE_O := $(realpath $(O))
+	dummy := $(if $(ABSOLUTE_O),,$(error O=$(O) does not exist))
 	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
 	COMMAND_O := O=$(ABSOLUTE_O)
 ifeq ($(objtree),)
@@ -12,7 +12,7 @@ endif
 
 # check that the output directory actually exists
 ifneq ($(OUTPUT),)
-OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
+OUTDIR := $(realpath $(OUTPUT))
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
-- 
2.7.4

