From: shuah <shuah@kernel.org>
Subject: [GIT PULL] cpupower update for Linux 4.20-rc4
Date: Tue, 20 Nov 2018 14:16:09 -0700
Message-ID: <31b25f3d-f727-a94f-83cc-3258444abf11@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9F3D728952903B7190E3A501"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, trenn@suse.de, shuah@kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F3D728952903B7190E3A501
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following update for Linux 4.20-rc4 or rc5 depending on 
your pm pull schedule to Linus.

This cpupower update for Linux 4.20-rc4 consists of compile fixes to 
allow use of outside build flags and override of CFLAGS from Jiri Olsa, 
and fix to compilation with STATIC=true from Konstantin Khlebnikov.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-4.20-rc4

for you to fetch changes up to dbc4ca339c8dbdd8652ce57c16bf5ef45ee4307e:

   tools cpupower: Override CFLAGS assignments (2018-11-06 08:54:16 -0700)

----------------------------------------------------------------
linux-cpupower-4.20-rc4

This cpupower update for Linux 4.20-rc4 consists of compile fixes to allow
use of outside build flags and override of CFLAGS from Jiri Olsa, and fix
to compilation with STATIC=true from Konstantin Khlebnikov.

----------------------------------------------------------------
Jiri Olsa (2):
       tools cpupower debug: Allow to use outside build flags
       tools cpupower: Override CFLAGS assignments

Konstantin Khlebnikov (1):
       tools/power/cpupower: fix compilation with STATIC=true

  tools/power/cpupower/Makefile              | 12 ++++++------
  tools/power/cpupower/bench/Makefile        |  2 +-
  tools/power/cpupower/debug/x86_64/Makefile |  4 ++--
  tools/power/cpupower/lib/cpufreq.c         |  2 +-
  tools/power/cpupower/lib/cpuidle.c         |  2 +-
  tools/power/cpupower/lib/cpupower.c        |  4 ++--
  tools/power/cpupower/lib/cpupower_intern.h |  2 +-
  7 files changed, 14 insertions(+), 14 deletions(-)

----------------------------------------------------------------


--------------9F3D728952903B7190E3A501
Content-Type: text/x-patch;
 name="linux-cpupower-4.20-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-4.20-rc4.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 1dd5f4fcffd5..db66a952c173 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -129,7 +129,7 @@ WARNINGS += $(call cc-supports,-Wno-pointer-sign)
 WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 WARNINGS += -Wshadow
 
-CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
+override CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
 		-DPACKAGE_BUGREPORT=\"$(PACKAGE_BUGREPORT)\" -D_GNU_SOURCE
 
 UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
@@ -156,12 +156,12 @@ LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
 LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
-CFLAGS +=	-pipe
+override CFLAGS +=	-pipe
 
 ifeq ($(strip $(NLS)),true)
 	INSTALL_NLS += install-gmo
 	COMPILE_NLS += create-gmo
-	CFLAGS += -DNLS
+	override CFLAGS += -DNLS
 endif
 
 ifeq ($(strip $(CPUFREQ_BENCH)),true)
@@ -175,7 +175,7 @@ ifeq ($(strip $(STATIC)),true)
         UTIL_SRC += $(LIB_SRC)
 endif
 
-CFLAGS += $(WARNINGS)
+override CFLAGS += $(WARNINGS)
 
 ifeq ($(strip $(V)),false)
 	QUIET=@
@@ -188,10 +188,10 @@ export QUIET ECHO
 
 # if DEBUG is enabled, then we do not strip or optimize
 ifeq ($(strip $(DEBUG)),true)
-	CFLAGS += -O1 -g -DDEBUG
+	override CFLAGS += -O1 -g -DDEBUG
 	STRIPCMD = /bin/true -Since_we_are_debugging
 else
-	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
+	override CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
 	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
 endif
 
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d79ab161cc75..f68b4bc55273 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -9,7 +9,7 @@ endif
 ifeq ($(strip $(STATIC)),true)
 LIBS = -L../ -L$(OUTPUT) -lm
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
-       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
+       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
 else
 LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
index 59af84b8ef45..b1b6c43644e7 100644
--- a/tools/power/cpupower/debug/x86_64/Makefile
+++ b/tools/power/cpupower/debug/x86_64/Makefile
@@ -13,10 +13,10 @@ INSTALL = /usr/bin/install
 default: all
 
 $(OUTPUT)centrino-decode: ../i386/centrino-decode.c
-	$(CC) $(CFLAGS) -o $@ $<
+	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $<
 
 $(OUTPUT)powernow-k8-decode: ../i386/powernow-k8-decode.c
-	$(CC) $(CFLAGS) -o $@ $<
+	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $<
 
 all: $(OUTPUT)centrino-decode $(OUTPUT)powernow-k8-decode
 
diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 1b993fe1ce23..0c0f3e3f0d80 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -28,7 +28,7 @@ static unsigned int sysfs_cpufreq_read_file(unsigned int cpu, const char *fname,
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
 			 cpu, fname);
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 /* helper function to write a new value to a /sys file */
diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index 9bd4c7655fdb..852d25462388 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -319,7 +319,7 @@ static unsigned int sysfs_cpuidle_read_file(const char *fname, char *buf,
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpuidle/%s", fname);
 
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 
diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 9c395ec924de..9711d628b0f4 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -15,7 +15,7 @@
 #include "cpupower.h"
 #include "cpupower_intern.h"
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 {
 	int fd;
 	ssize_t numread;
@@ -95,7 +95,7 @@ static int sysfs_topology_read_file(unsigned int cpu, const char *fname, int *re
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
 			 cpu, fname);
-	if (sysfs_read_file(path, linebuf, MAX_LINE_LEN) == 0)
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
 		return -1;
 	*result = strtol(linebuf, &endp, 0);
 	if (endp == linebuf || errno == ERANGE)
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
index 92affdfbe417..4887c76d23f8 100644
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -3,4 +3,4 @@
 #define MAX_LINE_LEN 4096
 #define SYSFS_PATH_MAX 255
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen);
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);

--------------9F3D728952903B7190E3A501--
