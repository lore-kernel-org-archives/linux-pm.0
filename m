From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: governor: Create and traverse list of policy_dbs to fix lockdep
Date: Wed, 10 Feb 2016 11:00:25 +0530
Message-ID: <6d6bbd9f1b4d4225555490663b1fee6d39549e70.1455082164.git.viresh.kumar@linaro.org>
References: <CAJZ5v0i9JUo3jvj2RvoN+92jfMBWdXn-CkC9AN-rcgFdeum9Zw@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36855 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbcBJFaj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 00:30:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id yy13so6070875pab.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 21:30:38 -0800 (PST)
In-Reply-To: <CAJZ5v0i9JUo3jvj2RvoN+92jfMBWdXn-CkC9AN-rcgFdeum9Zw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

The dbs_data_mutex lock is currently used in two places.  First,
cpufreq_governor_dbs() uses it to guarantee mutual exclusion between
invocations of governor operations from the core.  Second, it is used by
ondemand governor's update_sampling_rate() to ensure the stability of
data structures walked by it.

The second usage is quite problematic, because update_sampling_rate() is
called from a governor sysfs attribute's ->store callback and that leads
to a deadlock scenario involving cpufreq_governor_exit() which runs
under dbs_data_mutex.  Thus it is better to rework the code so
update_sampling_rate() doesn't need to acquire dbs_data_mutex.

To that end, rework update_sampling_rate() to walk a list of policy_dbs
objects supported by the dbs_data one it has been called for (instead of
walking cpu_dbs_info object for all CPUs).  The list manipulation is
protected with dbs_data->mutex which also is held around the execution
of update_sampling_rate(), it is not necessary to hold dbs_data_mutex in
that function any more.

Reported-by: Juri Lelli <juri.lelli@arm.com>
Reported-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
[ rjw: Changelog ]

---
V5:
- Updated changelog (Thanks again Rafael)
- Fixed bug regarding a-- and --a :)
---
 drivers/cpufreq/cpufreq_governor.c | 22 ++++++++--
 drivers/cpufreq/cpufreq_governor.h |  7 ++-
 drivers/cpufreq/cpufreq_ondemand.c | 89 +++++++++++++-------------------------
 3 files changed, 54 insertions(+), 64 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index bba9d3fb8103..3a9dab752148 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -384,9 +384,14 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 			ret = -EINVAL;
 			goto free_policy_dbs_info;
 		}
-		dbs_data->usage_count++;
 		policy_dbs->dbs_data = dbs_data;
 		policy->governor_data = policy_dbs;
+
+		mutex_lock(&dbs_data->mutex);
+		dbs_data->usage_count++;
+		list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
+		mutex_unlock(&dbs_data->mutex);
+
 		return 0;
 	}
 
@@ -396,7 +401,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 		goto free_policy_dbs_info;
 	}
 
-	dbs_data->usage_count = 1;
+	INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
 	mutex_init(&dbs_data->mutex);
 
 	ret = gov->init(dbs_data, !policy->governor->initialized);
@@ -417,9 +422,12 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
 
-	policy_dbs->dbs_data = dbs_data;
 	policy->governor_data = policy_dbs;
 
+	policy_dbs->dbs_data = dbs_data;
+	dbs_data->usage_count = 1;
+	list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
+
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
 	ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
@@ -450,12 +458,18 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
+	int count;
 
 	/* State should be equivalent to INIT */
 	if (policy_dbs->policy)
 		return -EBUSY;
 
