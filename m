From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 2/4] cpufreq: arm_big_little: remove big.LITTLE switcher
 support
Date: Mon, 27 Jun 2016 13:26:08 +0200
Message-ID: <1467026770-5699-3-git-send-email-b.zolnierkie@samsung.com>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove no longer needed big.LITTLE switcher support from
arm_big_little CPUfreq driver.

The arm_big_little CPUfreq driver itself may also be removed
at later time (after converting platforms using it to use
cpufreq-dt CPUfreq driver instead).

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/arm_big_little.c | 379 +++------------------------------------
 1 file changed, 24 insertions(+), 355 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 4180422..02bf55b 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -36,116 +36,37 @@
 #include "arm_big_little.h"
 
 /* Currently we support only two clusters */
-#define A15_CLUSTER	0
-#define A7_CLUSTER	1
 #define MAX_CLUSTERS	2
 
-#ifdef CONFIG_BL_SWITCHER
-#include <asm/bL_switcher.h>
-static bool bL_switching_enabled;
-#define is_bL_switching_enabled()	bL_switching_enabled
-#define set_switching_enabled(x)	(bL_switching_enabled = (x))
-#else
-#define is_bL_switching_enabled()	false
-#define set_switching_enabled(x)	do { } while (0)
-#define bL_switch_request(...)		do { } while (0)
-#define bL_switcher_put_enabled()	do { } while (0)
-#define bL_switcher_get_enabled()	do { } while (0)
-#endif
-
-#define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
-#define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
-
 static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
 static struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
-static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
-static atomic_t cluster_usage[MAX_CLUSTERS + 1];
-
-static unsigned int clk_big_min;	/* (Big) clock frequencies */
-static unsigned int clk_little_max;	/* Maximum clock frequency (Little) */
-
-static DEFINE_PER_CPU(unsigned int, physical_cluster);
-static DEFINE_PER_CPU(unsigned int, cpu_last_req_freq);
-
-static struct mutex cluster_lock[MAX_CLUSTERS];
+static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS];
+static atomic_t cluster_usage[MAX_CLUSTERS];
 
 static inline int raw_cpu_to_cluster(int cpu)
 {
 	return topology_physical_package_id(cpu);
 }
 
-static inline int cpu_to_cluster(int cpu)
-{
-	return is_bL_switching_enabled() ?
-		MAX_CLUSTERS : raw_cpu_to_cluster(cpu);
-}
-
-static unsigned int find_cluster_maxfreq(int cluster)
-{
-	int j;
-	u32 max_freq = 0, cpu_freq;
-
-	for_each_online_cpu(j) {
-		cpu_freq = per_cpu(cpu_last_req_freq, j);
-
-		if ((cluster == per_cpu(physical_cluster, j)) &&
-				(max_freq < cpu_freq))
-			max_freq = cpu_freq;
-	}
-
-	pr_debug("%s: cluster: %d, max freq: %d\n", __func__, cluster,
-			max_freq);
-
-	return max_freq;
-}
-
 static unsigned int clk_get_cpu_rate(unsigned int cpu)
 {
-	u32 cur_cluster = per_cpu(physical_cluster, cpu);
+	u32 cur_cluster = raw_cpu_to_cluster(cpu);
 	u32 rate = clk_get_rate(clk[cur_cluster]) / 1000;
 
-	/* For switcher we use virtual A7 clock rates */
-	if (is_bL_switching_enabled())
-		rate = VIRT_FREQ(cur_cluster, rate);
-
 	pr_debug("%s: cpu: %d, cluster: %d, freq: %u\n", __func__, cpu,
 			cur_cluster, rate);
 
 	return rate;
 }
 
-static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
-{
-	if (is_bL_switching_enabled()) {
-		pr_debug("%s: freq: %d\n", __func__, per_cpu(cpu_last_req_freq,
-					cpu));
-
-		return per_cpu(cpu_last_req_freq, cpu);
-	} else {
-		return clk_get_cpu_rate(cpu);
-	}
-}
-
 static unsigned int
 bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 {
-	u32 new_rate, prev_rate;
+	u32 new_rate;
 	int ret;
-	bool bLs = is_bL_switching_enabled();
-
-	mutex_lock(&cluster_lock[new_cluster]);
 
-	if (bLs) {
-		prev_rate = per_cpu(cpu_last_req_freq, cpu);
-		per_cpu(cpu_last_req_freq, cpu) = rate;
-		per_cpu(physical_cluster, cpu) = new_cluster;
-
-		new_rate = find_cluster_maxfreq(new_cluster);
-		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
-	} else {
-		new_rate = rate;
-	}
+	new_rate = rate;
 
 	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
 			__func__, cpu, old_cluster, new_cluster, new_rate);
