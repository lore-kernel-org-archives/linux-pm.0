From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/6] PM / OPP: Prefix exported opp routines with dev_pm_opp_
Date: Fri,  4 Sep 2015 13:47:24 +0530
Message-ID: <5304383f1a99f2fd3a90c0a4cc1df4930b26a843.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Len Brown <len.brown@intel.com>, "moderated list:ARM
	SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS
	ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

That's the naming convention followed in most of opp core, but few
routines didn't follow this, fix them.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c       |  2 +-
 drivers/base/power/opp.c             | 41 ++++++++++++++++++------------------
 drivers/cpufreq/arm_big_little.h     |  2 +-
 drivers/cpufreq/arm_big_little_dt.c  |  4 ++--
 drivers/cpufreq/cpufreq-dt.c         | 10 ++++-----
 drivers/cpufreq/exynos5440-cpufreq.c |  6 +++---
 drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---
 drivers/cpufreq/mt8173-cpufreq.c     |  6 +++---
 include/linux/pm_opp.h               | 24 ++++++++++-----------
 9 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 3286eec91d92..3878494bd118 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -350,7 +350,7 @@ static void __init imx6q_opp_init(void)
 		return;
 	}
 
-	if (of_add_opp_table(cpu_dev)) {
+	if (dev_pm_opp_of_add_table(cpu_dev)) {
 		pr_warn("failed to init OPP table\n");
 		goto put_node;
 	}
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 1515c05bc579..f42ffa517156 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -800,8 +800,8 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * The opp is made available by default and it can be controlled using
  * dev_pm_opp_enable/disable functions and may be removed by dev_pm_opp_remove.
  *
- * NOTE: "dynamic" parameter impacts OPPs added by the of_add_opp_table and
- * freed by of_remove_opp_table.
+ * NOTE: "dynamic" parameter impacts OPPs added by the dev_pm_opp_of_add_table
+ * and freed by dev_pm_opp_of_remove_table.
  *
  * Locking: The internal device_opp and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -1185,7 +1185,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
 #ifdef CONFIG_OF
 /**
- * of_remove_opp_table() - Free OPP table entries created from static DT entries
+ * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
+ *				  entries
  * @dev:	device pointer used to lookup device OPPs.
  *
  * Free OPPs created using static entries present in DT.
@@ -1196,7 +1197,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-void of_remove_opp_table(struct device *dev)
+void dev_pm_opp_of_remove_table(struct device *dev)
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp, *tmp;
@@ -1231,9 +1232,9 @@ void of_remove_opp_table(struct device *dev)
 unlock:
 	mutex_unlock(&dev_opp_list_lock);
 }
-EXPORT_SYMBOL_GPL(of_remove_opp_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-void of_cpumask_remove_opp_table(cpumask_var_t cpumask)
+void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -1248,10 +1249,10 @@ void of_cpumask_remove_opp_table(cpumask_var_t cpumask)
 			continue;
 		}
 
-		of_remove_opp_table(cpu_dev);
+		dev_pm_opp_of_remove_table(cpu_dev);
 	}
 }
-EXPORT_SYMBOL_GPL(of_cpumask_remove_opp_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
 static struct device_node *_of_get_opp_desc_node(struct device *dev)
@@ -1309,7 +1310,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	return 0;
 
 free_table:
-	of_remove_opp_table(dev);
+	dev_pm_opp_of_remove_table(dev);
 
 	return ret;
 }
@@ -1352,7 +1353,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 }
 
 /**
- * of_add_opp_table() - Initialize opp table from device tree
+ * dev_pm_opp_of_add_table() - Initialize opp table from device tree
  * @dev:	device pointer used to lookup device OPPs.
  *
  * Register the initial OPP table with the OPP library for given device.
@@ -1374,7 +1375,7 @@ static int _of_add_opp_table_v1(struct device *dev)
  * -ENODATA	when empty 'operating-points' property is found
  * -EINVAL	when invalid entries are found in opp-v2 table
  */
-int of_add_opp_table(struct device *dev)
+int dev_pm_opp_of_add_table(struct device *dev)
 {
 	struct device_node *opp_np;
 	int ret;
@@ -1397,9 +1398,9 @@ int of_add_opp_table(struct device *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_add_opp_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
-int of_cpumask_add_opp_table(cpumask_var_t cpumask)
+int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu, ret = 0;
@@ -1414,23 +1415,23 @@ int of_cpumask_add_opp_table(cpumask_var_t cpumask)
 			continue;
 		}
 
-		ret = of_add_opp_table(cpu_dev);
+		ret = dev_pm_opp_of_add_table(cpu_dev);
 		if (ret) {
 			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
 			       __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			of_cpumask_remove_opp_table(cpumask);
+			dev_pm_opp_of_cpumask_remove_table(cpumask);
 			break;
 		}
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_cpumask_add_opp_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 
 /* Required only for V1 bindings, as v2 can manage it from DT itself */
-int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	struct device_list_opp *list_dev;
 	struct device_opp *dev_opp;
@@ -1468,7 +1469,7 @@ int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(set_cpus_sharing_opps);
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
 /*
  * Works only for OPP v2 bindings.
@@ -1476,7 +1477,7 @@ EXPORT_SYMBOL_GPL(set_cpus_sharing_opps);
  * cpumask should be already set to mask of cpu_dev->id.
  * Returns -ENOENT if operating-points-v2 bindings aren't supported.
  */
-int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	struct device_node *np, *tmp_np;
 	struct device *tcpu_dev;
@@ -1526,5 +1527,5 @@ int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
 	of_node_put(np);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_get_cpus_sharing_opps);
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 #endif
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
index d7ac320ead23..b88889d9387e 100644
--- a/drivers/cpufreq/arm_big_little.h
+++ b/drivers/cpufreq/arm_big_little.h
@@ -28,7 +28,7 @@ struct cpufreq_arm_bL_ops {
 
 	/*
 	 * This must set opp table for cpu_dev in a similar way as done by
-	 * of_add_opp_table().
+	 * dev_pm_opp_of_add_table().
 	 */
 	int (*init_opp_table)(struct device *cpu_dev);
 
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 47ac0ff54e3a..16ddeefe9443 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -54,7 +54,7 @@ static int dt_init_opp_table(struct device *cpu_dev)
 		return -ENOENT;
 	}
 
-	ret = of_add_opp_table(cpu_dev);
+	ret = dev_pm_opp_of_add_table(cpu_dev);
 	of_node_put(np);
 
 	return ret;
@@ -82,7 +82,7 @@ static struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
 	.init_opp_table = dt_init_opp_table,
-	.free_opp_table = of_remove_opp_table,
+	.free_opp_table = dev_pm_opp_of_remove_table,
 };
 
 static int generic_bL_probe(struct platform_device *pdev)
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 449d3a4efec2..9166c308e368 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -215,7 +215,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
-	ret = of_get_cpus_sharing_opps(cpu_dev, policy->cpus);
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
 		/*
 		 * operating-points-v2 not supported, fallback to old method of
@@ -237,7 +237,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 *
 	 * OPPs might be populated at runtime, don't check for error here
 	 */
