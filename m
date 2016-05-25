From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: stats: Make the stats code non-modular
Date: Thu, 26 May 2016 00:23:18 +0200
Message-ID: <1482863.aVJEuqdboc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42238 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751250AbcEYWTh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 18:19:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The modularity of cpufreq_stats is quite problematic.

First off, the usage of policy notifiers for the initialization
and cleanup in the cpufreq_stats module is inherently racy with
respect to CPU offline/online and the initialization and cleanup
of the cpufreq driver.

Second, fast frequency switching (used by the schedutil governor)
cannot be enabled if any transition notifiers are registered, so
if the cpufreq_stats module (that registers a transition notifier
for updating transition statistics) is loaded, the schedutil governor
cannot use fast frequency switching.

On the other hand, allowing cpufreq_stats to be built as a module
doesn't really add much value.  Arguably, there's not much reason
for that code to be modular at all.

For the above reasons, make the cpufreq stats code non-modular,
modify the core to invoke functions provided by that code directly
and drop the notifiers from it.

While at it, clean up Kconfig help for the CPU_FREQ_STAT and
CPU_FREQ_STAT_DETAILS options.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/Kconfig         |   13 +--
 drivers/cpufreq/cpufreq.c       |    4 +
 drivers/cpufreq/cpufreq_stats.c |  146 +++-------------------------------------
 include/linux/cpufreq.h         |   12 +++
 4 files changed, 34 insertions(+), 141 deletions(-)

Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -31,23 +31,18 @@ config CPU_FREQ_BOOST_SW
 	depends on THERMAL
 
 config CPU_FREQ_STAT
-	tristate "CPU frequency translation statistics"
+	bool "CPU frequency transition statistics"
 	default y
 	help
-	  This driver exports CPU frequency statistics information through sysfs
-	  file system.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cpufreq_stats.
+	  Export CPU frequency statistics information through sysfs.
 
 	  If in doubt, say N.
 
 config CPU_FREQ_STAT_DETAILS
-	bool "CPU frequency translation statistics details"
+	bool "CPU frequency transition statistics details"
 	depends on CPU_FREQ_STAT
 	help
