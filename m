From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Wed, 30 Nov 2016 09:29:39 +0530
Message-ID: <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Joonyoung Shim reported an interesting problem on his ARM octa-core
Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
was failing for a struct device for which dev_pm_opp_set_regulator() is
called earlier.

This happened because an earlier call to
dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
removed all the entries from opp_table->dev_list apart from the last CPU
device in the cpumask of CPUs sharing the OPP.

But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
routines get CPU device for the first CPU in the cpumask. And so the OPP
core failed to find the OPP table for the struct device.

In order to fix that up properly, we need to revisit APIs like
dev_pm_opp_set_regulator() and make them talk in terms of cookies
provided by the OPP core. But such a solution will be hard to backport
to stable kernels.

This patch attempts to fix this problem by returning a pointer to the
opp_table from dev_pm_opp_set_regulator() and using that as the
parameter to dev_pm_opp_put_regulator(). This ensures that the
dev_pm_opp_put_regulator() doesn't fail to find the opp table.

Note that similar design problem also exists with other
dev_pm_opp_put_*() APIs, but those aren't used currently by anyone and
so we don't need to update them for now.

[Viresh]: Written commit log, minor improvements in the patch and tested
on exynos 5250.

Cc: # v4.4+ <stable@vger.kernel.org>
Reported-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- Completely different approach, suggested earlier by Stephen.
- Can be merged safely now as both /me and Stephen agree to this one.

@Joonyoung: Can you please test this last patch please ?

 drivers/base/power/opp/core.c | 37 +++++++++++++------------------------
 drivers/cpufreq/cpufreq-dt.c  | 12 ++++++++----
 include/linux/pm_opp.h        | 11 ++++++-----
 3 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..de27562d9ced 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1316,58 +1316,57 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name)
 {
 	struct opp_table *opp_table;
 	struct regulator *reg;
-	int ret;
 
 	mutex_lock(&opp_table_lock);
 
 	opp_table = _add_opp_table(dev);
 	if (!opp_table) {
-		ret = -ENOMEM;
+		opp_table = ERR_PTR(-ENOMEM);
 		goto unlock;
 	}
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
+		opp_table = ERR_PTR(-EBUSY);
 		goto err;
 	}
 
 	/* Already have a regulator set */
 	if (WARN_ON(!IS_ERR(opp_table->regulator))) {
-		ret = -EBUSY;
+		opp_table = ERR_PTR(-EBUSY);
 		goto err;
 	}
 	/* Allocate the regulator */
 	reg = regulator_get_optional(dev, name);
 	if (IS_ERR(reg)) {
-		ret = PTR_ERR(reg);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "%s: no regulator (%s) found: %d\n",
-				__func__, name, ret);
+		opp_table = (struct opp_table *)reg;
+		if (PTR_ERR(reg) != -EPROBE_DEFER)
+			dev_err(dev, "%s: no regulator (%s) found: %ld\n",
+				__func__, name, PTR_ERR(reg));
 		goto err;
 	}
 
 	opp_table->regulator = reg;
 
 	mutex_unlock(&opp_table_lock);
-	return 0;
+	return opp_table;
 
 err:
 	_remove_opp_table(opp_table);
 unlock:
 	mutex_unlock(&opp_table_lock);
 
-	return ret;
+	return opp_table;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
 
 /**
  * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
- * @dev: Device for which regulator was set.
+ * @opp_table: opp_table returned from dev_pm_opp_set_regulator
  *
  * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -1375,22 +1374,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-void dev_pm_opp_put_regulator(struct device *dev)
+void dev_pm_opp_put_regulator(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
 	mutex_lock(&opp_table_lock);
 
-	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to find opp_table: %ld\n",
-			PTR_ERR(opp_table));
-		goto unlock;
-	}
-
 	if (IS_ERR(opp_table->regulator)) {
-		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
+		pr_err("%s: Doesn't have regulator set\n", __func__);
 		goto unlock;
 	}
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 5c07ae05d69a..4d3ec92cbabf 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -28,6 +28,7 @@
 #include "cpufreq-dt.h"
 
 struct private_data {
+	struct opp_table *opp_table;
 	struct device *cpu_dev;
 	struct thermal_cooling_device *cdev;
 	const char *reg_name;
@@ -143,6 +144,7 @@ static int resources_available(void)
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
+	struct opp_table *opp_table = NULL;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
@@ -186,8 +188,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	name = find_supply_name(cpu_dev);
 	if (name) {
-		ret = dev_pm_opp_set_regulator(cpu_dev, name);
-		if (ret) {
+		opp_table = dev_pm_opp_set_regulator(cpu_dev, name);
+		if (IS_ERR(opp_table)) {
+			ret = PTR_ERR(opp_table);
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
 			goto out_put_clk;
@@ -237,6 +240,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->reg_name = name;
+	priv->opp_table = opp_table;
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
@@ -285,7 +289,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
-		dev_pm_opp_put_regulator(cpu_dev);
+		dev_pm_opp_put_regulator(opp_table);
 out_put_clk:
 	clk_put(cpu_clk);
 
@@ -300,7 +304,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
-		dev_pm_opp_put_regulator(priv->cpu_dev);
+		dev_pm_opp_put_regulator(priv->opp_table);
 
 	clk_put(policy->clk);
 	kfree(priv);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index bca26157f5b6..f6bc76501912 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -19,6 +19,7 @@
 
 struct dev_pm_opp;
 struct device;
+struct opp_table;
 
 enum dev_pm_opp_event {
 	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
@@ -62,8 +63,8 @@ int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 void dev_pm_opp_put_supported_hw(struct device *dev);
 int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
-int dev_pm_opp_set_regulator(struct device *dev, const char *name);
-void dev_pm_opp_put_regulator(struct device *dev);
+struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name);
+void dev_pm_opp_put_regulator(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -170,12 +171,12 @@ static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 
 static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
 
-static inline int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+static inline struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name)
 {
-	return -ENOTSUPP;
+	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_put_regulator(struct device *dev) {}
+static inline void dev_pm_opp_put_regulator(struct opp_table *opp_table) {}
 
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-- 
2.7.1.410.g6faf27b
