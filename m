From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 14/14] cpufreq: exynos-cpufreq: release resources by using managed allocation
Date: Mon,  2 Feb 2015 16:58:17 -0400
Message-ID: <1422910697-5920-15-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This change allows the proper resource release used by this driver.
The resources are now allocated using managed allocation by means
of the devm_* helper functions. Those resources that cannot be managed
are properly released during the device removal time.

The global variables have been removed as well. All static variables
were moved to driver data and properly assigned to cpufreq
driver data. In callbacks, now the data structure allocated
in probe time is fetched from cpufreq policy.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos-cpufreq.c | 99 +++++++++++++++++++++++++---------------
 drivers/cpufreq/exynos-cpufreq.h |  5 ++
 2 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index a964602..f1a13e8 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -23,12 +23,8 @@
 
 #include "exynos-cpufreq.h"
 
-static struct exynos_dvfs_info *exynos_info;
-static struct thermal_cooling_device *cdev;
-static struct regulator *arm_regulator;
-static unsigned int locking_frequency;
-
-static int exynos_cpufreq_get_index(unsigned int freq)
+static int exynos_cpufreq_get_index(struct exynos_dvfs_info *exynos_info,
+				    unsigned int freq)
 {
 	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
 	struct cpufreq_frequency_table *pos;
@@ -43,7 +39,8 @@ static int exynos_cpufreq_get_index(unsigned int freq)
 	return pos - freq_table;
 }
 
