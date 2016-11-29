From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev
 list
Date: Mon, 28 Nov 2016 18:46:47 -0800
Message-ID: <20161129024647.GY6095@codeaurora.org>
References: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754981AbcK2Cqv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 21:46:51 -0500
Content-Disposition: inline
In-Reply-To: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 11/25, Viresh Kumar wrote:
> Joonyoung Shim reported an interesting problem on his ARM octa-core
> Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> was failing for a struct device for which dev_pm_opp_set_regulator() is
> called earlier.
> 
> This happened because an earlier call to
> dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> removed all the entries from opp_table->dev_list apart from the last CPU
> device in the cpumask of CPUs sharing the OPP.
> 
> But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> routines get CPU device for the first CPU in the cpumask. And so the OPP
> core failed to find the OPP table for the struct device.
> 
> This patch attempts to fix this problem by adding another field in the
> struct opp_device: inactive.
> 
> Instead of removing the entries from the list during
> dev_pm_opp_of_cpumask_remove_table() function call, we mark them as
> inactive. Such inactive devices will not be used by the core in most of
> the cases, like before, but will be used only at special places which
> need to take inactive devices into account.
> 
> All the devices are removed from the list together now and that happens
> only when the opp_table gets destroyed.
> 
> This patch is tested on Dual A15, Exynos5250 platform by compiling the
> cpufreq-dt driver as a module. The module is inserted/removed multiple
> times with combinations of CPU offline/online steps.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c    | 156 ++++++++++++++++++++++++++-------------
>  drivers/base/power/opp/cpu.c     |   4 +-
>  drivers/base/power/opp/debugfs.c |   4 +-
>  drivers/base/power/opp/of.c      |   2 +-
>  drivers/base/power/opp/opp.h     |   6 +-
>  5 files changed, 116 insertions(+), 56 deletions(-)

That's a lot of lines for something that we want to backport to
stable kernels!

The whole dev_list design seems fairly broken to me. Another
solution would be to iterate the cpumask in reverse, but there
doesn't seem to be a construct for that and adding one is
probably not worth the effort.

Adding yet another member to the structure and doing accounting
in different places seems to be papering over the problem as
well. Now we want to have "inactive" devices in the list? That
seems like a problem for cpufreq to solve. It can decide to not
call OPP APIs when the cpu device isn't actually physically
removed if it wants to.

It also exposes the OPP API's strong reliance on struct device
for everything. Really we shouldn't be storing device pointers in
the OPP core at all because we're not treating them like the
reference counted objects they are. The dev_list should go
probably go away and be replaced with some sort of counter. It
would also be nice if struct device had a pointer to the OPP
table(s) for a device so the lookup is direct.

BTW, _dev_pm_opp_remove_table() calls _find_opp_dev() twice, once
to find the opp_table for a device and then to find the
opp_device inside the table that was used to match up the table
in the first place. Madness!

Anyway, rant over, how about handing out the opp table pointer to
the caller so they can pass it back in when they call the put
side? That should fix the same problem if I understand correctly.

We should think about changing the API further so that callers
have to "get" the OPP table cookie for their device and then pass
that pointer to the dev_pm_*_set() APIs instead of passing a
struct device pointer. That would save lots of cycles searching
for something we already had.

 drivers/base/power/opp/core.c | 23 +++++++----------------
 drivers/cpufreq/cpufreq-dt.c  | 12 ++++++++----
 include/linux/pm_opp.h        | 12 +++++++-----
 3 files changed, 22 insertions(+), 25 deletions(-)

And the diff is 1/5 and negative.

----8<----
diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..4a1ebec88ddd 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1316,7 +1316,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name)
 {
 	struct opp_table *opp_table;
 	struct regulator *reg;
@@ -1354,20 +1354,21 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name)
 	opp_table->regulator = reg;
 
 	mutex_unlock(&opp_table_lock);
-	return 0;
+	return opp_table;
 
 err:
 	_remove_opp_table(opp_table);
+	opp_table = ERR_PTR(ret);
 unlock:
 	mutex_unlock(&opp_table_lock);
 
-	return ret;
+	return opp_table;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
 
 /**
  * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
- * @dev: Device for which regulator was set.
+ * @dev: opp_table returned from dev_pm_opp_set_regulator
  *
  * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -1375,22 +1376,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
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
index bca26157f5b6..a2066abb2a35 100644
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
@@ -170,12 +171,13 @@ static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 
 static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
 
-static inline int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+static inline struct opp_table *
+dev_pm_opp_set_regulator(struct device *dev, const char *name)
 {
-	return -ENOTSUPP;
+	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_put_regulator(struct device *dev) {}
+static inline void dev_pm_opp_put_regulator(struct opp_table *opp_table) {}
 
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
