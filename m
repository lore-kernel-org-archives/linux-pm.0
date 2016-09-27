From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] tools/power/cpupower: Add 64 bit library detection
Date: Tue, 27 Sep 2016 07:30:22 -0400
Message-ID: <1474975822-13319-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbcI0Lam (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 07:30:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Thomas Renninger <trenn@suse.com>

The kernel-tools-lib rpm is installing the library to /usr/lib64, and not
/usr/lib as the cpupower Makefile is doing in the kernel tree.  This
resulted in a conflict between the two libraries.  After looking at how
other tools installed libraries, and looking at the perf code in
tools/perf it looks like installing to /usr/lib64 for 64-bit arches is the
correct thing to do.

Checks with 'ldd cpupower' on SLES, RHEL, Fedora, and Ubuntu result in
the correct binary AFAICT:

[root@testsystem cpupower]# ldd cpupower | grep cpupower
        libcpupower.so.0 => /lib64/libcpupower.so.0 (0x00007f1dab447000)

P.

----8<----

Commit ac5a181d065d ("cpupower: Add cpuidle parts into library") added a
new cpupower library version.  On Fedora, executing the cpupower binary then
resulted in this error

[root@testsystem cpupower]# ./cpupower monitor
./cpupower: symbol lookup error: ./cpupower: undefined symbol: get_cpu_topology

64-bit libraries should be installed to /usr/lib64, and other libraries
should be installed to /usr/lib.

This code was taken from the perf Makefile.config which supports /usr/lib and
/usr/lib64.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/Makefile             |    6 ++++++
 tools/power/cpupower/libcpupower.so.0.0.1 |  Bin 0 -> 70760 bytes
 2 files changed, 6 insertions(+)
 create mode 100755 tools/power/cpupower/libcpupower.so.0.0.1

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 8358863259c5..a210f044fc85 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -30,6 +30,8 @@ OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
+include ../../scripts/Makefile.arch
+
 # --- CONFIGURATION BEGIN ---
 
 # Set the following to `true' to make a unstripped, unoptimized
@@ -79,7 +81,11 @@ bindir ?=	/usr/bin
 sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
 includedir ?=	/usr/include
+ifeq ($(IS_64_BIT), 1)
+libdir ?=	/usr/lib64
+else
 libdir ?=	/usr/lib
+endif
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
 confdir ?=      /etc/
diff --git a/tools/power/cpupower/libcpupower.so.0.0.1 b/tools/power/cpupower/libcpupower.so.0.0.1
new file mode 100755
index 0000000000000000000000000000000000000000..86cf76fa6d77802433ef3bb4e7b3de99c6865250
GIT binary patch
literal 70760
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
bPM1FpC(l2+d1CD^uK1STMF%ev%$5HE@AHvB

literal 0
HcmV?d00001

-- 
1.7.9.3

