From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/6] cpufreq: Remove cpufreq_frequency_get_table()
Date: Thu,  2 Jun 2016 19:34:56 +0530
Message-ID: <13d43ddfe208a9b387fe0fd247de069ba0332308.1464876229.git.viresh.kumar@linaro.org>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464876229.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876229.git.viresh.kumar@linaro.org>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Most of the callers of cpufreq_frequency_get_table() already have the
pointer to a valid 'policy' structure and they don't really need to go
through the per-cpu variable first and then a check to validate the
frequency, in order to find the freq-table for the policy.

Directly use the policy->freq_table field instead for them.

Only one user of that API is left after above changes, cpu_cooling.c and
it accesses the freq_table in a racy way as the policy can get freed in
between.

Fix it by using cpufreq_cpu_get() properly.

Since there are no more users of cpufreq_frequency_get_table() left, get
rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c             | 38 +++++++++++++----------------------
 drivers/cpufreq/cpufreq_ondemand.c    |  2 +-
 drivers/cpufreq/cpufreq_stats.c       |  3 +--
 drivers/cpufreq/freq_table.c          |  9 +++------
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c |  3 +--
 drivers/thermal/cpu_cooling.c         | 22 +++++++++++++++-----
 include/linux/cpufreq.h               |  2 --
 7 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fbc97b1fa371..1833eda1f9d4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -126,15 +126,6 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
-struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
-
-	return policy && !policy_is_inactive(policy) ?
-		policy->freq_table : NULL;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
-
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
 	u64 idle_time;
