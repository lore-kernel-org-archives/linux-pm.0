From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] PM / timekeeping: Print debug messages when requested
Date: Wed, 19 Jul 2017 02:42:43 +0200
Message-ID: <23461968.oJ1tNQorSa@aspire.rjw.lan>
References: <2539550.y54cRb749c@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50177 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751906AbdGSAvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 20:51:00 -0400
In-Reply-To: <2539550.y54cRb749c@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The messages printed by tk_debug_account_sleep_time() are basically
useful for system sleep debugging, so print them only when the other
debug messages from the core suspend/hibernate code are enabled.

While at it, make it clear that the messages from
tk_debug_account_sleep_time() are about timekeeping suspend
duration, because in general timekeeping may be suspeded and
resumed for multiple times during one system suspend-resume cycle.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/suspend.h         |   10 ++++++++--
 kernel/power/main.c             |   10 +++++++---
 kernel/time/timekeeping_debug.c |    5 +++--
 3 files changed, 18 insertions(+), 7 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -491,16 +491,22 @@ static inline void unlock_system_sleep(v
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
-extern __printf(1, 2) void pm_pr_dbg(const char *fmt, ...);
+extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
 #else
 #define pm_print_times_enabled	(false)
 
 #include <linux/printk.h>
 
-#define pm_pr_dbg(fmt, ...) \
+#define pm_pr_dbg(defer, fmt, ...) \
 	no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
 #endif
 
+#define pm_pr_dbg(fmt, ...) \
+	__pm_pr_dbg(false, fmt, ##__VA_ARGS__)
+
+#define pm_deferred_pr_dbg(fmt, ...) \
+	__pm_pr_dbg(true, fmt, ##__VA_ARGS__)
+
 #ifdef CONFIG_PM_AUTOSLEEP
 
 /* kernel/power/autosleep.c */
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -388,13 +388,14 @@ static ssize_t pm_debug_messages_store(s
 power_attr(pm_debug_messages);
 
 /**
- * pm_pr_dbg - Print a suspend debug message to the kernel log.
+ * __pm_pr_dbg - Print a suspend debug message to the kernel log.
+ * @defer: Whether or not to use printk_deferred() to print the message.
  * @fmt: Message format.
  *
  * The message will be emitted if enabled through the pm_debug_messages
  * sysfs attribute.
  */
-void pm_pr_dbg(const char *fmt, ...)
+void __pm_pr_dbg(bool defer, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -407,7 +408,10 @@ void pm_pr_dbg(const char *fmt, ...
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "PM: %pV", &vaf);
+	if (defer)
+		printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
+	else
+		printk(KERN_DEBUG "PM: %pV", &vaf);
 
 	va_end(args);
 }
Index: linux-pm/kernel/time/timekeeping_debug.c
===================================================================
--- linux-pm.orig/kernel/time/timekeeping_debug.c
+++ linux-pm/kernel/time/timekeeping_debug.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/seq_file.h>
+#include <linux/suspend.h>
 #include <linux/time.h>
 
 #include "timekeeping_internal.h"
@@ -75,7 +76,7 @@ void tk_debug_account_sleep_time(struct
 	int bin = min(fls(t->tv_sec), NUM_BINS-1);
 
 	sleep_time_bin[bin]++;
-	printk_deferred(KERN_INFO "Suspended for %lld.%03lu seconds\n",
-			(s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
+	pm_deferred_pr_dbg("Timekeeping suspended for %lld.%03lu seconds\n",
+			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
 
