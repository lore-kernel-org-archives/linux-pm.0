From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/2] PM / OPP: Remove OF dependency on dev_pm_opp_of_{cpumask_,}remove_table
Date: Thu, 28 Apr 2016 11:25:13 +0100
Message-ID: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Functions dev_pm_opp_of_{cpumask_,}remove_table removes/frees all the
static OPP entries associated with the device and/or all cpus(in case
of cpumask). It makes no references to the device node in the DT. It
can be used even for usecases where the static OPP entries are populated
reading from the firmware or some different method.

This patch renames both dev_pm_opp_of_{cpumask_,}remove_table to
dev_pm_opp_{cpumask_,}remove_table so that it can be used in the above
mentioned usecase.

This is in preparation to make use of the same in scpi-cpufreq.c

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/power/opp/core.c        | 16 ++++++++--------
 drivers/base/power/opp/cpu.c         | 10 +++++-----
 drivers/cpufreq/arm_big_little_dt.c  |  2 +-
 drivers/cpufreq/cpufreq-dt.c         |  4 ++--
 drivers/cpufreq/exynos5440-cpufreq.c |  4 ++--
 drivers/cpufreq/imx6q-cpufreq.c      |  4 ++--
 drivers/cpufreq/mt8173-cpufreq.c     |  4 ++--
 include/linux/pm_opp.h               | 20 ++++++++++----------
 8 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 433b60092972..6716e02ad5ed 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1054,7 +1054,7 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * dev_pm_opp_enable/disable functions and may be removed by dev_pm_opp_remove.
  *
  * NOTE: "dynamic" parameter impacts OPPs added by the dev_pm_opp_of_add_table
- * and freed by dev_pm_opp_of_remove_table.
+ * and freed by dev_pm_opp_remove_table.
  *
  * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -1845,13 +1845,12 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
-#ifdef CONFIG_OF
 /**
- * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
- *				  entries
+ * dev_pm_opp_remove_table() - Free OPP table static entries associated with
+ *			       the device
  * @dev:	device pointer used to lookup OPP table.
  *
- * Free OPPs created using static entries present in DT.
+ * Free static OPP entries associated with the device.
  *
  * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function indirectly uses RCU updater strategy with mutex locks
@@ -1859,7 +1858,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-void dev_pm_opp_of_remove_table(struct device *dev)
+void dev_pm_opp_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp, *tmp;
@@ -1894,8 +1893,9 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 unlock:
 	mutex_unlock(&opp_table_lock);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
 
+#ifdef CONFIG_OF
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
 struct device_node *_of_get_opp_desc_node(struct device *dev)
 {
@@ -1961,7 +1961,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	return 0;
 
 free_table:
-	dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_remove_table(dev);
 
 	return ret;
 }
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 55cbf9bd8707..278bab29f76c 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -119,7 +119,6 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-#ifdef CONFIG_OF
 /**
  * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask
  * @cpumask:	cpumask for which OPP table needs to be removed
@@ -132,7 +131,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
+void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -147,11 +146,12 @@ void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 			continue;
 		}
 
-		dev_pm_opp_of_remove_table(cpu_dev);
+		dev_pm_opp_remove_table(cpu_dev);
 	}
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
+#ifdef CONFIG_OF
 /**
  * dev_pm_opp_of_cpumask_add_table() - Adds OPP table for @cpumask
  * @cpumask:	cpumask for which OPP table needs to be added.
@@ -185,7 +185,7 @@ int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 			       __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			dev_pm_opp_of_cpumask_remove_table(cpumask);
+			dev_pm_opp_cpumask_remove_table(cpumask);
 			break;
 		}
 	}
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 16ddeefe9443..a8ff5e590125 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -82,7 +82,7 @@ static struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
 	.init_opp_table = dt_init_opp_table,
-	.free_opp_table = dev_pm_opp_of_remove_table,
+	.free_opp_table = dev_pm_opp_remove_table,
 };
 
 static int generic_bL_probe(struct platform_device *pdev)
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 5f8dbe640a20..c80681278f10 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -283,7 +283,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
 out_put_clk:
@@ -298,7 +298,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
 		dev_pm_opp_put_regulator(priv->cpu_dev);
 
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index c0f3373706f4..af5468c8e829 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -424,7 +424,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 err_free_table:
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
 err_free_opp:
-	dev_pm_opp_of_remove_table(dvfs_info->dev);
+	dev_pm_opp_remove_table(dvfs_info->dev);
 err_put_node:
 	of_node_put(np);
 	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
@@ -435,7 +435,7 @@ static int exynos_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&exynos_driver);
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
-	dev_pm_opp_of_remove_table(dvfs_info->dev);
+	dev_pm_opp_remove_table(dvfs_info->dev);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef1fa8145419..2bf5bf812f1a 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -346,7 +346,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_opp:
 	if (free_opp)
-		dev_pm_opp_of_remove_table(cpu_dev);
+		dev_pm_opp_remove_table(cpu_dev);
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
@@ -378,7 +378,7 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
-		dev_pm_opp_of_remove_table(cpu_dev);
+		dev_pm_opp_remove_table(cpu_dev);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 6f602c7a71bd..00fda9377d6e 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -430,7 +430,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	return 0;
 
 out_free_opp_table:
-	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
+	dev_pm_opp_cpumask_remove_table(&info->cpus);
 
 out_free_resources:
 	if (!IS_ERR(proc_reg))
@@ -456,7 +456,7 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	if (!IS_ERR(info->inter_clk))
 		clk_put(info->inter_clk);
 
-	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
+	dev_pm_opp_cpumask_remove_table(&info->cpus);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5b6ad31403a5..1907e89b7362 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -66,6 +66,8 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+void dev_pm_opp_remove_table(struct device *dev);
+void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -184,13 +186,19 @@ static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_va
 	return -ENOSYS;
 }
 
+static inline void dev_pm_opp_remove_table(struct device *dev)
+{
+}
+
+static inline void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask)
+{
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
-void dev_pm_opp_of_remove_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask);
-void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
@@ -198,19 +206,11 @@ static inline int dev_pm_opp_of_add_table(struct device *dev)
 	return -EINVAL;
 }
 
-static inline void dev_pm_opp_of_remove_table(struct device *dev)
-{
-}
-
 static inline int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 {
 	return -ENOSYS;
 }
 
-static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
-{
-}
-
 static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	return -ENOSYS;
-- 
1.9.1
