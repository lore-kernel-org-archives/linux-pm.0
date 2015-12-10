From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH v3] cpufreq: mt8173: move resources allocation into ->probe()
Date: Thu, 10 Dec 2015 11:48:13 +0800
Message-ID: <1449719293-7966-1-git-send-email-pi-cheng.chen@linaro.org>
References: <3188378.Wlzx7Ukr89@vostro.rjw.lan>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34693 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbbLJDsY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 22:48:24 -0500
Received: by pfbg73 with SMTP id g73so41586146pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 19:48:23 -0800 (PST)
In-Reply-To: <3188378.Wlzx7Ukr89@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Ricky Liang <jcliang@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Since the return value of ->init() of cpufreq driver is not propagated
to the device driver model now, move resources allocation into
->probe() to handle -EPROBE_DEFER properly.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
v2->v3:
- rename get_dvfs_info() as mtk_cpu_dvfs_info_lookup()
- fix some minor issues of v2
v1->v2:
- fix error handling path in ->probe()
---
 drivers/cpufreq/mt8173-cpufreq.c | 92 +++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 9d0fe37..fd601b9 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -41,16 +41,35 @@
  * the original PLL becomes stable at target frequency.
  */
 struct mtk_cpu_dvfs_info {
+	struct cpumask cpus;
 	struct device *cpu_dev;
 	struct regulator *proc_reg;
 	struct regulator *sram_reg;
 	struct clk *cpu_clk;
 	struct clk *inter_clk;
 	struct thermal_cooling_device *cdev;
+	struct list_head list_head;
 	int intermediate_voltage;
 	bool need_voltage_tracking;
 };
 
+static LIST_HEAD(dvfs_info_list);
+
+static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
+{
+	struct mtk_cpu_dvfs_info *info;
+	struct list_head *list;
+
+	list_for_each(list, &dvfs_info_list) {
+		info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
+
+		if (cpumask_test_cpu(cpu, &info->cpus))
+			return info;
+	}
+
+	return NULL;
+}
+
 static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 					int new_vproc)
 {
@@ -402,6 +421,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	 */
 	info->need_voltage_tracking = !IS_ERR(sram_reg);
 
+	/* CPUs in the same cluster share a clock and power domain. */
+	cpumask_copy(&info->cpus, &cpu_topology[cpu].core_sibling);
+
 	return 0;
 
 out_free_opp_table:
@@ -440,22 +462,18 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	int ret;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	ret = mtk_cpu_dvfs_info_init(info, policy->cpu);
-	if (ret) {
-		pr_err("%s failed to initialize dvfs info for cpu%d\n",
-		       __func__, policy->cpu);
-		goto out_free_dvfs_info;
+	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
+	if (!info) {
+		pr_err("dvfs info for cpu%d is not initialized.\n",
+		       policy->cpu);
+		return -EINVAL;
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);
 	if (ret) {
 		pr_err("failed to init cpufreq table for cpu%d: %d\n",
 		       policy->cpu, ret);
-		goto out_release_dvfs_info;
+		return ret;
 	}
 
 	ret = cpufreq_table_validate_and_show(policy, freq_table);
@@ -464,8 +482,7 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_cpufreq_table;
 	}
 
-	/* CPUs in the same cluster share a clock and power domain. */
-	cpumask_copy(policy->cpus, &cpu_topology[policy->cpu].core_sibling);
+	cpumask_copy(policy->cpus, &info->cpus);
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
@@ -473,13 +490,6 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 
 out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &freq_table);
-
-out_release_dvfs_info:
-	mtk_cpu_dvfs_info_release(info);
-
-out_free_dvfs_info:
-	kfree(info);
-
 	return ret;
 }
 
@@ -489,8 +499,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(info->cdev);
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
-	mtk_cpu_dvfs_info_release(info);
-	kfree(info);
 
 	return 0;
 }
@@ -510,11 +518,47 @@ static struct cpufreq_driver mt8173_cpufreq_driver = {
 
 static int mt8173_cpufreq_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct mtk_cpu_dvfs_info *info;
+	struct list_head *list, *tmp;
+	int cpu, ret;
+
+	for_each_possible_cpu(cpu) {
+		info = mtk_cpu_dvfs_info_lookup(cpu);
+		if (info)
+			continue;
+
+		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto release_dvfs_info_list;
+		}
+
+		ret = mtk_cpu_dvfs_info_init(info, cpu);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to initialize dvfs info for cpu%d\n",
+				cpu);
+			goto release_dvfs_info_list;
+		}
+
+		list_add(&info->list_head, &dvfs_info_list);
+	}
 
 	ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
-	if (ret)
-		pr_err("failed to register mtk cpufreq driver\n");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register mtk cpufreq driver\n");
+		goto release_dvfs_info_list;
+	}
+
+	return 0;
+
+release_dvfs_info_list:
+	list_for_each_safe(list, tmp, &dvfs_info_list) {
+		info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
+
+		mtk_cpu_dvfs_info_release(info);
+		list_del(list);
+	}
 
 	return ret;
 }
-- 
1.9.1

