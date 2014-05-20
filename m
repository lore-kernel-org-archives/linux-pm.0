From: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC 1/2] PM / OPP: allow to use voltage ranges
Date: Tue, 20 May 2014 16:27:39 +0200
Message-ID: <1400596060-5330-2-git-send-email-l.stach@pengutronix.de>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34042 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbaETO1q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 10:27:46 -0400
In-Reply-To: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>

In many cases we don't have a strict one to one relation
between a frequency and a voltage, but rather an operating
frequency plus a voltage range that need to be maintained
for this one frequency.

This patch does not change any behavior, but only expands
the API to cope with voltage ranges.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-omap2/opp.c            |  3 ++-
 arch/arm/mach-omap2/pm.c             |  2 +-
 arch/arm/mach-vexpress/spc.c         |  3 ++-
 drivers/base/power/opp.c             | 32 ++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq-cpu0.c       |  6 +++---
 drivers/cpufreq/exynos5440-cpufreq.c |  2 +-
 drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---
 drivers/cpufreq/omap-cpufreq.c       |  2 +-
 drivers/devfreq/exynos/exynos4_bus.c | 12 +++++++++---
 drivers/devfreq/exynos/exynos5_bus.c |  8 +++++---
 include/linux/pm_opp.h               | 19 +++++++++++++++----
 11 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index a358a07e18f2..bdd4f7fe7329 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -85,7 +85,8 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 			dev = &oh->od->pdev->dev;
 		}
 
