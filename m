From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] PM / s2idle: Rearrange the main suspend-to-idle loop
Date: Fri, 21 Jul 2017 02:07:54 +0200
Message-ID: <4195890.oK06yMODBD@aspire.rjw.lan>
References: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As a preparation for subsequent changes, rearrange the core
suspend-to-idle code by moving the initial invocation of
dpm_suspend_noirq() into s2idle_loop().

This also causes debug messages from that code to appear in
a less confusing order.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/power.h   |    4 ++++
 kernel/power/suspend.c |   26 +++++++++++++-------------
 2 files changed, 17 insertions(+), 13 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -106,7 +106,13 @@ static void s2idle_loop(void)
 {
 	pm_pr_dbg("suspend-to-idle\n");
 
-	do {
+	while (!dpm_suspend_noirq(PMSG_SUSPEND)) {
+		/*
+		 * Suspend-to-idle equals
+		 * frozen processes + suspended devices + idle processors.
+		 * Thus freeze_enter() should be called right after
+		 * all devices have been suspended.
+		 */
 		freeze_enter();
 
 		if (freeze_ops && freeze_ops->wake)
@@ -120,7 +126,7 @@ static void s2idle_loop(void)
 			break;
 
 		pm_wakeup_clear(false);
-	} while (!dpm_suspend_noirq(PMSG_SUSPEND));
+	}
 
 	pm_pr_dbg("resume from suspend-to-idle\n");
 }
@@ -377,6 +383,11 @@ static int suspend_enter(suspend_state_t
 	if (error)
 		goto Devices_early_resume;
 
+	if (state == PM_SUSPEND_FREEZE && pm_test_level != TEST_PLATFORM) {
+		s2idle_loop();
+		goto Platform_early_resume;
+	}
+
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		pr_err("PM: noirq suspend of devices failed\n");
@@ -389,17 +400,6 @@ static int suspend_enter(suspend_state_t
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	/*
-	 * PM_SUSPEND_FREEZE equals
-	 * frozen processes + suspended devices + idle processors.
-	 * Thus we should invoke freeze_enter() soon after
-	 * all the devices are suspended.
-	 */
-	if (state == PM_SUSPEND_FREEZE) {
-		s2idle_loop();
-		goto Platform_early_resume;
-	}
-
 	error = disable_nonboot_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -245,7 +245,11 @@ enum {
 #define TEST_FIRST	TEST_NONE
 #define TEST_MAX	(__TEST_AFTER_LAST - 1)
 
+#ifdef CONFIG_PM_DEBUG
 extern int pm_test_level;
+#else
+#define pm_test_level	(TEST_NONE)
+#endif
 
 #ifdef CONFIG_SUSPEND_FREEZER
 static inline int suspend_freeze_processes(void)