-	if (!--dbs_data->usage_count) {
+	mutex_lock(&dbs_data->mutex);
+	list_del(&policy_dbs->list);
+	count = --dbs_data->usage_count;
+	mutex_unlock(&dbs_data->mutex);
+
+	if (!count) {
 		kobject_put(&dbs_data->kobj);
 
 		policy->governor_data = NULL;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index d46ebcb4f16d..4e77efb7db67 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -73,7 +73,11 @@ struct dbs_data {
 	unsigned int up_threshold;
 
 	struct kobject kobj;
-	/* Protect concurrent updates to governor tunables from sysfs */
+	struct list_head policy_dbs_list;
+	/*
+	 * Protect concurrent updates to governor tunables from sysfs,
+	 * policy_dbs_list and usage_count.
+	 */
 	struct mutex mutex;
 };
 
@@ -125,6 +129,7 @@ struct policy_dbs_info {
 	struct work_struct work;
 	/* dbs_data may be shared between multiple policy objects */
 	struct dbs_data *dbs_data;
+	struct list_head list;
 };
 
 static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index e36792f60348..38301c6b31c7 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -226,84 +226,55 @@ static struct dbs_governor od_dbs_gov;
  * @new_rate: new sampling rate
  *
  * If new rate is smaller than the old, simply updating
- * dbs_tuners_int.sampling_rate might not be appropriate. For example, if the
+ * dbs.sampling_rate might not be appropriate. For example, if the
  * original sampling_rate was 1 second and the requested new sampling rate is 10
  * ms because the user needs immediate reaction from ondemand governor, but not
  * sure if higher frequency will be required or not, then, the governor may
  * change the sampling rate too late; up to 1 second later. Thus, if we are
  * reducing the sampling rate, we need to make the new value effective
  * immediately.
+ *
+ * On the other hand, if new rate is larger than the old, then we may evaluate
+ * the load too soon, and it might we worth updating sample_delay_ns then as
+ * well.
+ *
+ * This must be called with dbs_data->mutex held, otherwise traversing
+ * policy_dbs_list isn't safe.
  */
 static void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
 {
-	struct cpumask cpumask;
-	int cpu;
+	struct policy_dbs_info *policy_dbs;
 
 	dbs_data->sampling_rate = new_rate = max(new_rate,
 			dbs_data->min_sampling_rate);
 
 	/*
-	 * Lock governor so that governor start/stop can't execute in parallel.
+	 * We are operating under dbs_data->mutex and so the list and its
+	 * entries can't be freed concurrently.
 	 */
-	mutex_lock(&dbs_data_mutex);
-
-	cpumask_copy(&cpumask, cpu_online_mask);
-
-	for_each_cpu(cpu, &cpumask) {
-		struct cpufreq_policy *policy;
-		struct od_cpu_dbs_info_s *dbs_info;
-		struct cpu_dbs_info *cdbs;
-		struct policy_dbs_info *policy_dbs;
-
-		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-		cdbs = &dbs_info->cdbs;
-		policy_dbs = cdbs->policy_dbs;
-
+	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+		mutex_lock(&policy_dbs->timer_mutex);
 		/*
-		 * A valid policy_dbs and policy_dbs->policy means governor
-		 * hasn't stopped or exited yet.
+		 * On 32-bit architectures this may race with the
+		 * sample_delay_ns read in dbs_update_util_handler(), but that
+		 * really doesn't matter.  If the read returns a value that's
+		 * too big, the sample will be skipped, but the next invocation
+		 * of dbs_update_util_handler() (when the update has been
+		 * completed) will take a sample.  If the returned value is too
+		 * small, the sample will be taken immediately, but that isn't a
+		 * problem, as we want the new rate to take effect immediately
+		 * anyway.
+		 *
+		 * If this runs in parallel with dbs_work_handler(), we may end
+		 * up overwriting the sample_delay_ns value that it has just
+		 * written, but the difference should not be too big and it will
+		 * be corrected next time a sample is taken, so it shouldn't be
+		 * significant.
 		 */
-		if (!policy_dbs || !policy_dbs->policy)
-			continue;
-
-		policy = policy_dbs->policy;
-
-		/* clear all CPUs of this policy */
-		cpumask_andnot(&cpumask, &cpumask, policy->cpus);
-
-		/*
-		 * Update sampling rate for CPUs whose policy is governed by
-		 * dbs_data. In case of governor_per_policy, only a single
-		 * policy will be governed by dbs_data, otherwise there can be
-		 * multiple policies that are governed by the same dbs_data.
-		 */
-		if (dbs_data == policy_dbs->dbs_data) {
-			mutex_lock(&policy_dbs->timer_mutex);
-			/*
-			 * On 32-bit architectures this may race with the
-			 * sample_delay_ns read in dbs_update_util_handler(),
-			 * but that really doesn't matter.  If the read returns
-			 * a value that's too big, the sample will be skipped,
-			 * but the next invocation of dbs_update_util_handler()
-			 * (when the update has been completed) will take a
-			 * sample.  If the returned value is too small, the
-			 * sample will be taken immediately, but that isn't a
-			 * problem, as we want the new rate to take effect
-			 * immediately anyway.
-			 *
-			 * If this runs in parallel with dbs_work_handler(), we
-			 * may end up overwriting the sample_delay_ns value that
-			 * it has just written, but the difference should not be
-			 * too big and it will be corrected next time a sample
-			 * is taken, so it shouldn't be significant.
-			 */
-			gov_update_sample_delay(policy_dbs, new_rate);
-			mutex_unlock(&policy_dbs->timer_mutex);
-		}
+		gov_update_sample_delay(policy_dbs, new_rate);
+		mutex_unlock(&policy_dbs->timer_mutex);
 	}
-
-	mutex_unlock(&dbs_data_mutex);
 }
 
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-- 
2.7.1.370.gb2aa7f8