-		r = dev_pm_opp_add(dev, opp_def->freq, opp_def->u_volt);
+		r = dev_pm_opp_add(dev, opp_def->freq, opp_def->u_volt,
+				   opp_def->u_volt, opp_def->u_volt);
 		if (r) {
 			dev_err(dev, "%s: add OPP %ld failed for %s [%d] result=%d\n",
 				__func__, opp_def->freq,
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e1b41416fbf1..761e530d835b 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -180,7 +180,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 		goto exit;
 	}
 
-	bootup_volt = dev_pm_opp_get_voltage(opp);
+	bootup_volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 	if (!bootup_volt) {
 		pr_err("%s: unable to find voltage corresponding to the bootup OPP for vdd_%s\n",
diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index c26ef5b92ca7..bd32b3ee1111 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -431,7 +431,8 @@ static int ve_init_opp_table(struct device *cpu_dev)
 	struct ve_spc_opp *opps = info->opps[cluster];
 
 	for (idx = 0; idx < max_opp; idx++, opps++) {
-		ret = dev_pm_opp_add(cpu_dev, opps->freq * 1000, opps->u_volt);
+		ret = dev_pm_opp_add(cpu_dev, opps->freq * 1000, opps->u_volt,
+				     opps->u_volt, opps->u_volt);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opp %lu %lu\n",
 				 opps->freq, opps->u_volt);
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 25538675d59e..e738a37df915 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -63,7 +63,7 @@ struct dev_pm_opp {
 
 	bool available;
 	unsigned long rate;
-	unsigned long u_volt;
+	unsigned long u_volt_min, u_volt_nominal, u_volt_max;
 
 	struct device_opp *dev_opp;
 	struct rcu_head head;
@@ -149,16 +149,28 @@ static struct device_opp *find_device_opp(struct device *dev)
  * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
  * pointer.
  */
-unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
+unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp,
+				     enum dev_pm_opp_voltage_type type)
 {
 	struct dev_pm_opp *tmp_opp;
 	unsigned long v = 0;
 
 	tmp_opp = rcu_dereference(opp);
-	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
+	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available) {
 		pr_err("%s: Invalid parameters\n", __func__);
-	else
-		v = tmp_opp->u_volt;
+	} else {
+		switch (type) {
+		case OPP_VOLTAGE_MIN:
+			v = tmp_opp->u_volt_min;
+			break;
+		case OPP_VOLTAGE_NOMINAL:
+			v = tmp_opp->u_volt_nominal;
+			break;
+		case OPP_VOLTAGE_MAX:
+			v = tmp_opp->u_volt_max;
+			break;
+		}
+	}
 
 	return v;
 }
@@ -395,7 +407,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+int dev_pm_opp_add(struct device *dev, unsigned long freq,
+		   unsigned long u_volt_min, unsigned long u_volt_nominal,
+		   unsigned long u_volt_max)
 {
 	struct device_opp *dev_opp = NULL;
 	struct dev_pm_opp *opp, *new_opp;
@@ -440,7 +454,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	/* populate the opp table */
 	new_opp->dev_opp = dev_opp;
 	new_opp->rate = freq;
-	new_opp->u_volt = u_volt;
+	new_opp->u_volt_min = u_volt_min;
+	new_opp->u_volt_nominal = u_volt_nominal;
+	new_opp->u_volt_max = u_volt_max;
 	new_opp->available = true;
 
 	/* Insert new OPP in order of increasing frequency */
@@ -734,7 +750,7 @@ int of_init_opp_table(struct device *dev)
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		if (dev_pm_opp_add(dev, freq, volt)) {
+		if (dev_pm_opp_add(dev, freq, volt, volt, volt)) {
 			dev_warn(dev, "%s: Failed to add OPP %ld\n",
 				 __func__, freq);
 			continue;
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 1bf6bbac3e03..6678860ac1a9 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -58,7 +58,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 			pr_err("failed to find OPP for %ld\n", freq_Hz);
 			return PTR_ERR(opp);
 		}
-		volt = dev_pm_opp_get_voltage(opp);
+		volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 		rcu_read_unlock();
 		tol = volt * voltage_tolerance / 100;
 		volt_old = regulator_get_voltage(cpu_reg);
@@ -184,10 +184,10 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_exact(cpu_dev,
 				freq_table[0].frequency * 1000, true);
-		min_uV = dev_pm_opp_get_voltage(opp);
+		min_uV = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 		opp = dev_pm_opp_find_freq_exact(cpu_dev,
 				freq_table[i-1].frequency * 1000, true);
-		max_uV = dev_pm_opp_get_voltage(opp);
+		max_uV = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 		rcu_read_unlock();
 		ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
 		if (ret > 0)
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index a6b8214d7b77..c223c9bbbb35 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -141,7 +141,7 @@ static int init_div_table(void)
 					<< P0_7_CSCLKDEV_SHIFT;
 
 		/* Calculate EMA */
-		volt_id = dev_pm_opp_get_voltage(opp);
+		volt_id = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 		volt_id = (MAX_VOLTAGE - volt_id) / VOLTAGE_STEP;
 		if (volt_id < PMIC_HIGH_VOLT) {
 			ema_div = (CPUEMA_HIGH << P0_7_CPUEMA_SHIFT) |
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e27fca86fe4f..91bf75df25fd 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -57,7 +57,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 		return PTR_ERR(opp);
 	}
 
-	volt = dev_pm_opp_get_voltage(opp);
+	volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 	volt_old = regulator_get_voltage(arm_reg);
 
@@ -281,10 +281,10 @@ soc_opp_out:
 	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_exact(cpu_dev,
 				  freq_table[0].frequency * 1000, true);
-	min_volt = dev_pm_opp_get_voltage(opp);
+	min_volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	opp = dev_pm_opp_find_freq_exact(cpu_dev,
 				  freq_table[--num].frequency * 1000, true);
-	max_volt = dev_pm_opp_get_voltage(opp);
+	max_volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 	ret = regulator_set_voltage_time(arm_reg, min_volt, max_volt);
 	if (ret > 0)
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5f69c9aa703c..f1390e6d596f 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -68,7 +68,7 @@ static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 				__func__, new_freq);
 			return -EINVAL;
 		}
-		volt = dev_pm_opp_get_voltage(opp);
+		volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 		rcu_read_unlock();
 		tol = volt * OPP_TOLERANCE / 100;
 		volt_old = regulator_get_voltage(mpu_reg);
diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index e07b0c68c715..17fc2031509a 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -651,7 +651,7 @@ static int exynos4_bus_target(struct device *dev, unsigned long *_freq,
 		return PTR_ERR(opp);
 	}
 	new_oppinfo.rate = dev_pm_opp_get_freq(opp);
-	new_oppinfo.volt = dev_pm_opp_get_voltage(opp);
+	new_oppinfo.volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 	freq = new_oppinfo.rate;
 
@@ -874,6 +874,8 @@ static int exynos4210_init_tables(struct busfreq_data *data)
 
 	for (i = LV_0; i < EX4210_LV_NUM; i++) {
 		err = dev_pm_opp_add(data->dev, exynos4210_busclk_table[i].clk,
+			      exynos4210_busclk_table[i].volt,
+			      exynos4210_busclk_table[i].volt,
 			      exynos4210_busclk_table[i].volt);
 		if (err) {
 			dev_err(data->dev, "Cannot add opp entries.\n");
@@ -941,6 +943,8 @@ static int exynos4x12_init_tables(struct busfreq_data *data)
 
 	for (i = 0; i < EX4x12_LV_NUM; i++) {
 		ret = dev_pm_opp_add(data->dev, exynos4x12_mifclk_table[i].clk,
+			      exynos4x12_mifclk_table[i].volt,
+			      exynos4x12_mifclk_table[i].volt,
 			      exynos4x12_mifclk_table[i].volt);
 		if (ret) {
 			dev_err(data->dev, "Fail to add opp entries.\n");
@@ -978,7 +982,8 @@ static int exynos4_busfreq_pm_notifier_event(struct notifier_block *this,
 			return PTR_ERR(opp);
 		}
 		new_oppinfo.rate = dev_pm_opp_get_freq(opp);
-		new_oppinfo.volt = dev_pm_opp_get_voltage(opp);
+		new_oppinfo.volt = dev_pm_opp_get_voltage(opp,
+					OPP_VOLTAGE_NOMINAL);
 		rcu_read_unlock();
 
 		err = exynos4_bus_setvolt(data, &new_oppinfo,
@@ -1074,7 +1079,8 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(opp);
 	}
 	data->curr_oppinfo.rate = dev_pm_opp_get_freq(opp);
-	data->curr_oppinfo.volt = dev_pm_opp_get_voltage(opp);
+	data->curr_oppinfo.volt = dev_pm_opp_get_voltage(opp,
+					OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 6eef1f7397c6..ab8a49e0b770 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -144,7 +144,7 @@ static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
 	}
 
 	freq = dev_pm_opp_get_freq(opp);
-	volt = dev_pm_opp_get_voltage(opp);
+	volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 
 	old_freq = data->curr_freq;
@@ -246,6 +246,8 @@ static int exynos5250_init_int_tables(struct busfreq_data_int *data)
 
 	for (i = LV_0; i < _LV_END; i++) {
 		err = dev_pm_opp_add(data->dev, exynos5_int_opp_table[i].clk,
+				exynos5_int_opp_table[i].volt,
+				exynos5_int_opp_table[i].volt,
 				exynos5_int_opp_table[i].volt);
 		if (err) {
 			dev_err(data->dev, "Cannot add opp entries.\n");
@@ -282,7 +284,7 @@ static int exynos5_busfreq_int_pm_notifier_event(struct notifier_block *this,
 			goto unlock;
 		}
 		freq = dev_pm_opp_get_freq(opp);
-		volt = dev_pm_opp_get_voltage(opp);
+		volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 		rcu_read_unlock();
 
 		err = exynos5_int_setvolt(data, volt);
@@ -374,7 +376,7 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 		return PTR_ERR(opp);
 	}
 	initial_freq = dev_pm_opp_get_freq(opp);
-	initial_volt = dev_pm_opp_get_voltage(opp);
+	initial_volt = dev_pm_opp_get_voltage(opp, OPP_VOLTAGE_NOMINAL);
 	rcu_read_unlock();
 	data->curr_freq = initial_freq;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5151b0059585..308902606caa 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -25,9 +25,16 @@ enum dev_pm_opp_event {
 	OPP_EVENT_ADD, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
 };
 
+enum dev_pm_opp_voltage_type {
+	OPP_VOLTAGE_MIN,
+	OPP_VOLTAGE_NOMINAL,
+	OPP_VOLTAGE_MAX,
+};
+
 #if defined(CONFIG_PM_OPP)
 
-unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
+unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp,
+				     enum dev_pm_opp_voltage_type type);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
@@ -44,7 +51,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
 
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
-		   unsigned long u_volt);
+		   unsigned long u_volt_min, unsigned long u_volt_nominal,
+		   unsigned long u_volt_max);
 
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
@@ -52,7 +60,8 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
 #else
-static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
+static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp,
+					enum dev_pm_opp_voltage_type type)
 {
 	return 0;
 }
@@ -86,7 +95,9 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 }
 
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
-					unsigned long u_volt)
+					unsigned long u_volt_min,
+					unsigned long u_volt_nominal,
+					unsigned long u_volt_max)
 {
 	return -EINVAL;
 }
-- 
2.0.0.rc0

