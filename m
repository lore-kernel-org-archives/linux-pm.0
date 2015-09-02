From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 2/5] PM / OPP: Prefix exported opp routines
 with dev_pm_opp_
Date: Wed, 2 Sep 2015 12:52:38 +0530
Message-ID: <20150902072238.GC22673@linux>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <7c5fd48b6e94fb84f44eb1e79d4518cbf3de6909.1441083292.git.viresh.kumar@linaro.org>
 <20150901190321.GA6123@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35503 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbIBHWn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 03:22:43 -0400
Received: by pacfv12 with SMTP id fv12so2212286pac.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 00:22:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150901190321.GA6123@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

On 01-09-15, 21:03, Pavel Machek wrote:
> Is ..._free_table opposite of ..._init_opp? If so, you might want to
> name them such that it is clear...

Yes, it is opposite of that. Okay, so here is a new patch for this,
lemme know if this looks fine. I will then resend the whole series
again..

@Stephen: Thanks for your reviews, just few more to go (in this
series) :).


Message-Id: <b654f08cfa6d8ed0a6d214e9d4671652aa3842f1.1441178442.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 2 Sep 2015 11:23:44 +0530
Subject: [PATCH 1/3] PM / OPP: Rename opp init/free table routines

free-table routines are opposite of init-table ones, and must be named
to make that clear. Opposite of 'init' is 'exit', but those doesn't suit
really well.

Replace 'init' with 'add' and 'free' with 'remove'.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c       |  2 +-
 drivers/base/power/opp.c             | 41 ++++++++++++++++++------------------
 drivers/cpufreq/arm_big_little.h     |  2 +-
 drivers/cpufreq/arm_big_little_dt.c  |  4 ++--
 drivers/cpufreq/cpufreq-dt.c         |  6 +++---
 drivers/cpufreq/exynos5440-cpufreq.c |  6 +++---
 drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---
 drivers/cpufreq/mt8173-cpufreq.c     |  6 +++---
 include/linux/pm_opp.h               | 16 +++++++-------
 9 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 9602cc12d2f1..3286eec91d92 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -350,7 +350,7 @@ static void __init imx6q_opp_init(void)
 		return;
 	}
 
