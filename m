From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Rename skip_work to work_count
Date: Mon, 08 Feb 2016 23:41:10 +0100
Message-ID: <10636342.9MrKUjbuVK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60418 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756338AbcBHWj7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 17:39:59 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The skip_work field in struct policy_dbs_info technically is a
counter, so give it a new name to reflect that.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the bleeding-edge branch on linux-pm.git.

Thanks,
Rafael

---
 drivers/cpufreq/cpufreq_governor.c |   14 +++++++-------
 drivers/cpufreq/cpufreq_governor.h |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -196,16 +196,16 @@ static inline void gov_clear_update_util
 static void gov_cancel_work(struct policy_dbs_info *policy_dbs)
 {
 	/* Tell dbs_update_util_handler() to skip queuing up work items. */
-	atomic_inc(&policy_dbs->skip_work);
+	atomic_inc(&policy_dbs->work_count);
 	/*
 	 * If dbs_update_util_handler() is already running, it may not notice
-	 * the incremented skip_work, so wait for it to complete to prevent its
+	 * the incremented work_count, so wait for it to complete to prevent its
 	 * work item from being queued up after the cancel_work_sync() below.
 	 */
 	gov_clear_update_util(policy_dbs->policy);
 	irq_work_sync(&policy_dbs->irq_work);
 	cancel_work_sync(&policy_dbs->work);
-	atomic_set(&policy_dbs->skip_work, 0);
+	atomic_set(&policy_dbs->work_count, 0);
 }
 
 static void dbs_work_handler(struct work_struct *work)
@@ -234,7 +234,7 @@ static void dbs_work_handler(struct work
 	 * up using a stale sample delay value.
 	 */
 	smp_mb__before_atomic();
-	atomic_dec(&policy_dbs->skip_work);
+	atomic_dec(&policy_dbs->work_count);
 }
 
 static void dbs_irq_work(struct irq_work *irq_work)
@@ -266,7 +266,7 @@ static void dbs_update_util_handler(stru
 	 * - The governor is being stopped.
 	 * - It is too early (too little time from the previous sample).
 	 */
-	if (atomic_inc_return(&policy_dbs->skip_work) == 1) {
+	if (atomic_inc_return(&policy_dbs->work_count) == 1) {
 		u64 delta_ns;
 
 		delta_ns = time - policy_dbs->last_sample_time;
@@ -276,7 +276,7 @@ static void dbs_update_util_handler(stru
 			return;
 		}
 	}
-	atomic_dec(&policy_dbs->skip_work);
+	atomic_dec(&policy_dbs->work_count);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -304,7 +304,7 @@ static struct policy_dbs_info *alloc_pol
 		return NULL;
 
 	mutex_init(&policy_dbs->timer_mutex);
-	atomic_set(&policy_dbs->skip_work, 0);
+	atomic_set(&policy_dbs->work_count, 0);
 	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
 	INIT_WORK(&policy_dbs->work, dbs_work_handler);
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -149,7 +149,7 @@ struct policy_dbs_info {
 
 	u64 last_sample_time;
 	s64 sample_delay_ns;
-	atomic_t skip_work;
+	atomic_t work_count;
 	struct irq_work irq_work;
 	struct work_struct work;
 	/* dbs_data may be shared between multiple policy objects */

