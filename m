From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 2/5] cpupower: Provide STATIC variable in Makefile for debug builds
Date: Tue,  1 Dec 2015 17:14:14 +0100
Message-ID: <1448986457-12844-3-git-send-email-trenn@suse.com>
References: <1448986457-12844-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49851 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580AbbLAQOV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Dec 2015 11:14:21 -0500
In-Reply-To: <1448986457-12844-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, "sriram@marirs.net.in" <sriram@marirs.net.in>

When working on cpupower code, you often want to compile library code into the
binary.
This allows to execute modified cpupower code, even with library changes
without doing "make install"

CC: sriram@marirs.net.in <sriram@marirs.net.in>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/Makefile       | 19 +++++++++++++++++++
 tools/power/cpupower/bench/Makefile |  8 +++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 2e2ba2e..0adaf0c 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -47,6 +47,11 @@ NLS ?=		true
 # cpufreq-bench benchmarking tool
 CPUFREQ_BENCH ?= true
 
+# Do not build libraries, but build the code in statically
+# Libraries are still built, otherwise the Makefile code would
+# be rather ugly.
+export STATIC ?= false
+
 # Prefix to the directories we're installing to
 DESTDIR ?=
 
@@ -161,6 +166,12 @@ ifeq ($(strip $(CPUFREQ_BENCH)),true)
 	COMPILE_BENCH += compile-bench
 endif
 
+ifeq ($(strip $(STATIC)),true)
+        UTIL_OBJS += $(LIB_OBJS)
+        UTIL_HEADERS += $(LIB_HEADERS)
+        UTIL_SRC += $(LIB_SRC)
+endif
+
 CFLAGS += $(WARNINGS)
 
 ifeq ($(strip $(V)),false)
@@ -209,7 +220,11 @@ $(OUTPUT)%.o: %.c
 
 $(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 	$(ECHO) "  CC      " $@
+ifeq ($(strip $(STATIC)),true)
+	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lrt -lpci -L$(OUTPUT) -o $@
+else
 	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -lrt -lpci -L$(OUTPUT) -o $@
+endif
 	$(QUIET) $(STRIPCMD) $@
 
 $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
@@ -291,7 +306,11 @@ install-bench:
 	@#DESTDIR must be set from outside to survive
 	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT) install
 
+ifeq ($(strip $(STATIC)),true)
+install: all install-tools install-man $(INSTALL_NLS) $(INSTALL_BENCH)
+else
 install: all install-lib install-tools install-man $(INSTALL_NLS) $(INSTALL_BENCH)
+endif
 
 uninstall:
 	- rm -f $(DESTDIR)${libdir}/libcpupower.*
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index 7ec7021..d0f879b 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -5,9 +5,15 @@ ifneq ($(O),)
 endif
 endif
 
+ifeq ($(strip $(STATIC)),true)
+LIBS = -L../ -L$(OUTPUT) -lm
+OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
+       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
+else
 LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
-
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
+endif
+
 CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
 
 $(OUTPUT)%.o : %.c
-- 
2.1.4

