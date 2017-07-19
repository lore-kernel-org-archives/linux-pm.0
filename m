From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] PM / sleep: Mark suspend/hibernation start and finish
Date: Wed, 19 Jul 2017 02:39:58 +0200
Message-ID: <1528829.lXeqX43PVF@aspire.rjw.lan>
References: <2539550.y54cRb749c@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2539550.y54cRb749c@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Regardless of whether or not debug messages from the core system
suspend/hibernation code are enabled, it is useful to know when
system-wide transitions start and finish (or fail), so print "info"
messages at these points.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/hibernate.c |    8 ++++++++
 kernel/power/suspend.c   |    4 ++++
 2 files changed, 12 insertions(+)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -692,6 +692,7 @@ int hibernate(void)
 		goto Unlock;
 	}
 
+	pr_info("Starting hibernation\n");
 	pm_prepare_console();
 	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
 	if (error) {
@@ -762,6 +763,11 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
+	if (error)
+		pr_info("Hibernation failed (%d)\n", error);
+	else
+		pr_info("System resume complete\n");
+
 	return error;
 }
 
@@ -868,6 +874,7 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
+	pr_info("Starting resume from hibernation\n");
 	pm_prepare_console();
 	error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
 	if (error) {
@@ -884,6 +891,7 @@ static int software_resume(void)
  Finish:
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
+	pr_info("Resume from hibernation failed (%d)\n", error);
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -579,12 +579,16 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	pr_info("PM: Starting system suspend (%s)\n", pm_states[state]);
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
 		dpm_save_failed_errno(error);
+		pr_info("PM: System suspend (%s) failed (%d)\n",
+			pm_states[state], error);
 	} else {
 		suspend_stats.success++;
+		pr_info("PM: System resume complete\n");
 	}
 	return error;
 }