-	if (of_init_opp_table(cpu_dev)) {
+	if (of_add_opp_table(cpu_dev)) {
 		pr_warn("failed to init OPP table\n");
 		goto put_node;
 	}
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 4741fdc13e83..1515c05bc579 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -800,8 +800,8 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * The opp is made available by default and it can be controlled using
  * dev_pm_opp_enable/disable functions and may be removed by dev_pm_opp_remove.
  *
- * NOTE: "dynamic" parameter impacts OPPs added by the of_init_opp_table and
- * freed by of_free_opp_table.
+ * NOTE: "dynamic" parameter impacts OPPs added by the of_add_opp_table and
+ * freed by of_remove_opp_table.
  *
  * Locking: The internal device_opp and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -1185,7 +1185,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
 #ifdef CONFIG_OF
 /**
- * of_free_opp_table() - Free OPP table entries created from static DT entries
+ * of_remove_opp_table() - Free OPP table entries created from static DT entries
  * @dev:	device pointer used to lookup device OPPs.
  *
  * Free OPPs created using static entries present in DT.
@@ -1196,7 +1196,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-void of_free_opp_table(struct device *dev)
+void of_remove_opp_table(struct device *dev)
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp, *tmp;
@@ -1231,9 +1231,9 @@ void of_free_opp_table(struct device *dev)
 unlock:
 	mutex_unlock(&dev_opp_list_lock);
 }
-EXPORT_SYMBOL_GPL(of_free_opp_table);
+EXPORT_SYMBOL_GPL(of_remove_opp_table);
 
-void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+void of_cpumask_remove_opp_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -1248,10 +1248,10 @@ void of_cpumask_free_opp_table(cpumask_var_t cpumask)
 			continue;
 		}
 
-		of_free_opp_table(cpu_dev);
+		of_remove_opp_table(cpu_dev);
 	}
 }
-EXPORT_SYMBOL_GPL(of_cpumask_free_opp_table);
+EXPORT_SYMBOL_GPL(of_cpumask_remove_opp_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
 static struct device_node *_of_get_opp_desc_node(struct device *dev)
@@ -1267,8 +1267,7 @@ static struct device_node *_of_get_opp_desc_node(struct device *dev)
 }
 
 /* Initializes OPP tables based on new bindings */
-static int _of_init_opp_table_v2(struct device *dev,
-				 struct device_node *opp_np)
+static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 {
 	struct device_node *np;
 	struct device_opp *dev_opp;
@@ -1310,13 +1309,13 @@ static int _of_init_opp_table_v2(struct device *dev,
 	return 0;
 
 free_table:
-	of_free_opp_table(dev);
+	of_remove_opp_table(dev);
 
 	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
-static int _of_init_opp_table_v1(struct device *dev)
+static int _of_add_opp_table_v1(struct device *dev)
 {
 	const struct property *prop;
 	const __be32 *val;
@@ -1353,7 +1352,7 @@ static int _of_init_opp_table_v1(struct device *dev)
 }
 
 /**
- * of_init_opp_table() - Initialize opp table from device tree
+ * of_add_opp_table() - Initialize opp table from device tree
  * @dev:	device pointer used to lookup device OPPs.
  *
  * Register the initial OPP table with the OPP library for given device.
@@ -1375,7 +1374,7 @@ static int _of_init_opp_table_v1(struct device *dev)
  * -ENODATA	when empty 'operating-points' property is found
  * -EINVAL	when invalid entries are found in opp-v2 table
  */
-int of_init_opp_table(struct device *dev)
+int of_add_opp_table(struct device *dev)
 {
 	struct device_node *opp_np;
 	int ret;
@@ -1390,17 +1389,17 @@ int of_init_opp_table(struct device *dev)
 		 * Try old-deprecated bindings for backward compatibility with
 		 * older dtbs.
 		 */
-		return _of_init_opp_table_v1(dev);
+		return _of_add_opp_table_v1(dev);
 	}
 
-	ret = _of_init_opp_table_v2(dev, opp_np);
+	ret = _of_add_opp_table_v2(dev, opp_np);
 	of_node_put(opp_np);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_init_opp_table);
+EXPORT_SYMBOL_GPL(of_add_opp_table);
 
-int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+int of_cpumask_add_opp_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu, ret = 0;
@@ -1415,20 +1414,20 @@ int of_cpumask_init_opp_table(cpumask_var_t cpumask)
 			continue;
 		}
 
-		ret = of_init_opp_table(cpu_dev);
+		ret = of_add_opp_table(cpu_dev);
 		if (ret) {
 			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
 			       __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			of_cpumask_free_opp_table(cpumask);
+			of_cpumask_remove_opp_table(cpumask);
 			break;
 		}
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_cpumask_init_opp_table);
+EXPORT_SYMBOL_GPL(of_cpumask_add_opp_table);
 
 /* Required only for V1 bindings, as v2 can manage it from DT itself */
 int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
index a211f7db9d32..d7ac320ead23 100644
--- a/drivers/cpufreq/arm_big_little.h
+++ b/drivers/cpufreq/arm_big_little.h
@@ -28,7 +28,7 @@ struct cpufreq_arm_bL_ops {
 
 	/*
 	 * This must set opp table for cpu_dev in a similar way as done by
-	 * of_init_opp_table().
+	 * of_add_opp_table().
 	 */
 	int (*init_opp_table)(struct device *cpu_dev);
 
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 36d91dba2965..47ac0ff54e3a 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -54,7 +54,7 @@ static int dt_init_opp_table(struct device *cpu_dev)
 		return -ENOENT;
 	}
 
-	ret = of_init_opp_table(cpu_dev);
+	ret = of_add_opp_table(cpu_dev);
 	of_node_put(np);
 
 	return ret;
@@ -82,7 +82,7 @@ static struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
 	.init_opp_table = dt_init_opp_table,
-	.free_opp_table = of_free_opp_table,
+	.free_opp_table = of_remove_opp_table,
 };
 
 static int generic_bL_probe(struct platform_device *pdev)
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3583cdfadbd..9118a6562644 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -237,7 +237,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 *
 	 * OPPs might be populated at runtime, don't check for error here
 	 */