@@ -1950,7 +1941,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	freq_table = cpufreq_frequency_get_table(policy->cpu);
+	freq_table = policy->freq_table;
 	if (unlikely(!freq_table)) {
 		pr_err("%s: Unable to find freq_table\n", __func__);
 		return -EINVAL;
@@ -2345,26 +2336,25 @@ static struct notifier_block __refdata cpufreq_cpu_notifier = {
  *********************************************************************/
 static int cpufreq_boost_set_sw(int state)
 {
-	struct cpufreq_frequency_table *freq_table;
 	struct cpufreq_policy *policy;
 	int ret = -EINVAL;
 
 	for_each_active_policy(policy) {
-		freq_table = cpufreq_frequency_get_table(policy->cpu);
-		if (freq_table) {
-			ret = cpufreq_frequency_table_cpuinfo(policy,
-							freq_table);
-			if (ret) {
-				pr_err("%s: Policy frequency update failed\n",
-				       __func__);
-				break;
-			}
+		if (!policy->freq_table)
+			continue;
 
-			down_write(&policy->rwsem);
-			policy->user_policy.max = policy->max;
-			cpufreq_governor_limits(policy);
-			up_write(&policy->rwsem);
+		ret = cpufreq_frequency_table_cpuinfo(policy,
+						      policy->freq_table);
+		if (ret) {
+			pr_err("%s: Policy frequency update failed\n",
+			       __func__);
+			break;
 		}
+
+		down_write(&policy->rwsem);
+		policy->user_policy.max = policy->max;
+		cpufreq_governor_limits(policy);
+		up_write(&policy->rwsem);
 	}
 
 	return ret;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index c84fc2240d49..4d2fe2710c5d 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -113,7 +113,7 @@ static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
 {
 	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
-	dbs_info->freq_table = cpufreq_frequency_get_table(policy->cpu);
+	dbs_info->freq_table = policy->freq_table;
 	dbs_info->freq_lo = 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index c6e7f81a0397..06d3abdffd3a 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -157,11 +157,10 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
-	unsigned int cpu = policy->cpu;
 	struct cpufreq_frequency_table *pos, *table;
 
 	/* We need cpufreq table for creating stats table */
-	table = cpufreq_frequency_get_table(cpu);
+	table = policy->freq_table;
 	if (unlikely(!table))
 		return;
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 4e5c5dbfed7a..f52b5473b1f4 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -106,12 +106,10 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
  */
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 {
-	struct cpufreq_frequency_table *table =
-		cpufreq_frequency_get_table(policy->cpu);
-	if (!table)
+	if (!policy->freq_table)
 		return -ENODEV;
 
-	return cpufreq_frequency_table_verify(policy, table);
+	return cpufreq_frequency_table_verify(policy, policy->freq_table);
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
@@ -210,9 +208,8 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq)
 {
-	struct cpufreq_frequency_table *pos, *table;
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 
-	table = cpufreq_frequency_get_table(policy->cpu);
 	if (unlikely(!table)) {
 		pr_debug("%s: Unable to find frequency table\n", __func__);
 		return -ENOENT;
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 7c4cd5c634f2..dc112481a408 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -94,7 +94,7 @@ static int pmi_notifier(struct notifier_block *nb,
 				       unsigned long event, void *data)
 {
 	struct cpufreq_policy *policy = data;
-	struct cpufreq_frequency_table *cbe_freqs;
+	struct cpufreq_frequency_table *cbe_freqs = policy->freq_table;
 	u8 node;
 
 	/* Should this really be called for CPUFREQ_ADJUST and CPUFREQ_NOTIFY
@@ -103,7 +103,6 @@ static int pmi_notifier(struct notifier_block *nb,
 	if (event == CPUFREQ_START)
 		return 0;
 
-	cbe_freqs = cpufreq_frequency_get_table(policy->cpu);
 	node = cbe_cpu_to_node(policy->cpu);
 
 	pr_debug("got notified, event=%lu, node=%u\n", event, node);
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6ceac4f2d4b2..63f760869651 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -787,6 +787,7 @@ __cpufreq_cooling_register(struct device_node *np,
 			const struct cpumask *clip_cpus, u32 capacitance,
 			get_static_t plat_static_func)
 {
+	struct cpufreq_policy *policy;
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev;
 	char dev_name[THERMAL_NAME_LENGTH];
@@ -794,15 +795,24 @@ __cpufreq_cooling_register(struct device_node *np,
 	unsigned int freq, i, num_cpus;
 	int ret;
 
-	table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
+	policy = cpufreq_cpu_get(cpumask_first(clip_cpus));
+	if (!policy) {
+		pr_debug("%s: CPUFreq policy not found\n", __func__);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	table = policy->freq_table;
 	if (!table) {
 		pr_debug("%s: CPUFreq table not found\n", __func__);
-		return ERR_PTR(-EPROBE_DEFER);
+		cool_dev = ERR_PTR(-ENODEV);
+		goto put_policy;
 	}
 
 	cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);
-	if (!cpufreq_dev)
-		return ERR_PTR(-ENOMEM);
+	if (!cpufreq_dev) {
+		cool_dev = ERR_PTR(-ENOMEM);
+		goto put_policy;
+	}
 
 	num_cpus = cpumask_weight(clip_cpus);
 	cpufreq_dev->time_in_idle = kcalloc(num_cpus,
@@ -892,7 +902,7 @@ __cpufreq_cooling_register(struct device_node *np,
 					  CPUFREQ_POLICY_NOTIFIER);
 	mutex_unlock(&cooling_cpufreq_lock);
 
-	return cool_dev;
+	goto put_policy;
 
 remove_idr:
 	release_idr(&cpufreq_idr, cpufreq_dev->id);
@@ -906,6 +916,8 @@ __cpufreq_cooling_register(struct device_node *np,
 	kfree(cpufreq_dev->time_in_idle);
 free_cdev:
 	kfree(cpufreq_dev);
+put_policy:
+	cpufreq_cpu_put(policy);
 
 	return cool_dev;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7ed93c310c08..1342cbc0f25e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -632,8 +632,6 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 	return false;
 }
 #endif
-/* the following funtion is for cpufreq core use only */
-struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
-- 
2.7.1.410.g6faf27b
