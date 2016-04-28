From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/2] cpufreq: arm_big_little: use generic OPP functions for {init,free}_opp_table
Date: Thu, 28 Apr 2016 11:25:14 +0100
Message-ID: <1461839114-29857-2-git-send-email-sudeep.holla@arm.com>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41959 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbcD1KZ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 06:25:27 -0400
In-Reply-To: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Currently when performing random hotplugs and suspend-to-ram(S2R) on
systems using arm_big_little cpufreq driver, we get warnings similar to:

cpu cpu1: _opp_add: duplicate OPPs detected. Existing: freq: 600000000,
	volt: 800000, enabled: 1. New: freq: 600000000, volt: 800000, enabled: 1

This is mainly because the OPPs for the shared cpus are not set. We can
just use dev_pm_opp_of_cpumask_add_table in case the OPPs are obtained
from DT(arm_big_little_dt.c) or use dev_pm_opp_set_sharing_cpus if the
OPPs are obtained by other means like firmware(e.g. scpi-cpufreq.c)

Also now that the generic dev_pm_opp_cpumask_remove_table can handle
removal of opp table and entries for all associated CPUs, we can reuse
dev_pm_opp_cpumask_remove_table as free_opp_table in cpufreq_arm_bL_ops.

This patch makes necessary changes to reuse the generic OPP functions for
{init,free}_opp_table and thereby eliminating the warnings.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/arm_big_little.c    | 54 ++++++++++++++++++++-----------------
 drivers/cpufreq/arm_big_little.h    |  4 +--
 drivers/cpufreq/arm_big_little_dt.c | 21 ++-------------
 drivers/cpufreq/scpi-cpufreq.c      | 24 ++++++++++++++---
 4 files changed, 54 insertions(+), 49 deletions(-)

Hi Viresh,

Why is dynamic OPPs not deleted in dev_pm_opp_{,cpumask_}remove_table ?
It would remove some code in scpi-cpufreq.c but I would like to understand.
Is there any use in not deleting them there ?

Regards,
Sudeep

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index c251247ae661..6f3a951da31f 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -298,7 +298,8 @@ static int merge_cluster_tables(void)
 	return 0;
 }
 
-static void _put_cluster_clk_and_freq_table(struct device *cpu_dev)
+static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
+					    cpumask_var_t cpumask)
 {
 	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
 
@@ -308,11 +309,12 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev)
 	clk_put(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
 	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpu_dev);
+		arm_bL_ops->free_opp_table(cpumask);
 	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
 }
 
-static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
+static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
+					   cpumask_var_t cpumask)
 {
 	u32 cluster = cpu_to_cluster(cpu_dev->id);
 	int i;
@@ -321,7 +323,7 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
 		return;
 
 	if (cluster < MAX_CLUSTERS)
-		return _put_cluster_clk_and_freq_table(cpu_dev);
+		return _put_cluster_clk_and_freq_table(cpu_dev, cpumask);
 
 	for_each_present_cpu(i) {
 		struct device *cdev = get_cpu_device(i);
@@ -330,14 +332,15 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
 			return;
 		}
 
-		_put_cluster_clk_and_freq_table(cdev);
+		_put_cluster_clk_and_freq_table(cdev, cpumask);
 	}
 
 	/* free virtual table */
 	kfree(freq_table[cluster]);
 }
 
-static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
+static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
+					   cpumask_var_t cpumask)
 {
 	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
 	int ret;
@@ -345,7 +348,7 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 	if (freq_table[cluster])
 		return 0;
 
-	ret = arm_bL_ops->init_opp_table(cpu_dev);
+	ret = arm_bL_ops->init_opp_table(cpumask);
 	if (ret) {
 		dev_err(cpu_dev, "%s: init_opp_table failed, cpu: %d, err: %d\n",
 				__func__, cpu_dev->id, ret);
@@ -374,14 +377,15 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 
 free_opp_table:
 	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpu_dev);
+		arm_bL_ops->free_opp_table(cpumask);
 out:
 	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
 			cluster);
 	return ret;
 }
 
-static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
+static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
+					  cpumask_var_t cpumask)
 {
 	u32 cluster = cpu_to_cluster(cpu_dev->id);
 	int i, ret;
@@ -390,7 +394,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
 		return 0;
 
 	if (cluster < MAX_CLUSTERS) {
-		ret = _get_cluster_clk_and_freq_table(cpu_dev);
+		ret = _get_cluster_clk_and_freq_table(cpu_dev, cpumask);
 		if (ret)
 			atomic_dec(&cluster_usage[cluster]);
 		return ret;
@@ -407,7 +411,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
 			return -ENODEV;
 		}
 
-		ret = _get_cluster_clk_and_freq_table(cdev);
+		ret = _get_cluster_clk_and_freq_table(cdev, cpumask);
 		if (ret)
 			goto put_clusters;
 	}