-	of_cpumask_init_opp_table(policy->cpus);
+	of_cpumask_add_opp_table(policy->cpus);
 
 	if (need_update) {
 		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
@@ -356,7 +356,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	of_cpumask_free_opp_table(policy->cpus);
+	of_cpumask_remove_opp_table(policy->cpus);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -373,7 +373,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	of_cpumask_free_opp_table(policy->related_cpus);
+	of_cpumask_remove_opp_table(policy->related_cpus);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 21a90ed7f3d8..fc46813d3b83 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -360,7 +360,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		goto err_put_node;
 	}
 
-	ret = of_init_opp_table(dvfs_info->dev);
+	ret = of_add_opp_table(dvfs_info->dev);
 	if (ret) {
 		dev_err(dvfs_info->dev, "failed to init OPP table: %d\n", ret);
 		goto err_put_node;
@@ -424,7 +424,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 err_free_table:
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
 err_free_opp:
-	of_free_opp_table(dvfs_info->dev);
+	of_remove_opp_table(dvfs_info->dev);
 err_put_node:
 	of_node_put(np);
 	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
@@ -435,7 +435,7 @@ static int exynos_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&exynos_driver);
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
-	of_free_opp_table(dvfs_info->dev);
+	of_remove_opp_table(dvfs_info->dev);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 380a90d3c57e..3802765aeb9f 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -202,7 +202,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	 */
 	num = dev_pm_opp_get_opp_count(cpu_dev);
 	if (num < 0) {
-		ret = of_init_opp_table(cpu_dev);
+		ret = of_add_opp_table(cpu_dev);
 		if (ret < 0) {
 			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
 			goto put_reg;
@@ -312,7 +312,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_opp:
 	if (free_opp)
-		of_free_opp_table(cpu_dev);
+		of_remove_opp_table(cpu_dev);
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
@@ -340,7 +340,7 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
-		of_free_opp_table(cpu_dev);
+		of_remove_opp_table(cpu_dev);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 49caed293a3b..519e83146e86 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -344,7 +344,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	/* Both presence and absence of sram regulator are valid cases. */
 	sram_reg = regulator_get_exclusive(cpu_dev, "sram");
 
-	ret = of_init_opp_table(cpu_dev);
+	ret = of_add_opp_table(cpu_dev);
 	if (ret) {
 		pr_warn("no OPP table for cpu%d\n", cpu);
 		goto out_free_resources;
@@ -378,7 +378,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	return 0;
 
 out_free_opp_table:
-	of_free_opp_table(cpu_dev);
+	of_remove_opp_table(cpu_dev);
 
 out_free_resources:
 	if (!IS_ERR(proc_reg))
@@ -404,7 +404,7 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	if (!IS_ERR(info->inter_clk))
 		clk_put(info->inter_clk);
 
-	of_free_opp_table(info->cpu_dev);
+	of_remove_opp_table(info->cpu_dev);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cab7ba55bedb..5b6243014f8a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -126,28 +126,28 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-int of_init_opp_table(struct device *dev);
-void of_free_opp_table(struct device *dev);
-int of_cpumask_init_opp_table(cpumask_var_t cpumask);
-void of_cpumask_free_opp_table(cpumask_var_t cpumask);
+int of_add_opp_table(struct device *dev);
+void of_remove_opp_table(struct device *dev);
+int of_cpumask_add_opp_table(cpumask_var_t cpumask);
+void of_cpumask_remove_opp_table(cpumask_var_t cpumask);
 int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
 int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
-static inline int of_init_opp_table(struct device *dev)
+static inline int of_add_opp_table(struct device *dev)
 {
 	return -EINVAL;
 }
 
-static inline void of_free_opp_table(struct device *dev)
+static inline void of_remove_opp_table(struct device *dev)
 {
 }
 
-static inline int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+static inline int of_cpumask_add_opp_table(cpumask_var_t cpumask)
 {
 	return -ENOSYS;
 }
 
-static inline void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+static inline void of_cpumask_remove_opp_table(cpumask_var_t cpumask)
 {
 }
