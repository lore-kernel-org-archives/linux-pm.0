From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] PM / core: Add error argument to dpm_show_time()
Date: Fri, 21 Jul 2017 02:10:22 +0200
Message-ID: <1855334.UbMQcZf2zn@aspire.rjw.lan>
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

Make the core device suspend/resume code also call dpm_show_time()
on failures and add an error argument to this function so that the
message printed by it can reflect the success or failure condition.

This makes the debug messages in question look less confusing in
the failing cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -418,7 +418,7 @@ static void pm_dev_err(struct device *de
 		dev_name(dev), pm_verb(state.event), info, error);
 }
 
-static void dpm_show_time(ktime_t starttime, pm_message_t state,
+static void dpm_show_time(ktime_t starttime, pm_message_t state, int error,
 			  const char *info)
 {
 	ktime_t calltime;
@@ -432,8 +432,9 @@ static void dpm_show_time(ktime_t startt
 	if (usecs == 0)
 		usecs = 1;
 
-	pm_pr_dbg("%s%s%s of devices complete after %ld.%03ld msecs\n",
+	pm_pr_dbg("%s%s%s of devices %s after %ld.%03ld msecs\n",
 		  info ?: "", info ? " " : "", pm_verb(state.event),
+		  error ? "aborted" : "complete",
 		  usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
 }
 
@@ -643,7 +644,7 @@ void dpm_noirq_resume_devices(pm_message
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
-	dpm_show_time(starttime, state, "noirq");
+	dpm_show_time(starttime, state, 0, "noirq");
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
 
@@ -782,7 +783,7 @@ void dpm_resume_early(pm_message_t state
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
-	dpm_show_time(starttime, state, "early");
+	dpm_show_time(starttime, state, 0, "early");
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
 }
 
@@ -954,7 +955,7 @@ void dpm_resume(pm_message_t state)
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
-	dpm_show_time(starttime, state, NULL);
+	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
@@ -1211,9 +1212,8 @@ int dpm_noirq_suspend_devices(pm_message
 	if (error) {
 		suspend_stats.failed_suspend_noirq++;
 		dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
-	} else {
-		dpm_show_time(starttime, state, "noirq");
 	}
+	dpm_show_time(starttime, state, error, "noirq");
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, false);
 	return error;
 }
@@ -1371,9 +1371,8 @@ int dpm_suspend_late(pm_message_t state)
 		suspend_stats.failed_suspend_late++;
 		dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
 		dpm_resume_early(resume_event(state));
-	} else {
-		dpm_show_time(starttime, state, "late");
 	}
+	dpm_show_time(starttime, state, error, "late");
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, false);
 	return error;
 }
@@ -1639,8 +1638,8 @@ int dpm_suspend(pm_message_t state)
 	if (error) {
 		suspend_stats.failed_suspend++;
 		dpm_save_failed_step(SUSPEND_SUSPEND);
-	} else
-		dpm_show_time(starttime, state, NULL);
+	}
+	dpm_show_time(starttime, state, error, NULL);
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, false);
 	return error;
 }