-	of_cpumask_add_opp_table(policy->cpus);
+	dev_pm_opp_of_cpumask_add_table(policy->cpus);
 
 	/*
 	 * But we need OPP table to function so if it is not there let's
@@ -260,7 +260,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		 * OPP tables are initialized only for policy->cpu, do it for
 		 * others as well.
 		 */
-		ret = set_cpus_sharing_opps(cpu_dev, policy->cpus);
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
 		if (ret)
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
@@ -360,7 +360,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	of_cpumask_remove_opp_table(policy->cpus);
+	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -377,7 +377,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	of_cpumask_remove_opp_table(policy->related_cpus);
+	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index fc46813d3b83..c0f3373706f4 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -360,7 +360,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		goto err_put_node;
 	}
 
-	ret = of_add_opp_table(dvfs_info->dev);
+	ret = dev_pm_opp_of_add_table(dvfs_info->dev);
 	if (ret) {
 		dev_err(dvfs_info->dev, "failed to init OPP table: %d\n", ret);
 		goto err_put_node;
@@ -424,7 +424,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 err_free_table:
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
 err_free_opp:
-	of_remove_opp_table(dvfs_info->dev);
+	dev_pm_opp_of_remove_table(dvfs_info->dev);
 err_put_node:
 	of_node_put(np);
 	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
@@ -435,7 +435,7 @@ static int exynos_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&exynos_driver);
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
-	of_remove_opp_table(dvfs_info->dev);
+	dev_pm_opp_of_remove_table(dvfs_info->dev);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 3802765aeb9f..84fbc8e8fc56 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -202,7 +202,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	 */
 	num = dev_pm_opp_get_opp_count(cpu_dev);
 	if (num < 0) {
-		ret = of_add_opp_table(cpu_dev);
+		ret = dev_pm_opp_of_add_table(cpu_dev);
 		if (ret < 0) {
 			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
 			goto put_reg;
@@ -312,7 +312,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_opp:
 	if (free_opp)
-		of_remove_opp_table(cpu_dev);
+		dev_pm_opp_of_remove_table(cpu_dev);
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
@@ -340,7 +340,7 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
-		of_remove_opp_table(cpu_dev);
+		dev_pm_opp_of_remove_table(cpu_dev);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 519e83146e86..83001dc5b646 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -344,7 +344,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	/* Both presence and absence of sram regulator are valid cases. */
 	sram_reg = regulator_get_exclusive(cpu_dev, "sram");
 
-	ret = of_add_opp_table(cpu_dev);
+	ret = dev_pm_opp_of_add_table(cpu_dev);
 	if (ret) {
 		pr_warn("no OPP table for cpu%d\n", cpu);
 		goto out_free_resources;
@@ -378,7 +378,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	return 0;
 
 out_free_opp_table:
-	of_remove_opp_table(cpu_dev);
+	dev_pm_opp_of_remove_table(cpu_dev);
 
 out_free_resources:
 	if (!IS_ERR(proc_reg))
@@ -404,7 +404,7 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	if (!IS_ERR(info->inter_clk))
 		clk_put(info->inter_clk);
 
-	of_remove_opp_table(info->cpu_dev);
+	dev_pm_opp_of_remove_table(info->cpu_dev);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5b6243014f8a..93695e5263a3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -126,37 +126,37 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-int of_add_opp_table(struct device *dev);
-void of_remove_opp_table(struct device *dev);
-int of_cpumask_add_opp_table(cpumask_var_t cpumask);
-void of_cpumask_remove_opp_table(cpumask_var_t cpumask);
-int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
-int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_of_add_table(struct device *dev);
+void dev_pm_opp_of_remove_table(struct device *dev);
+int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask);
+void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask);
+int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
-static inline int of_add_opp_table(struct device *dev)
+static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
 	return -EINVAL;
 }
 
-static inline void of_remove_opp_table(struct device *dev)
+static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
 
-static inline int of_cpumask_add_opp_table(cpumask_var_t cpumask)
+static inline int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 {
 	return -ENOSYS;
 }
 
-static inline void of_cpumask_remove_opp_table(cpumask_var_t cpumask)
+static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 {
 }
 
-static inline int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	return -ENOSYS;
 }
 
-static inline int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	return -ENOSYS;
 }
-- 
2.4.0