@@ -167,43 +88,10 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	if (WARN_ON(ret)) {
 		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
 				new_cluster);
-		if (bLs) {
-			per_cpu(cpu_last_req_freq, cpu) = prev_rate;
-			per_cpu(physical_cluster, cpu) = old_cluster;
-		}
-
-		mutex_unlock(&cluster_lock[new_cluster]);
 
 		return ret;
 	}
 
-	mutex_unlock(&cluster_lock[new_cluster]);
-
-	/* Recalc freq for old cluster when switching clusters */
-	if (old_cluster != new_cluster) {
-		pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
-				__func__, cpu, old_cluster, new_cluster);
-
-		/* Switch cluster */
-		bL_switch_request(cpu, new_cluster);
-
-		mutex_lock(&cluster_lock[old_cluster]);
-
-		/* Set freq of old cluster if there are cpus left on it */
-		new_rate = find_cluster_maxfreq(old_cluster);
-		new_rate = ACTUAL_FREQ(old_cluster, new_rate);
-
-		if (new_rate) {
-			pr_debug("%s: Updating rate of old cluster: %d, to freq: %d\n",
-					__func__, old_cluster, new_rate);
-
-			if (clk_set_rate(clk[old_cluster], new_rate * 1000))
-				pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
-						__func__, ret, old_cluster);
-		}
-		mutex_unlock(&cluster_lock[old_cluster]);
-	}
-
 	return 0;
 }
 
@@ -211,91 +99,14 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
 		unsigned int index)
 {
-	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
+	u32 cpu = policy->cpu, cur_cluster;
 	unsigned int freqs_new;
 
-	cur_cluster = cpu_to_cluster(cpu);
-	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
+	cur_cluster = raw_cpu_to_cluster(cpu);
 
 	freqs_new = freq_table[cur_cluster][index].frequency;
 
-	if (is_bL_switching_enabled()) {
-		if ((actual_cluster == A15_CLUSTER) &&
-				(freqs_new < clk_big_min)) {
-			new_cluster = A7_CLUSTER;
-		} else if ((actual_cluster == A7_CLUSTER) &&
-				(freqs_new > clk_little_max)) {
-			new_cluster = A15_CLUSTER;
-		}
-	}
-
-	return bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
-}
-
-static inline u32 get_table_count(struct cpufreq_frequency_table *table)
-{
-	int count;
-
-	for (count = 0; table[count].frequency != CPUFREQ_TABLE_END; count++)
-		;
-
-	return count;
-}
-
-/* get the minimum frequency in the cpufreq_frequency_table */
-static inline u32 get_table_min(struct cpufreq_frequency_table *table)
-{
-	struct cpufreq_frequency_table *pos;
-	uint32_t min_freq = ~0;
-	cpufreq_for_each_entry(pos, table)
-		if (pos->frequency < min_freq)
-			min_freq = pos->frequency;
-	return min_freq;
-}
-
-/* get the maximum frequency in the cpufreq_frequency_table */
-static inline u32 get_table_max(struct cpufreq_frequency_table *table)
-{
-	struct cpufreq_frequency_table *pos;
-	uint32_t max_freq = 0;
-	cpufreq_for_each_entry(pos, table)
-		if (pos->frequency > max_freq)
-			max_freq = pos->frequency;
-	return max_freq;
-}
-
-static int merge_cluster_tables(void)
-{
-	int i, j, k = 0, count = 1;
-	struct cpufreq_frequency_table *table;
-
-	for (i = 0; i < MAX_CLUSTERS; i++)
-		count += get_table_count(freq_table[i]);
-
-	table = kzalloc(sizeof(*table) * count, GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
-
-	freq_table[MAX_CLUSTERS] = table;
-
-	/* Add in reverse order to get freqs in increasing order */
-	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
-		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
-				j++) {
-			table[k].frequency = VIRT_FREQ(i,
-					freq_table[i][j].frequency);
-			pr_debug("%s: index: %d, freq: %d\n", __func__, k,
-					table[k].frequency);
-			k++;
-		}
-	}
-
-	table[k].driver_data = k;
-	table[k].frequency = CPUFREQ_TABLE_END;
-
-	pr_debug("%s: End, table: %p, count: %d\n", __func__, table, k);
-
-	return 0;
+	return bL_cpufreq_set_rate(cpu, cur_cluster, cur_cluster, freqs_new);
 }
 
 static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
