From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH RESEND v2] tools/power/cpupower: Add 64 bit library detection
Date: Fri, 11 Nov 2016 08:40:09 -0500
Message-ID: <1478871609-30529-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754206AbcKKNkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 08:40:12 -0500
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

[v2]: removed binary diff chunk

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/Makefile |    6 ++++++
 1 file changed, 6 insertions(+)

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
-- 
1.7.9.3