-	  This will show detail CPU frequency translation table in sysfs file
-	  system.
+	  Show detailed CPU frequency transition table in sysfs.
 
 	  If in doubt, say N.
 
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -347,6 +347,7 @@ static void __cpufreq_notify_transition(
 		pr_debug("FREQ: %lu - CPU: %lu\n",
 			 (unsigned long)freqs->new, (unsigned long)freqs->cpu);
 		trace_cpu_frequency(freqs->new, freqs->cpu);
+		cpufreq_stats_record_transition(policy, freqs->new);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
@@ -1108,6 +1109,7 @@ static void cpufreq_policy_put_kobj(stru
 					     CPUFREQ_REMOVE_POLICY, policy);
 
 	down_write(&policy->rwsem);
+	cpufreq_stats_free_table(policy);
 	cpufreq_remove_dev_symlink(policy);
 	kobj = &policy->kobj;
 	cmp = &policy->kobj_unregister;
@@ -1265,6 +1267,8 @@ static int cpufreq_online(unsigned int c
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
 			goto out_exit_policy;
+
+		cpufreq_stats_create_table(policy);
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 
Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-pm/drivers/cpufreq/cpufreq_stats.c
@@ -130,7 +130,7 @@ static int freq_table_get_index(struct c
 	return -1;
 }
 
-static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
+void cpufreq_stats_free_table(struct cpufreq_policy *policy)
 {
 	struct cpufreq_stats *stats = policy->stats;
 
@@ -146,20 +146,7 @@ static void __cpufreq_stats_free_table(s
 	policy->stats = NULL;
 }
 
-static void cpufreq_stats_free_table(unsigned int cpu)
-{
-	struct cpufreq_policy *policy;
-
-	policy = cpufreq_cpu_get(cpu);
-	if (!policy)
-		return;
-
-	__cpufreq_stats_free_table(policy);
-
-	cpufreq_cpu_put(policy);
-}
-
-static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
+void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
 	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stats;
@@ -170,15 +157,15 @@ static int __cpufreq_stats_create_table(
 	/* We need cpufreq table for creating stats table */
 	table = cpufreq_frequency_get_table(cpu);
 	if (unlikely(!table))
-		return 0;
+		return;
 
 	/* stats already initialized */
 	if (policy->stats)
-		return -EEXIST;
+		return;
 
 	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
 	if (!stats)
-		return -ENOMEM;
+		return;
 
 	/* Find total allocation size */
 	cpufreq_for_each_valid_entry(pos, table)
@@ -215,80 +202,32 @@ static int __cpufreq_stats_create_table(
 	policy->stats = stats;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
 	if (!ret)
-		return 0;
+		return;
 
 	/* We failed, release resources */
 	policy->stats = NULL;
 	kfree(stats->time_in_state);
 free_stat:
 	kfree(stats);
-
-	return ret;
-}
-
-static void cpufreq_stats_create_table(unsigned int cpu)
-{
-	struct cpufreq_policy *policy;
-
-	/*
-	 * "likely(!policy)" because normally cpufreq_stats will be registered
-	 * before cpufreq driver
-	 */
-	policy = cpufreq_cpu_get(cpu);
-	if (likely(!policy))
-		return;
-
-	__cpufreq_stats_create_table(policy);
-
-	cpufreq_cpu_put(policy);
-}
-
-static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
-		unsigned long val, void *data)
-{
-	int ret = 0;
-	struct cpufreq_policy *policy = data;
-
-	if (val == CPUFREQ_CREATE_POLICY)
-		ret = __cpufreq_stats_create_table(policy);
-	else if (val == CPUFREQ_REMOVE_POLICY)
-		__cpufreq_stats_free_table(policy);
-
-	return ret;
 }
 
-static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
-		unsigned long val, void *data)
+void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
+				     unsigned int new_freq)
 {
-	struct cpufreq_freqs *freq = data;
-	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
-	struct cpufreq_stats *stats;
+	struct cpufreq_stats *stats = policy->stats;
 	int old_index, new_index;
 
-	if (!policy) {
-		pr_err("%s: No policy found\n", __func__);
-		return 0;
-	}
-
-	if (val != CPUFREQ_POSTCHANGE)
-		goto put_policy;
-
-	if (!policy->stats) {
+	if (!stats) {
 		pr_debug("%s: No stats found\n", __func__);
-		goto put_policy;
+		return;
 	}
 
-	stats = policy->stats;
-
 	old_index = stats->last_index;
-	new_index = freq_table_get_index(stats, freq->new);
+	new_index = freq_table_get_index(stats, new_freq);
 
 	/* We can't do stats->time_in_state[-1]= .. */
-	if (old_index == -1 || new_index == -1)
-		goto put_policy;
-
-	if (old_index == new_index)
-		goto put_policy;
+	if (old_index == -1 || new_index == -1 || old_index == new_index)
+		return;
 
 	cpufreq_stats_update(stats);
 
@@ -297,61 +236,4 @@ static int cpufreq_stat_notifier_trans(s
 	stats->trans_table[old_index * stats->max_state + new_index]++;
 #endif
 	stats->total_trans++;
-
-put_policy:
-	cpufreq_cpu_put(policy);
-	return 0;
 }
-
-static struct notifier_block notifier_policy_block = {
-	.notifier_call = cpufreq_stat_notifier_policy
-};
-
-static struct notifier_block notifier_trans_block = {
-	.notifier_call = cpufreq_stat_notifier_trans
-};
-
-static int __init cpufreq_stats_init(void)
-{
-	int ret;
-	unsigned int cpu;
-
-	spin_lock_init(&cpufreq_stats_lock);
-	ret = cpufreq_register_notifier(&notifier_policy_block,
-				CPUFREQ_POLICY_NOTIFIER);
-	if (ret)
-		return ret;
-
-	for_each_online_cpu(cpu)
-		cpufreq_stats_create_table(cpu);
-
-	ret = cpufreq_register_notifier(&notifier_trans_block,
-				CPUFREQ_TRANSITION_NOTIFIER);
-	if (ret) {
-		cpufreq_unregister_notifier(&notifier_policy_block,
-				CPUFREQ_POLICY_NOTIFIER);
-		for_each_online_cpu(cpu)
-			cpufreq_stats_free_table(cpu);
-		return ret;
-	}
-
-	return 0;
-}
-static void __exit cpufreq_stats_exit(void)
-{
-	unsigned int cpu;
-
-	cpufreq_unregister_notifier(&notifier_policy_block,
-			CPUFREQ_POLICY_NOTIFIER);
-	cpufreq_unregister_notifier(&notifier_trans_block,
-			CPUFREQ_TRANSITION_NOTIFIER);
-	for_each_online_cpu(cpu)
-		cpufreq_stats_free_table(cpu);
-}
-
-MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
-MODULE_DESCRIPTION("Export cpufreq stats via sysfs");
-MODULE_LICENSE("GPL");
-
-module_init(cpufreq_stats_init);
-module_exit(cpufreq_stats_exit);
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -185,6 +185,18 @@ static inline unsigned int cpufreq_quick
 static inline void disable_cpufreq(void) { }
 #endif
 
+#ifdef CONFIG_CPU_FREQ_STAT
+void cpufreq_stats_create_table(struct cpufreq_policy *policy);
+void cpufreq_stats_free_table(struct cpufreq_policy *policy);
+void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
+				     unsigned int new_freq);
+#else
+static inline void cpufreq_stats_create_table(struct cpufreq_policy *policy) { }
+static inline void cpufreq_stats_free_table(struct cpufreq_policy *policy) { }
+static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
+						   unsigned int new_freq) { }
+#endif /* CONFIG_CPU_FREQ_STAT */
+
 /*********************************************************************
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/

