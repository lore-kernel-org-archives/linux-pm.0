From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/6] PM / OPP: Prefix exported opp routines with dev_pm_opp_
Date: Mon, 10 Aug 2015 12:01:59 +0530
Message-ID: <d1519381968d3cda4440c3240954b890aaac7601.1439187821.git.viresh.kumar@linaro.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1439187821.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439187821.git.viresh.kumar@linaro.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

That's the naming convention followed in most of opp core, but few
recent additions didn't follow this, fix them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c     | 18 +++++++++---------
 drivers/cpufreq/cpufreq-dt.c | 10 +++++-----
 include/linux/pm_opp.h       | 16 ++++++++--------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index c9747fb192b1..677457409245 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1230,7 +1230,7 @@ void of_free_opp_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_free_opp_table);
 
-void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+void dev_pm_opp_cpumask_free_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -1248,7 +1248,7 @@ void of_cpumask_free_opp_table(cpumask_var_t cpumask)
 		of_free_opp_table(cpu_dev);
 	}
 }
-EXPORT_SYMBOL_GPL(of_cpumask_free_opp_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_free_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
 static struct device_node *_of_get_opp_desc_node(struct device *dev)
@@ -1397,7 +1397,7 @@ int of_init_opp_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 
-int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+int dev_pm_opp_cpumask_init_opp(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
 	int cpu, ret = 0;
@@ -1418,17 +1418,17 @@ int of_cpumask_init_opp_table(cpumask_var_t cpumask)
 			       __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			of_cpumask_free_opp_table(cpumask);
+			dev_pm_opp_cpumask_free_table(cpumask);
 			break;
 		}
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_cpumask_init_opp_table);
+EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_init_opp);
 
 /* Required only for V1 bindings, as v2 can manage it from DT itself */
-int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	struct device_list_opp *list_dev;
 	struct device_opp *dev_opp;
@@ -1466,7 +1466,7 @@ int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(set_cpus_sharing_opps);
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
 /*
  * Works only for OPP v2 bindings.
@@ -1474,7 +1474,7 @@ EXPORT_SYMBOL_GPL(set_cpus_sharing_opps);
  * cpumask should be already set to mask of cpu_dev->id.
  * Returns -ENOENT if operating-points-v2 bindings aren't supported.
  */
-int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
 	struct device_node *np, *tmp_np;
 	struct device *tcpu_dev;
@@ -1524,5 +1524,5 @@ int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
 	of_node_put(np);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_get_cpus_sharing_opps);
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_sharing_cpus);
 #endif
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3583cdfadbd..025e76efdec3 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -215,7 +215,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
-	ret = of_get_cpus_sharing_opps(cpu_dev, policy->cpus);
+	ret = dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
 		/*
 		 * operating-points-v2 not supported, fallback to old method of
@@ -237,7 +237,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 *
 	 * OPPs might be populated at runtime, don't check for error here
 	 */
-	of_cpumask_init_opp_table(policy->cpus);
+	dev_pm_opp_cpumask_init_opp(policy->cpus);
 
 	if (need_update) {
 		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
@@ -249,7 +249,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		 * OPP tables are initialized only for policy->cpu, do it for
 		 * others as well.
 		 */
-		set_cpus_sharing_opps(cpu_dev, policy->cpus);
+		dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
 
 		of_property_read_u32(np, "clock-latency", &transition_latency);
 	} else {
@@ -356,7 +356,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	of_cpumask_free_opp_table(policy->cpus);
+	dev_pm_opp_cpumask_free_table(policy->cpus);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -373,7 +373,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	of_cpumask_free_opp_table(policy->related_cpus);
+	dev_pm_opp_cpumask_free_table(policy->related_cpus);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cab7ba55bedb..076e0309f206 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -128,10 +128,10 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int of_init_opp_table(struct device *dev);
 void of_free_opp_table(struct device *dev);
-int of_cpumask_init_opp_table(cpumask_var_t cpumask);
-void of_cpumask_free_opp_table(cpumask_var_t cpumask);
-int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
-int set_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_cpumask_init_opp(cpumask_var_t cpumask);
+void dev_pm_opp_cpumask_free_table(cpumask_var_t cpumask);
+int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
 static inline int of_init_opp_table(struct device *dev)
 {
@@ -142,21 +142,21 @@ static inline void of_free_opp_table(struct device *dev)
 {
 }
 
-static inline int of_cpumask_init_opp_table(cpumask_var_t cpumask)
+static inline int dev_pm_opp_cpumask_init_opp(cpumask_var_t cpumask)
 {
 	return -ENOSYS;
 }
 
-static inline void of_cpumask_free_opp_table(cpumask_var_t cpumask)
+static inline void dev_pm_opp_cpumask_free_table(cpumask_var_t cpumask)
 {
 }
 
-static inline int of_get_cpus_sharing_opps(struct device *cpu_dev, cpumask_var_t cpumask)
+static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
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
