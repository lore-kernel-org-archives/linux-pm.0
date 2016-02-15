From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/9] cpufreq: governor: Avoid atomic operations in hot paths
Date: Mon, 15 Feb 2016 02:13:42 +0100
Message-ID: <8782327.qY15U8QUIT@vostro.rjw.lan>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3329748.lhJgppdTt9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the handling of work items by dbs_update_util_handler() and
dbs_work_handler() so the former (which is executed in scheduler
paths) only uses atomic operations when absolutely necessary.  That
is, when the policy is shared and dbs_update_util_handler() has
already decided that this is the time to queue up a work item.

In particular, this avoids the atomic ops entirely on platforms where
policy objects are never shared.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new version of https://patchwork.kernel.org/patch/8291051/ .

Changes from the previous version:
- Added a new "is_shared" field to struct policy_dbs_info to be set for
  shared policies to avoid evaluating cpumask_weight() every time
  dbs_update_util_handler() decides to take a sample.

---
 drivers/cpufreq/cpufreq_governor.c |   49 +++++++++++++++++++++++++------------
 drivers/cpufreq/cpufreq_governor.h |    3 ++
 2 files changed, 37 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -304,6 +304,7 @@ static void gov_cancel_work(struct cpufr
 	irq_work_sync(&policy_dbs->irq_work);
 	cancel_work_sync(&policy_dbs->work);
 	atomic_set(&policy_dbs->work_count, 0);
+	policy_dbs->work_in_progress = false;
 }
 
 static void dbs_work_handler(struct work_struct *work)
@@ -326,13 +327,15 @@ static void dbs_work_handler(struct work
 	policy_dbs->sample_delay_ns = jiffies_to_nsecs(delay);
 	mutex_unlock(&policy_dbs->timer_mutex);
 
+	/* Allow the utilization update handler to queue up more work. */
+	atomic_set(&policy_dbs->work_count, 0);
 	/*
-	 * If the atomic operation below is reordered with respect to the
-	 * sample delay modification, the utilization update handler may end
-	 * up using a stale sample delay value.
+	 * If the update below is reordered with respect to the sample delay
+	 * modification, the utilization update handler may end up using a stale
+	 * sample delay value.
 	 */
-	smp_mb__before_atomic();
-	atomic_dec(&policy_dbs->work_count);
+	smp_wmb();
+	policy_dbs->work_in_progress = false;
 }
 
 static void dbs_irq_work(struct irq_work *irq_work)
@@ -357,6 +360,7 @@ static void dbs_update_util_handler(stru
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
+	u64 delta_ns;
 
 	/*
 	 * The work may not be allowed to be queued up right now.
@@ -364,17 +368,30 @@ static void dbs_update_util_handler(stru
 	 * - Work has already been queued up or is in progress.
 	 * - It is too early (too little time from the previous sample).
 	 */
-	if (atomic_inc_return(&policy_dbs->work_count) == 1) {
-		u64 delta_ns;
+	if (policy_dbs->work_in_progress)
+		return;
 
-		delta_ns = time - policy_dbs->last_sample_time;
-		if ((s64)delta_ns >= policy_dbs->sample_delay_ns) {
-			policy_dbs->last_sample_time = time;
-			gov_queue_irq_work(policy_dbs);
-			return;
-		}
-	}
-	atomic_dec(&policy_dbs->work_count);
+	/*
+	 * If the reads below are reordered before the check above, the value
+	 * of sample_delay_ns used in the computation may be stale.
+	 */
+	smp_rmb();
+	delta_ns = time - policy_dbs->last_sample_time;
+	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
+		return;
+
+	/*
+	 * If the policy is not shared, the irq_work may be queued up right away
+	 * at this point.  Otherwise, we need to ensure that only one of the
+	 * CPUs sharing the policy will do that.
+	 */
+	if (policy_dbs->is_shared &&
+	    !atomic_add_unless(&policy_dbs->work_count, 1, 1))
+		return;
+
+	policy_dbs->last_sample_time = time;
+	policy_dbs->work_in_progress = true;
+	gov_queue_irq_work(policy_dbs);
 }
 
 static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
@@ -551,6 +568,8 @@ static int cpufreq_governor_start(struct
 	if (!policy->cur)
 		return -EINVAL;
 
+	policy_dbs->is_shared = policy_is_shared(policy);
+
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -130,6 +130,9 @@ struct policy_dbs_info {
 	/* dbs_data may be shared between multiple policy objects */
 	struct dbs_data *dbs_data;
 	struct list_head list;
+	/* Status indicators */
+	bool is_shared;		/* This object is used by multiple CPUs */
+	bool work_in_progress;	/* Work is being queued up or in progress */
 };
 
 static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
