From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] PM / suspend: Define pr_fmt() in suspend.c
Date: Fri, 21 Jul 2017 14:50:48 +0200
Message-ID: <2053811.tIauxJhVzR@aspire.rjw.lan>
References: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61883 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751400AbdGUM6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 08:58:53 -0400
In-Reply-To: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define a common prefix ("PM:") for messages printed by the
code in kernel/power/suspend.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -8,6 +8,8 @@
  * This file is released under the GPLv2.
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -389,7 +391,7 @@ static int suspend_enter(suspend_state_t
 
 	error = dpm_suspend_late(PMSG_SUSPEND);
 	if (error) {
-		pr_err("PM: late suspend of devices failed\n");
+		pr_err("late suspend of devices failed\n");
 		goto Platform_finish;
 	}
 	error = platform_suspend_prepare_late(state);
@@ -403,7 +405,7 @@ static int suspend_enter(suspend_state_t
 
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
-		pr_err("PM: noirq suspend of devices failed\n");
+		pr_err("noirq suspend of devices failed\n");
 		goto Platform_early_resume;
 	}
 	error = platform_suspend_prepare_noirq(state);
@@ -477,7 +479,7 @@ int suspend_devices_and_enter(suspend_st
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
-		pr_err("PM: Some devices failed to suspend, or early wake event detected\n");
+		pr_err("Some devices failed to suspend, or early wake event detected\n");
 		goto Recover_platform;
 	}
 	suspend_test_finish("suspend devices");
@@ -534,7 +536,7 @@ static int enter_state(suspend_state_t s
 	if (state == PM_SUSPEND_FREEZE) {
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
-			pr_warn("PM: Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
+			pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
 			return -EAGAIN;
 		}
 #endif
@@ -549,7 +551,7 @@ static int enter_state(suspend_state_t s
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	pr_info("PM: Syncing filesystems ... ");
+	pr_info("Syncing filesystems ... ");
 	sys_sync();
 	pr_cont("done.\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
@@ -592,7 +594,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
-	pr_info("PM: suspend entry (%s)\n", mem_sleep_labels[state]);
+	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -600,7 +602,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
-	pr_info("PM: suspend exit\n");
+	pr_info("suspend exit\n");
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