@@ -433,7 +437,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
 			return -ENODEV;
 		}
 
-		_put_cluster_clk_and_freq_table(cdev);
+		_put_cluster_clk_and_freq_table(cdev, cpumask);
 	}
 
 	atomic_dec(&cluster_usage[cluster]);
@@ -455,18 +459,6 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = get_cluster_clk_and_freq_table(cpu_dev);
-	if (ret)
-		return ret;
-
-	ret = cpufreq_table_validate_and_show(policy, freq_table[cur_cluster]);
-	if (ret) {
-		dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
-				policy->cpu, cur_cluster);
-		put_cluster_clk_and_freq_table(cpu_dev);
-		return ret;
-	}
-
 	if (cur_cluster < MAX_CLUSTERS) {
 		int cpu;
 
@@ -479,6 +471,18 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		per_cpu(physical_cluster, policy->cpu) = A15_CLUSTER;
 	}
 
+	ret = get_cluster_clk_and_freq_table(cpu_dev, policy->cpus);
+	if (ret)
+		return ret;
+
+	ret = cpufreq_table_validate_and_show(policy, freq_table[cur_cluster]);
+	if (ret) {
+		dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
+			policy->cpu, cur_cluster);
+		put_cluster_clk_and_freq_table(cpu_dev, policy->cpus);
+		return ret;
+	}
+
 	if (arm_bL_ops->get_transition_latency)
 		policy->cpuinfo.transition_latency =
 			arm_bL_ops->get_transition_latency(cpu_dev);
@@ -509,7 +513,7 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	put_cluster_clk_and_freq_table(cpu_dev);
+	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
 	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
 
 	return 0;
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
index b88889d9387e..adb32c36903b 100644
--- a/drivers/cpufreq/arm_big_little.h
+++ b/drivers/cpufreq/arm_big_little.h
@@ -30,11 +30,11 @@ struct cpufreq_arm_bL_ops {
 	 * This must set opp table for cpu_dev in a similar way as done by
 	 * dev_pm_opp_of_add_table().
 	 */
-	int (*init_opp_table)(struct device *cpu_dev);
+	int (*init_opp_table)(cpumask_var_t cpumask);
 
 	/* Optional */
 	int (*get_transition_latency)(struct device *cpu_dev);
-	void (*free_opp_table)(struct device *cpu_dev);
+	void (*free_opp_table)(cpumask_var_t cpumask);
 };
 
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops);
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index a8ff5e590125..8a66154a0cfd 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -43,23 +43,6 @@ static struct device_node *get_cpu_node_with_valid_op(int cpu)
 	return np;
 }
 
-static int dt_init_opp_table(struct device *cpu_dev)
-{
-	struct device_node *np;
-	int ret;
-
-	np = of_node_get(cpu_dev->of_node);
-	if (!np) {
-		pr_err("failed to find cpu%d node\n", cpu_dev->id);
-		return -ENOENT;
-	}
-
-	ret = dev_pm_opp_of_add_table(cpu_dev);
-	of_node_put(np);
-
-	return ret;
-}
-
 static int dt_get_transition_latency(struct device *cpu_dev)
 {
 	struct device_node *np;
@@ -81,8 +64,8 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 static struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
-	.init_opp_table = dt_init_opp_table,
-	.free_opp_table = dev_pm_opp_remove_table,
+	.init_opp_table = dev_pm_opp_of_cpumask_add_table,
+	.free_opp_table = dev_pm_opp_cpumask_remove_table,
 };
 
 static int generic_bL_probe(struct platform_device *pdev)
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index de5e89b2eaaa..83bd6050f227 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -18,6 +18,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -76,13 +77,30 @@ static int scpi_get_transition_latency(struct device *cpu_dev)
 	return info->latency;
 }
 
-static int scpi_init_opp_table(struct device *cpu_dev)
+static int scpi_init_opp_table(cpumask_var_t cpumask)
 {
-	return scpi_opp_table_ops(cpu_dev, false);
+	int ret;
+	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
+
+	ret = scpi_opp_table_ops(cpu_dev, false);
+	if (ret)
+		return ret;
+
+	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, cpumask);
+	if (ret)
+		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+			__func__, ret);
+	return ret;
 }
 
-static void scpi_free_opp_table(struct device *cpu_dev)
+static void scpi_free_opp_table(cpumask_var_t cpumask)
 {
+	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
+
+	cpumask_clear_cpu(cpu_dev->id, cpumask);
+	dev_pm_opp_cpumask_remove_table(cpumask);
+	cpumask_set_cpu(cpu_dev->id, cpumask);
+
 	scpi_opp_table_ops(cpu_dev, true);
 }
 
-- 
1.9.1

