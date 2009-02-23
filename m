From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pm: rework includes, remove arch ifdefs
Date: Mon, 23 Feb 2009 17:02:04 +0900
Message-ID: <20090223080204.13536.67018.sendpatchset__7977.4675345563$1235376497$gmane$org@rx1.opensource.se>
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

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 These are the only generic changes needed to get
 CONFIG_HIBERNATION working on SuperH.

 include/linux/suspend.h |    3 ---
 kernel/power/disk.c     |    1 +
 kernel/power/swsusp.c   |    1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

--- 0001/include/linux/suspend.h
+++ work/include/linux/suspend.h	2009-02-23 14:44:28.000000000 +0900
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
+++ work/kernel/power/disk.c	2009-02-23 14:44:02.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <asm/suspend.h>
 
 #include "power.h"
 
--- 0001/kernel/power/swsusp.c
+++ work/kernel/power/swsusp.c	2009-02-23 14:43:17.000000000 +0900
@@ -51,6 +51,7 @@
 #include <linux/highmem.h>
 #include <linux/time.h>
 #include <linux/rbtree.h>
+#include <linux/io.h>
 
 #include "power.h"
 
