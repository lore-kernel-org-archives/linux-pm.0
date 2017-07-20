From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 2/3] PM / sleep: Mark suspend/hibernation start and finish
Date: Thu, 20 Jul 2017 03:38:07 +0200
Message-ID: <21457958.U8q3irAeUz@aspire.rjw.lan>
References: <2539550.y54cRb749c@aspire.rjw.lan> <1528829.lXeqX43PVF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50456 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932089AbdGTBqA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 21:46:00 -0400
In-Reply-To: <1528829.lXeqX43PVF@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Salyzyn <salyzyn@android.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Regardless of whether or not debug messages from the core system
suspend/hibernation code are enabled, it is useful to know when
system-wide transitions start and finish (or fail), so print "info"
messages at these points.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Smiplified the messages as suggested by Mark.

---
 kernel/power/hibernate.c |    5 +++++
 kernel/power/suspend.c   |    2 ++
 2 files changed, 7 insertions(+)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -692,6 +692,7 @@ int hibernate(void)
 		goto Unlock;
 	}
 
+	pr_info("hibernation entry\n");
 	pm_prepare_console();
 	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
 	if (error) {
@@ -762,6 +763,8 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
+	pr_info("hibernation exit\n");
+
 	return error;
 }
 
@@ -868,6 +871,7 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
+	pr_info("resume from hibernation\n");
 	pm_prepare_console();
 	error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
 	if (error) {
@@ -884,6 +888,7 @@ static int software_resume(void)
  Finish:
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
+	pr_info("resume from hibernation failed (%d)\n", error);
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -579,6 +579,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	pr_info("PM: suspend entry (%s)\n", pm_states[state]);
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -586,6 +587,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	pr_info("PM: suspend exit\n");
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
