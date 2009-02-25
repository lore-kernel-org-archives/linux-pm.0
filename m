From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pm: rework includes, remove arch ifdefs V2
Date: Wed, 25 Feb 2009 12:59:29 +0900
Message-ID: <20090225035929.18506.46282.sendpatchset__25557.5403840796$1235534672$gmane$org@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains the following header file changes:
 - remove arch ifdefs and asm/suspend.h from linux/suspend.h
 - add asm/suspend.h to disk.c (for arch_prepare_suspend())
 - add linux/io.h to swsusp.c (for ioremap())
 - x86 32/64 bit compile fixes

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 These are the only generic changes needed to get
 CONFIG_HIBERNATION working on SuperH.

 Changes since V1:
 - x86 32/64 bit compile fixes, thanks akpm!

 arch/x86/kernel/asm-offsets_32.c |    1 +
 arch/x86/kernel/asm-offsets_64.c |    1 +
 arch/x86/power/cpu_32.c          |    1 +
 arch/x86/power/cpu_64.c          |    1 +
 arch/x86/power/hibernate_64.c    |    1 +
 include/linux/suspend.h          |    3 ---
 kernel/power/disk.c              |    1 +
 kernel/power/swsusp.c            |    1 +
 8 files changed, 7 insertions(+), 3 deletions(-)

--- 0001/arch/x86/kernel/asm-offsets_32.c
+++ work/arch/x86/kernel/asm-offsets_32.c	2009-02-25 12:20:52.000000000 +0900
@@ -18,6 +18,7 @@
 #include <asm/thread_info.h>
 #include <asm/bootparam.h>
 #include <asm/elf.h>
+#include <asm/suspend.h>
 
 #include <xen/interface/xen.h>
 
--- 0001/arch/x86/kernel/asm-offsets_64.c
+++ work/arch/x86/kernel/asm-offsets_64.c	2009-02-25 12:20:52.000000000 +0900
@@ -17,6 +17,7 @@
 #include <asm/thread_info.h>
 #include <asm/ia32.h>
 #include <asm/bootparam.h>
+#include <asm/suspend.h>
 
 #include <xen/interface/xen.h>
 
--- 0001/arch/x86/power/cpu_32.c
+++ work/arch/x86/power/cpu_32.c	2009-02-25 12:20:52.000000000 +0900
@@ -12,6 +12,7 @@
 #include <asm/mtrr.h>
 #include <asm/mce.h>
 #include <asm/xcr.h>
+#include <asm/suspend.h>
 
 static struct saved_context saved_context;
 
--- 0001/arch/x86/power/cpu_64.c
+++ work/arch/x86/power/cpu_64.c	2009-02-25 12:20:52.000000000 +0900
@@ -15,6 +15,7 @@
 #include <asm/pgtable.h>
 #include <asm/mtrr.h>
 #include <asm/xcr.h>
+#include <asm/suspend.h>
 
 static void fix_processor_context(void);
 
--- 0001/arch/x86/power/hibernate_64.c
+++ work/arch/x86/power/hibernate_64.c	2009-02-25 12:20:52.000000000 +0900
@@ -14,6 +14,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/mtrr.h>
+#include <asm/suspend.h>
 
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
--- 0001/include/linux/suspend.h
+++ work/include/linux/suspend.h	2009-02-24 15:03:52.000000000 +0900
@@ -1,9 +1,6 @@
 #ifndef _LINUX_SUSPEND_H
 #define _LINUX_SUSPEND_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
-#include <asm/suspend.h>
-#endif
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
--- 0001/kernel/power/disk.c
+++ work/kernel/power/disk.c	2009-02-24 15:03:52.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <asm/suspend.h>
 
 #include "power.h"
 
--- 0001/kernel/power/swsusp.c
+++ work/kernel/power/swsusp.c	2009-02-24 15:03:52.000000000 +0900
@@ -51,6 +51,7 @@
 #include <linux/highmem.h>
 #include <linux/time.h>
 #include <linux/rbtree.h>
+#include <linux/io.h>
 
 #include "power.h"
 