@@ -316,27 +127,12 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
 static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
 					   const struct cpumask *cpumask)
 {
-	u32 cluster = cpu_to_cluster(cpu_dev->id);
-	int i;
+	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
 
 	if (atomic_dec_return(&cluster_usage[cluster]))
 		return;
 
-	if (cluster < MAX_CLUSTERS)
-		return _put_cluster_clk_and_freq_table(cpu_dev, cpumask);
-
-	for_each_present_cpu(i) {
-		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return;
-		}
-
-		_put_cluster_clk_and_freq_table(cdev, cpumask);
-	}
-
-	/* free virtual table */
-	kfree(freq_table[cluster]);
+	return _put_cluster_clk_and_freq_table(cpu_dev, cpumask);
 }
 
 static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
@@ -387,68 +183,22 @@ out:
 static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 					  const struct cpumask *cpumask)
 {
-	u32 cluster = cpu_to_cluster(cpu_dev->id);
-	int i, ret;
+	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
+	int ret;
 
 	if (atomic_inc_return(&cluster_usage[cluster]) != 1)
 		return 0;
 
-	if (cluster < MAX_CLUSTERS) {
-		ret = _get_cluster_clk_and_freq_table(cpu_dev, cpumask);
-		if (ret)
-			atomic_dec(&cluster_usage[cluster]);
-		return ret;
-	}
-
-	/*
-	 * Get data for all clusters and fill virtual cluster with a merge of
-	 * both
-	 */
-	for_each_present_cpu(i) {
-		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return -ENODEV;
-		}
-
-		ret = _get_cluster_clk_and_freq_table(cdev, cpumask);
-		if (ret)
-			goto put_clusters;
-	}
-
-	ret = merge_cluster_tables();
+	ret = _get_cluster_clk_and_freq_table(cpu_dev, cpumask);
 	if (ret)
-		goto put_clusters;
-
-	/* Assuming 2 cluster, set clk_big_min and clk_little_max */
-	clk_big_min = get_table_min(freq_table[0]);
-	clk_little_max = VIRT_FREQ(1, get_table_max(freq_table[1]));
-
-	pr_debug("%s: cluster: %d, clk_big_min: %d, clk_little_max: %d\n",
-			__func__, cluster, clk_big_min, clk_little_max);
-
-	return 0;
-
-put_clusters:
-	for_each_present_cpu(i) {
-		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return -ENODEV;
-		}
-
-		_put_cluster_clk_and_freq_table(cdev, cpumask);
-	}
-
-	atomic_dec(&cluster_usage[cluster]);
-
+		atomic_dec(&cluster_usage[cluster]);
 	return ret;
 }
 
 /* Per-CPU initialization */
 static int bL_cpufreq_init(struct cpufreq_policy *policy)
 {
-	u32 cur_cluster = cpu_to_cluster(policy->cpu);
+	u32 cur_cluster = raw_cpu_to_cluster(policy->cpu);
 	struct device *cpu_dev;
 	int ret;
 
@@ -459,17 +209,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	if (cur_cluster < MAX_CLUSTERS) {
-		int cpu;
-
-		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
-
-		for_each_cpu(cpu, policy->cpus)
-			per_cpu(physical_cluster, cpu) = cur_cluster;
-	} else {
-		/* Assumption: during init, we are always running on A15 */
-		per_cpu(physical_cluster, policy->cpu) = A15_CLUSTER;
-	}
+	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
 
 	ret = get_cluster_clk_and_freq_table(cpu_dev, policy->cpus);
 	if (ret)
@@ -489,9 +229,6 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	else
 		policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
-	if (is_bL_switching_enabled())
-		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
-
 	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
 	return 0;
 }
@@ -499,12 +236,10 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
-	int cur_cluster = cpu_to_cluster(policy->cpu);
+	int cur_cluster = raw_cpu_to_cluster(policy->cpu);
 