-static int exynos_cpufreq_scale(unsigned int target_freq)
+static int exynos_cpufreq_scale(struct exynos_dvfs_info *exynos_info,
+				unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
 	unsigned int *volt_table = exynos_info->volt_table;
@@ -62,13 +59,13 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	 * old_index with cpufreq_frequency_table_target(). Thus, ignore
 	 * policy and get the index from the raw frequency table.
 	 */
-	old_index = exynos_cpufreq_get_index(old_freq);
+	old_index = exynos_cpufreq_get_index(exynos_info, old_freq);
 	if (old_index < 0) {
 		ret = old_index;
 		goto out;
 	}
 
-	index = exynos_cpufreq_get_index(target_freq);
+	index = exynos_cpufreq_get_index(exynos_info, target_freq);
 	if (index < 0) {
 		ret = index;
 		goto out;
@@ -90,7 +87,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	/* When the new frequency is higher than current frequency */
 	if ((target_freq > old_freq) && !safe_arm_volt) {
 		/* Firstly, voltage up to increase frequency */
-		ret = regulator_set_voltage(arm_regulator, arm_volt, arm_volt);
+		ret = regulator_set_voltage(exynos_info->arm_regulator,
+					    arm_volt, arm_volt);
 		if (ret) {
 			dev_err(dev, "failed to set cpu voltage to %d\n",
 				arm_volt);
@@ -99,8 +97,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	}
 
 	if (safe_arm_volt) {
-		ret = regulator_set_voltage(arm_regulator, safe_arm_volt,
-				      safe_arm_volt);
+		ret = regulator_set_voltage(exynos_info->arm_regulator,
+					    safe_arm_volt, safe_arm_volt);
 		if (ret) {
 			dev_err(dev, "failed to set cpu voltage to %d\n",
 				safe_arm_volt);
@@ -114,8 +112,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	if ((target_freq < old_freq) ||
 	   ((target_freq > old_freq) && safe_arm_volt)) {
 		/* down the voltage after frequency change */
-		ret = regulator_set_voltage(arm_regulator, arm_volt,
-				arm_volt);
+		ret = regulator_set_voltage(exynos_info->arm_regulator,
+					    arm_volt, arm_volt);
 		if (ret) {
 			dev_err(dev, "failed to set cpu voltage to %d\n",
 				arm_volt);
@@ -131,22 +129,39 @@ out:
 
 static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	return exynos_cpufreq_scale(exynos_info->freq_table[index].frequency);
+	struct exynos_dvfs_info *exynos_info = policy->driver_data;
+
+	return exynos_cpufreq_scale(exynos_info,
+				    exynos_info->freq_table[index].frequency);
 }
 
 static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
+	struct exynos_dvfs_info *exynos_info = policy->driver_data;
+
 	policy->clk = exynos_info->cpu_clk;
-	policy->suspend_freq = locking_frequency;
+	policy->suspend_freq = exynos_info->locking_frequency;
 	return cpufreq_generic_init(policy, exynos_info->freq_table, 100000);
 }
 
+static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct exynos_dvfs_info *info = policy->driver_data;
+
+	if (info->cdev)
+		cpufreq_cooling_unregister(info->cdev);
+	dev_pm_opp_free_cpufreq_table(info->dev, &policy->freq_table);
+	iounmap(info->cmu_regs);
+
+	return 0;
+}
 static struct cpufreq_driver exynos_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= exynos_target,
 	.get		= cpufreq_generic_get,
 	.init		= exynos_cpufreq_cpu_init,
+	.exit		= exynos_cpufreq_cpu_exit,
 	.name		= "exynos_cpufreq",
 	.attr		= cpufreq_generic_attr,
 #ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
@@ -159,10 +174,12 @@ static struct cpufreq_driver exynos_driver = {
 
 static int exynos_cpufreq_probe(struct platform_device *pdev)
 {
+	struct exynos_dvfs_info *exynos_info;
 	struct device_node *cpus, *np;
 	int ret = -EINVAL;
 
-	exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
+	exynos_info = devm_kzalloc(&pdev->dev, sizeof(*exynos_info),
+				   GFP_KERNEL);
 	if (!exynos_info)
 		return -ENOMEM;
 
@@ -186,57 +203,64 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	if (ret)
-		goto err_vdd_arm;
+		return -EINVAL;
 
 	if (exynos_info->set_freq == NULL) {
 		dev_err(&pdev->dev, "No set_freq function (ERR)\n");
-		goto err_vdd_arm;
+		return -EINVAL;
 	}
 
-	arm_regulator = regulator_get(NULL, "vdd_arm");
-	if (IS_ERR(arm_regulator)) {
+	exynos_info->arm_regulator = devm_regulator_get(exynos_info->dev,
+							"vdd_arm");
+	if (IS_ERR(exynos_info->arm_regulator)) {
 		dev_err(&pdev->dev, "failed to get resource vdd_arm\n");
-		goto err_vdd_arm;
+		return -EINVAL;
 	}
 
 	/* Done here as we want to capture boot frequency */
-	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
+	exynos_info->locking_frequency = clk_get_rate(exynos_info->cpu_clk) /
+					1000;
+
+	exynos_driver.driver_data = exynos_info;
 
 	ret = cpufreq_register_driver(&exynos_driver);
-	if (ret)
-		goto err_cpufreq_reg;
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register cpufreq driver\n");
+		return -EINVAL;
+	}
 
 	cpus = of_find_node_by_path("/cpus");
 	if (!cpus) {
 		pr_err("failed to find cpus node\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	np = of_get_next_child(cpus, NULL);
 	if (!np) {
 		pr_err("failed to find cpus child node\n");
-		of_node_put(cpus);
-		return 0;
+		goto of_exit;
 	}
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		cdev = of_cpufreq_cooling_register(np,
+		exynos_info->cdev = of_cpufreq_cooling_register(np,
 						   cpu_present_mask);
-		if (IS_ERR(cdev))
+		if (IS_ERR(exynos_info->cdev))
 			pr_err("running cpufreq without cooling device: %ld\n",
-			       PTR_ERR(cdev));
+			       PTR_ERR(exynos_info->cdev));
 	}
+
+of_exit:
 	of_node_put(np);
 	of_node_put(cpus);
 
 	return 0;
+}
 
-err_cpufreq_reg:
-	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
-	regulator_put(arm_regulator);
-err_vdd_arm:
-	kfree(exynos_info);
-	return -EINVAL;
+static int exynos_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&exynos_driver);
+
+	return 0;
 }
 
 static struct platform_driver exynos_cpufreq_platdrv = {
@@ -244,5 +268,6 @@ static struct platform_driver exynos_cpufreq_platdrv = {
 		.name	= "exynos-cpufreq",
 	},
 	.probe = exynos_cpufreq_probe,
+	.remove = exynos_cpufreq_remove,
 };
 module_platform_driver(exynos_cpufreq_platdrv);
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index b59558e..ac31d5d 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -9,6 +9,8 @@
  * published by the Free Software Foundation.
 */
 
+#include <linux/thermal.h>
+
 enum cpufreq_level_index {
 	L0, L1, L2, L3, L4,
 	L5, L6, L7, L8, L9,
@@ -51,6 +53,9 @@ struct exynos_dvfs_info {
 	void (*set_freq)(struct exynos_dvfs_info *, unsigned int, unsigned int);
 	bool (*need_apll_change)(unsigned int, unsigned int);
 	void __iomem	*cmu_regs;
+	struct thermal_cooling_device *cdev;
+	struct regulator *arm_regulator;
+	unsigned int locking_frequency;
 };
 
 #ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
-- 
2.1.3
