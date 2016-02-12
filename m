From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: governor: Avoid atomic operations in hot paths
Date: Fri, 12 Feb 2016 14:33:21 +0100
Message-ID: <9398397.3lixFTFdFx@vostro.rjw.lan>
References: <5225538.XnBMjjCp2q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5225538.XnBMjjCp2q@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Shilpasri G Bhat <shilpabhatppc@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the handling of work items by dbs_update_util_handler() and
dbs_work_handler() so the former (which is executed in scheduler
paths) only uses atomic operations when absolutely necessary.  That
is, when the policy is shared and the function has already decided
that this is the time to queue up a work item.

In particular, this avoids the atomic ops entirely on platforms where
policy objects are never shared.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   47 +++++++++++++++++++++++++------------
 drivers/cpufreq/cpufreq_governor.h |    1 
 2 files changed, 33 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -199,6 +199,7 @@ static void gov_cancel_work(struct polic
 	irq_work_sync(&policy_dbs->irq_work);
 	cancel_work_sync(&policy_dbs->work);
 	atomic_set(&policy_dbs->work_count, 0);
+	policy_dbs->work_in_progress = false;
 }
 
 static void dbs_work_handler(struct work_struct *work)
@@ -221,13 +222,15 @@ static void dbs_work_handler(struct work
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
@@ -252,6 +255,7 @@ static void dbs_update_util_handler(stru
 {
 	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
+	u64 delta_ns;
 
 	/*
 	 * The work may not be allowed to be queued up right now.
@@ -259,17 +263,30 @@ static void dbs_update_util_handler(stru
 	 * - Work has already been queued up or is in progress.
 	 * - It is too early (too little time from the previous sample).
 	 */
-	if (atomic_inc_return(&policy_dbs->work_count) == 1) {
-		u64 delta_ns;
+	if (policy_dbs->work_in_progress)
+		return;
+
+	/*
+	 * If the reads below are reordered before the check above, the value
+	 * of sample_delay_ns used in the computation may be stale.
+	 */
+	smp_rmb();
+	delta_ns = time - policy_dbs->last_sample_time;
+	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
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
+	 * If the policy is not shared, the irq_work may be queued up right away
+	 * at this point.  Otherwise, we need to ensure that only one of the
+	 * CPUs sharing the policy will do that.
+	 */
+	if (policy_is_shared(policy_dbs->policy)
+	    && !atomic_add_unless(&policy_dbs->work_count, 1, 1))
+		return;
+
+	policy_dbs->last_sample_time = time;
+	policy_dbs->work_in_progress = true;
+	gov_queue_irq_work(policy_dbs);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ struct policy_dbs_info {
 	u64 last_sample_time;
 	s64 sample_delay_ns;
 	atomic_t work_count;
+	bool work_in_progress;
 	struct irq_work irq_work;
 	struct work_struct work;
 	/* dbs_data may be shared between multiple policy objects */
