From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 6/6] cpufreq: governor: Create and traverse list of policy_dbs to fix lockdep
Date: Tue,  9 Feb 2016 09:01:36 +0530
Message-ID: <4ad189a1cd04b05fbfd659ec81b4793a1c7b0189.1454988295.git.viresh.kumar@linaro.org>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454988295.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988295.git.viresh.kumar@linaro.org>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

An instance of 'struct dbs_data' can support multiple 'struct
policy_dbs_info' instances. To traverse all policy_dbs supported by a
dbs_data, create a list of policy_dbs within dbs_data.

We can traverse this list now, instead of traversing the loop for all
online CPUs in update_sampling_rate(), to solve the circular dependency
lockdep reported by Juri (and verified by Shilpa) earlier:

 ======================================================
 [ INFO: possible circular locking dependency detected ]
 4.4.0+ #445 Not tainted
 -------------------------------------------------------
 trace.sh/1723 is trying to acquire lock:
  (s_active#48){++++.+}, at: [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94

 but task is already holding lock:
  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

-> #2 (od_dbs_cdata.mutex){+.+.+.}:
        [<c075b040>] mutex_lock_nested+0x7c/0x434
        [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
        [<c0017c10>] return_to_handler+0x0/0x18

-> #1 (&policy->rwsem){+++++.}:
        [<c075ca8c>] down_read+0x58/0x94
        [<c057c244>] show+0x30/0x60
        [<c01f934c>] sysfs_kf_seq_show+0x90/0xfc
        [<c01f7ad8>] kernfs_seq_show+0x34/0x38
        [<c01a22ec>] seq_read+0x1e4/0x4e4
        [<c01f8694>] kernfs_fop_read+0x120/0x1a0
        [<c01794b4>] __vfs_read+0x3c/0xe0
        [<c017a378>] vfs_read+0x98/0x104
        [<c017a434>] SyS_read+0x50/0x90
        [<c000fd40>] ret_fast_syscall+0x0/0x1c

-> #0 (s_active#48){++++.+}:
        [<c008238c>] lock_acquire+0xd4/0x20c
        [<c01f6ae4>] __kernfs_remove+0x288/0x328
        [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
        [<c01fa024>] remove_files+0x44/0x88
        [<c01fa5a4>] sysfs_remove_group+0x50/0xa4
        [<c058285c>] cpufreq_governor_dbs+0x3f0/0x5d4
        [<c0017c10>] return_to_handler+0x0/0x18

 other info that might help us debug this:

 Chain exists of:
  s_active#48 --> &policy->rwsem --> od_dbs_cdata.mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(od_dbs_cdata.mutex);
                                lock(&policy->rwsem);
                                lock(od_dbs_cdata.mutex);
   lock(s_active#48);

  *** DEADLOCK ***

 5 locks held by trace.sh/1723:
  #0:  (sb_writers#6){.+.+.+}, at: [<c017beb8>] __sb_start_write+0xb4/0xc0
  #1:  (&of->mutex){+.+.+.}, at: [<c01f8418>] kernfs_fop_write+0x6c/0x1c8
  #2:  (s_active#35){.+.+.+}, at: [<c01f8420>] kernfs_fop_write+0x74/0x1c8
  #3:  (cpu_hotplug.lock){++++++}, at: [<c0029e6c>] get_online_cpus+0x48/0xb8
  #4:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4

 stack backtrace:
 CPU: 2 PID: 1723 Comm: trace.sh Not tainted 4.4.0+ #445
 Hardware name: ARM-Versatile Express
 [<c001883c>] (unwind_backtrace) from [<c0013f50>] (show_stack+0x20/0x24)
 [<c0013f50>] (show_stack) from [<c044ad90>] (dump_stack+0x80/0xb4)
 [<c044ad90>] (dump_stack) from [<c0128edc>] (print_circular_bug+0x29c/0x2f0)
 [<c0128edc>] (print_circular_bug) from [<c0081708>] (__lock_acquire+0x163c/0x1d74)
 [<c0081708>] (__lock_acquire) from [<c008238c>] (lock_acquire+0xd4/0x20c)
 [<c008238c>] (lock_acquire) from [<c01f6ae4>] (__kernfs_remove+0x288/0x328)
 [<c01f6ae4>] (__kernfs_remove) from [<c01f78c8>] (kernfs_remove_by_name_ns+0x4c/0x94)
 [<c01f78c8>] (kernfs_remove_by_name_ns) from [<c01fa024>] (remove_files+0x44/0x88)
 [<c01fa024>] (remove_files) from [<c01fa5a4>] (sysfs_remove_group+0x50/0xa4)
 [<c01fa5a4>] (sysfs_remove_group) from [<c058285c>] (cpufreq_governor_dbs+0x3f0/0x5d4)
 [<c058285c>] (cpufreq_governor_dbs) from [<c0017c10>] (return_to_handler+0x0/0x18)

This also updates the comment above update_sampling_rate() to make it
more relevant to the current state of code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reported-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 22 ++++++++--
 drivers/cpufreq/cpufreq_governor.h |  7 ++-
 drivers/cpufreq/cpufreq_ondemand.c | 89 +++++++++++++-------------------------
 3 files changed, 54 insertions(+), 64 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index bba9d3fb8103..8e53f804a5af 100644
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
+	count = dbs_data->usage_count--;
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
