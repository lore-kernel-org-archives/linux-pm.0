From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] cpufreq: hisilicon: add acpu driver
Date: Thu, 26 Feb 2015 21:21:38 +0800
Message-ID: <1424956899-8891-2-git-send-email-leo.yan@linaro.org>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36994 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbbBZNWv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 08:22:51 -0500
Received: by pabrd3 with SMTP id rd3so13963430pab.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2015 05:22:50 -0800 (PST)
In-Reply-To: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com
Cc: Leo Yan <leo.yan@linaro.org>

Add acpu driver for hisilicon SoC, acpu is application processor
subsystem. Dependent on the H/W design, the silicon may has the coupled
clock domain for all clusters, or every cluster can have the dedicated
clock domain. So this driver will support both implementations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpufreq/Kconfig.arm         |   9 +
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/hisi-acpu-cpufreq.c | 324 ++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1b06fc4..7a61d09 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -108,6 +108,15 @@ config ARM_HIGHBANK_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_HISI_ACPU_CPUFREQ
+	tristate "CPUfreq driver for Hisilicon ACPU"
+	depends on ARCH_HISI
+	select PM_OPP
+	help
+	  This enables the CPUfreq driver for hisilicon ACPU.
+
+	  If in doubt, say N.
+
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 82a1821..6b7a3f0 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -59,6 +59,7 @@ arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
+obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
diff --git a/drivers/cpufreq/hisi-acpu-cpufreq.c b/drivers/cpufreq/hisi-acpu-cpufreq.c
new file mode 100644
index 0000000..d8a7c65
--- /dev/null
+++ b/drivers/cpufreq/hisi-acpu-cpufreq.c
@@ -0,0 +1,324 @@
+/*
+ * Hisilicon Platforms Using ACPU CPUFreq support
+ *
+ * Copyright (C) 2015 Linaro.
+ * Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/cpu_cooling.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
+#include <linux/types.h>
+
+#define MAX_CLUSTERS	2
+
+static unsigned int coupled_clusters;
+
+static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS];
+static atomic_t cluster_usage[MAX_CLUSTERS] = {
+	ATOMIC_INIT(0),
+	ATOMIC_INIT(0),
+};
+
+static struct clk *clk[MAX_CLUSTERS];
+static struct mutex cluster_lock[MAX_CLUSTERS];
+static struct thermal_cooling_device *cdev;
+
+static inline int cpu_to_cluster(int cpu)
+{
+	return coupled_clusters ? 0 : topology_physical_package_id(cpu);
+}
+
+static unsigned int hisi_acpu_cpufreq_get_rate(unsigned int cpu)
+{
+	int cluster = cpu_to_cluster(cpu);
+	unsigned int freq;
+
+	mutex_lock(&cluster_lock[cluster]);
+
+	freq = clk_get_rate(clk[cluster]) / 1000;
+
+	mutex_unlock(&cluster_lock[cluster]);
+	return freq;
+}
+
+/* Set clock frequency */
+static int hisi_acpu_cpufreq_set_target(struct cpufreq_policy *policy,
+		unsigned int index)
+{
+	u32 cpu = policy->cpu, cluster;
+	unsigned int freqs_new;
+	int ret = 0;
+
+	cluster = cpu_to_cluster(cpu);
+	freqs_new = freq_table[cluster][index].frequency;
+
+	pr_debug("%s: cluster %d freq_new %d\n", __func__, cluster, freqs_new);
+
+	mutex_lock(&cluster_lock[cluster]);
+
+	ret = clk_set_rate(clk[cluster], freqs_new * 1000);
+	if (WARN_ON(ret))
+		pr_err("clk_set_rate failed: %d, cluster: %d\n", ret, cluster);
+
+	mutex_unlock(&cluster_lock[cluster]);
+	return ret;
+}
+
+static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
+{
+	u32 cluster = cpu_to_cluster(cpu_dev->id);
+
+	if (atomic_dec_return(&cluster_usage[cluster]))
+		return;
+
+	if (!freq_table[cluster])
+		return;
+
+	clk_put(clk[cluster]);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
+}
+
+static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
+{
+	struct device_node *np;
+	u32 cluster;
+	char name[6];
+	int ret;
+
+	cluster = cpu_to_cluster(cpu_dev->id);
+
+	if (atomic_inc_return(&cluster_usage[cluster]) != 1)
+		return 0;
+
+	if (freq_table[cluster])
+		return 0;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		dev_err(cpu_dev, "%s: failed to find cpu%d node\n",
+				__func__, cpu_dev->id);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = of_init_opp_table(cpu_dev);
+	if (ret) {
+		dev_err(cpu_dev, "%s: init_opp_table failed, cpu: %d, err: %d\n",
+				__func__, cpu_dev->id, ret);
+		of_node_put(np);
+		goto out;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
+				__func__, cpu_dev->id, ret);
+		goto out;
+	}
+
+	sprintf(name, "acpu%d", cluster);
+	clk[cluster] = clk_get_sys(name, NULL);
+	if (IS_ERR(clk[cluster]))
+		clk[cluster] = clk_get(cpu_dev, name);
+	if (IS_ERR(clk[cluster])) {
+		dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
+				__func__, cpu_dev->id, cluster);
+		ret = PTR_ERR(clk[cluster]);
+		dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+		goto out;
+	} else {
+		dev_info(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
+			 __func__, clk[cluster], freq_table[cluster], cluster);
+	}
+
+	return 0;
+
+out:
+	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n",
+			__func__, cluster);
+	atomic_dec(&cluster_usage[cluster]);
+	return ret;
+}
+
+/* Per-CPU initialization */
+static int hisi_acpu_cpufreq_init(struct cpufreq_policy *policy)
+{
+	u32 cur_cluster = cpu_to_cluster(policy->cpu);
+	struct device *cpu_dev;
+	int ret;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+				policy->cpu);
+		return -ENODEV;
+	}
+
+	ret = get_cluster_clk_and_freq_table(cpu_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * If system have two clusters, usually the clock has two options:
+	 * 1. two clusters share the same clock source;
+	 * 2. two clusters have dedicated clock source;
+	 *
+	 * so add the flag coupled_clusters to indicate whether two clusters
+	 * share the clock source or not. if two clusters share the clock source
+	 * then directly call the generic init flow, it will bind all cpus...
+	 */
+	if (coupled_clusters)
+		return cpufreq_generic_init(policy, freq_table[0],
+					    1000000); /* 1 ms, assumed */
+
+	/* bind the cpus within the cluster */
+	ret = cpufreq_table_validate_and_show(policy,
+					      freq_table[cur_cluster]);
+	if (ret) {
+		dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
+				policy->cpu, cur_cluster);
+		put_cluster_clk_and_freq_table(cpu_dev);
+		return ret;
+	}
+
+	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+	policy->cpuinfo.transition_latency = 1000000; /* 1 ms, assumed */
+
+	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
+	return 0;
+}
+
+static int hisi_acpu_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+				policy->cpu);
+		return -ENODEV;
+	}
+
+	put_cluster_clk_and_freq_table(cpu_dev);
+	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
+	return 0;
+}
+
+static struct cpufreq_driver hisi_acpu_cpufreq_driver = {
+	.name		= "hisi-acpu",
+	.flags		= CPUFREQ_STICKY |
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= hisi_acpu_cpufreq_set_target,
+	.get		= hisi_acpu_cpufreq_get_rate,
+	.init		= hisi_acpu_cpufreq_init,
+	.exit		= hisi_acpu_cpufreq_exit,
+	.attr		= cpufreq_generic_attr,
+};
+
+static const struct of_device_id hisi_acpu_cpufreq_match[] = {
+	{
+		.compatible = "hisilicon,hisi-acpu-cpufreq",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hisi_acpu_cpufreq_match);
+
+static int hisi_acpu_cpufreq_probe(struct platform_device *pdev)
+{
+	int ret = 0, i;
+	struct device_node *np, *cpus;
+
+	np = pdev->dev.of_node;
+	if (!np) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	of_property_read_u32(np, "hisilicon,coupled-clusters",
+			     &coupled_clusters);
+	dev_dbg(&pdev->dev, "%s: coupled_clusters is %d\n",
+			__func__, coupled_clusters);
+
+	for (i = 0; i < MAX_CLUSTERS; i++)
+		mutex_init(&cluster_lock[i]);
+
+	ret = cpufreq_register_driver(&hisi_acpu_cpufreq_driver);
+	if (ret)
+		dev_err(&pdev->dev,
+			"%s: failed to register cpufreq driver\n", __func__);
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus) {
+		dev_err(&pdev->dev, "failed to find cpus node\n");
+		return 0;
+	}
+
+	np = of_get_next_child(cpus, NULL);
+	if (!np) {
+		dev_err(&pdev->dev, "failed to find cpus child node\n");
+		of_node_put(cpus);
+		return 0;
+	}
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
+		if (IS_ERR(cdev)) {
+			dev_err(&pdev->dev, "running cpufreq without cooling device: %ld\n",
+			       PTR_ERR(cdev));
+			cdev = NULL;
+		}
+	}
+	of_node_put(np);
+	of_node_put(cpus);
+
+	return 0;
+
+out:
+	return ret;
+}
+
+static int hisi_acpu_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_cooling_unregister(cdev);
+	cpufreq_unregister_driver(&hisi_acpu_cpufreq_driver);
+	return 0;
+}
+
+static struct platform_driver hisi_acpu_cpufreq_platdrv = {
+	.driver = {
+		.name	= "hisi-acpu-cpufreq",
+		.owner	= THIS_MODULE,
+		.of_match_table = hisi_acpu_cpufreq_match,
+	},
+	.probe		= hisi_acpu_cpufreq_probe,
+	.remove		= hisi_acpu_cpufreq_remove,
+};
+module_platform_driver(hisi_acpu_cpufreq_platdrv);
+
+MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
+MODULE_DESCRIPTION("Hisilicon acpu cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

