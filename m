From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM / hibernate: Untangle power_down()
Date: Fri, 24 Feb 2017 00:25:28 +0100
Message-ID: <15348521.Zu0shuoshF@aspire.rjw.lan>
References: <1897611.guix8xla9k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54001 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751303AbdBWXdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2017 18:33:11 -0500
In-Reply-To: <1897611.guix8xla9k@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The power_down() routine in the core hibernation code is not exactly
straightforward (to put it lightly), so clean it up to make it avoid
invoking itself recursively, among other things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/hibernate.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -608,6 +608,22 @@ static void power_down(void)
 {
 #ifdef CONFIG_SUSPEND
 	int error;
+
+	if (hibernation_mode == HIBERNATION_SUSPEND) {
+		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
+		if (error) {
+			hibernation_mode = hibernation_ops ?
+						HIBERNATION_PLATFORM :
+						HIBERNATION_SHUTDOWN;
+		} else {
+			/* Restore swap signature. */
+			error = swsusp_unmark();
+			if (error)
+				pr_err("PM: Swap will be unusable! Try swapon -a.\n");
+
+			return;
+		}
+	}
 #endif
 
 	switch (hibernation_mode) {
@@ -620,25 +636,6 @@ static void power_down(void)
 		if (pm_power_off)
 			kernel_power_off();
 		break;
-#ifdef CONFIG_SUSPEND
-	case HIBERNATION_SUSPEND:
-		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
-		if (error) {
-			if (hibernation_ops)
-				hibernation_mode = HIBERNATION_PLATFORM;
-			else
-				hibernation_mode = HIBERNATION_SHUTDOWN;
-			power_down();
-		}
-		/*
-		 * Restore swap signature.
-		 */
-		error = swsusp_unmark();
-		if (error)
-			printk(KERN_ERR "PM: Swap will be unusable! "
-			                "Try swapon -a.\n");
-		return;
-#endif
 	}
 	kernel_halt();
 	/*