-	if (cur_cluster < MAX_CLUSTERS) {
-		cpufreq_cooling_unregister(cdev[cur_cluster]);
-		cdev[cur_cluster] = NULL;
-	}
+	cpufreq_cooling_unregister(cdev[cur_cluster]);
+	cdev[cur_cluster] = NULL;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -522,13 +257,9 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	int cur_cluster = cpu_to_cluster(policy->cpu);
+	int cur_cluster = raw_cpu_to_cluster(policy->cpu);
 	struct device_node *np;
 
-	/* Do not register a cpu_cooling device if we are in IKS mode */
-	if (cur_cluster >= MAX_CLUSTERS)
-		return;
-
 	np = of_node_get(cpu_dev->of_node);
 	if (WARN_ON(!np))
 		return;
@@ -558,63 +289,16 @@ static struct cpufreq_driver bL_cpufreq_driver = {
 					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify			= cpufreq_generic_frequency_table_verify,
 	.target_index		= bL_cpufreq_set_target,
-	.get			= bL_cpufreq_get_rate,
+	.get			= clk_get_cpu_rate,
 	.init			= bL_cpufreq_init,
 	.exit			= bL_cpufreq_exit,
 	.ready			= bL_cpufreq_ready,
 	.attr			= cpufreq_generic_attr,
 };
 
-#ifdef CONFIG_BL_SWITCHER
-static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
-					unsigned long action, void *_arg)
-{
-	pr_debug("%s: action: %ld\n", __func__, action);
-
-	switch (action) {
-	case BL_NOTIFY_PRE_ENABLE:
-	case BL_NOTIFY_PRE_DISABLE:
-		cpufreq_unregister_driver(&bL_cpufreq_driver);
-		break;
-
-	case BL_NOTIFY_POST_ENABLE:
-		set_switching_enabled(true);
-		cpufreq_register_driver(&bL_cpufreq_driver);
-		break;
-
-	case BL_NOTIFY_POST_DISABLE:
-		set_switching_enabled(false);
-		cpufreq_register_driver(&bL_cpufreq_driver);
-		break;
-
-	default:
-		return NOTIFY_DONE;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block bL_switcher_notifier = {
-	.notifier_call = bL_cpufreq_switcher_notifier,
-};
-
-static int __bLs_register_notifier(void)
-{
-	return bL_switcher_register_notifier(&bL_switcher_notifier);
-}
-
-static int __bLs_unregister_notifier(void)
-{
-	return bL_switcher_unregister_notifier(&bL_switcher_notifier);
-}
-#else
-static int __bLs_register_notifier(void) { return 0; }
-static int __bLs_unregister_notifier(void) { return 0; }
-#endif
-
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 {
-	int ret, i;
+	int ret;
 
 	if (arm_bL_ops) {
 		pr_debug("%s: Already registered: %s, exiting\n", __func__,
@@ -629,28 +313,16 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 
 	arm_bL_ops = ops;
 
-	set_switching_enabled(bL_switcher_get_enabled());
-
-	for (i = 0; i < MAX_CLUSTERS; i++)
-		mutex_init(&cluster_lock[i]);
-
 	ret = cpufreq_register_driver(&bL_cpufreq_driver);
 	if (ret) {
 		pr_info("%s: Failed registering platform driver: %s, err: %d\n",
 				__func__, ops->name, ret);
 		arm_bL_ops = NULL;
 	} else {
-		ret = __bLs_register_notifier();
-		if (ret) {
-			cpufreq_unregister_driver(&bL_cpufreq_driver);
-			arm_bL_ops = NULL;
-		} else {
-			pr_info("%s: Registered platform driver: %s\n",
-					__func__, ops->name);
-		}
+		pr_info("%s: Registered platform driver: %s\n",
+				__func__, ops->name);
 	}
 
-	bL_switcher_put_enabled();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bL_cpufreq_register);
@@ -663,10 +335,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
 		return;
 	}
 
-	bL_switcher_get_enabled();
-	__bLs_unregister_notifier();
 	cpufreq_unregister_driver(&bL_cpufreq_driver);
-	bL_switcher_put_enabled();
 	pr_info("%s: Un-registered platform driver: %s\n", __func__,
 			arm_bL_ops->name);
 	arm_bL_ops = NULL;
-- 
1.9.1
