From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] PM / sleep: Check pm_wakeup_pending() in __device_suspend_noirq()
Date: Fri, 21 Jul 2017 02:12:10 +0200
Message-ID: <2368592.7JbP7nRucL@aspire.rjw.lan>
References: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52123 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965133AbdGUAUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 20:20:25 -0400
In-Reply-To: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Restore the pm_wakeup_pending() check in __device_suspend_noirq()
removed by commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI
wakeups from suspend-to-idle) as that allows the function to return
earlier if there's a wakeup event pending already (so that it may
spend less time on carrying out operations that will be reversed
shortly anyway) and rework the main suspend-to-idle loop to take
that optimization into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    5 +++++
 kernel/power/suspend.c    |   19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -106,19 +106,32 @@ static void s2idle_loop(void)
 {
 	pm_pr_dbg("suspend-to-idle\n");
 
-	while (!dpm_suspend_noirq(PMSG_SUSPEND)) {
+	for (;;) {
+		int error;
+
+		dpm_noirq_begin();
+
 		/*
 		 * Suspend-to-idle equals
 		 * frozen processes + suspended devices + idle processors.
 		 * Thus freeze_enter() should be called right after
 		 * all devices have been suspended.
 		 */
-		freeze_enter();
+		error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
+		if (!error)
+			freeze_enter();
+
+		dpm_noirq_resume_devices(PMSG_RESUME);
+		if (error && (error != -EBUSY || !pm_wakeup_pending())) {
+			dpm_noirq_end();
+			break;
+		}
 
 		if (freeze_ops && freeze_ops->wake)
 			freeze_ops->wake();
 
-		dpm_resume_noirq(PMSG_RESUME);
+		dpm_noirq_end();
+
 		if (freeze_ops && freeze_ops->sync)
 			freeze_ops->sync();
 
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1105,6 +1105,11 @@ static int __device_suspend_noirq(struct
 	if (async_error)
 		goto Complete;
 
+	if (pm_wakeup_pending()) {
+		async_error = -EBUSY;
+		goto Complete;
+	}
+
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
