From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/16] PM / OPP: Add dev_pm_opp_set_rate()
Date: Fri, 11 Sep 2015 17:32:11 +0530
Message-ID: <9cae44895bc9d424b10445b959ba91ee60c85867.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
power-supplies and clock source for on an OPP.

The OPP is found by matching against the target_freq passed to the
routine. This shall replace similar code present in most of the OPP
users and help simplify them a lot.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 152 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |   7 ++
 2 files changed, 159 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4ee0911b97ea..9fbc38222ca0 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -523,6 +523,158 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/*
+ * _set_opp_voltages() - Configure device supplies for an OPP
+ * @dev:	device for which we do this operation
+ * @dev_opp:	dev_opp for the device
+ * @opp:	opp for getting supply voltage levels
+ *
+ * This is used to configure all the power supplies, used by the device, to the
+ * voltage levels specified by a particular OPP.
+ */
+static int _set_opp_voltages(struct device *dev, struct device_opp *dev_opp,
+			     struct dev_pm_opp *opp)
+{
+	struct opp_supply *supply;
+	struct regulator *reg;
+	const char *name;
+	int count, ret;
+
+	/* Sum max latencies for all supplies */
+	for (count = 0; count < dev_opp->supply_count; count++) {
+		supply = &opp->supplies[count];
+		reg = dev_opp->regulators[count];
+		name = dev_opp->supply_names[count];
+
+		/* Regulator may not be available for device */
+		if (IS_ERR(reg)) {
+			dev_dbg(dev, "%s: skipping %s regulator: %ld\n",
+				__func__, name, PTR_ERR(reg));
+			continue;
+		}
+
+		dev_dbg(dev, "%s: Supply: %s, voltages (mV): %lu %lu %lu\n",
+			__func__, name, supply->u_volt_min, supply->u_volt,
+			supply->u_volt_max);
+
+		ret = regulator_set_voltage_triplet(reg, supply->u_volt_min,
+						    supply->u_volt,
+						    supply->u_volt_max);
+		if (ret) {
+			dev_err(dev, "%s: failed to set voltage for %s regulator (%lu %lu %lu mV): %d\n",
+				__func__, name, supply->u_volt_min,
+				supply->u_volt, supply->u_volt_max, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * dev_pm_opp_set_rate() - Configure new OPP based on frequency
+ * @dev:	 device for which we do this operation
+ * @target_freq: frequency to achieve
+ *
+ * This configures the power-supplies and clock source to the levels specified
+ * by the OPP corresponding to the target_freq. It takes all necessary locks
+ * required for the operation and the caller doesn't need to care about the rcu
+ * locks.
+ */
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *old_opp, *opp;
+	struct clk *clk;
+	unsigned long freq, old_freq;
+	int ret;
+
+	if (unlikely(!dev || !target_freq)) {
+		pr_err("%s: Invalid arguments dev=%p, freq=%lu\n", __func__,
+		       dev, target_freq);
+		return -EINVAL;
+	}
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		return PTR_ERR(dev_opp);
+	}
+
+	clk = dev_opp->clk;
+	if (IS_ERR(clk)) {
+		dev_err(dev, "%s: No clock available for the device\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	freq = clk_round_rate(clk, target_freq);
+	if ((long)freq <= 0)
+		freq = target_freq;
+
+	old_freq = clk_get_rate(clk);
+
+	/* Return early if nothing to do */
+	if (old_freq == freq) {
+		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
+			__func__, freq);
+		return 0;
+	}
+
+	rcu_read_lock();
+
+	old_opp = dev_pm_opp_find_freq_ceil(dev, &old_freq);
+	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
+			__func__, freq, ret);
+		goto unlock;
+	}
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret = _set_opp_voltages(dev, dev_opp, opp);
+		if (ret)
+			goto restore_voltage;
+	}
+
+	/* Change frequency */
+
+	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n",
+		__func__, old_freq, freq);
+
+	ret = clk_set_rate(clk, freq);
+	if (ret) {
+		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+			ret);
+		goto restore_voltage;
+	}
+
+	/* Scaling down? Scale voltage after frequency */
+	if (freq < old_freq) {
+		ret = _set_opp_voltages(dev, dev_opp, opp);
+		if (ret)
+			goto restore_freq;
+	}
+
+	goto unlock;
+
+restore_freq:
+	if (clk_set_rate(clk, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_voltage:
+	/* This shouldn't harm if the voltages weren't updated earlier */
+	_set_opp_voltages(dev, dev_opp, old_opp);
+unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
+
 /* List-dev Helpers */
 static void _kfree_list_dev_rcu(struct rcu_head *head)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index e8aee03b974a..b0f71c0f333a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -58,6 +58,7 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
 int dev_pm_opp_set_regulator(struct device *dev, const char *id);
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -147,6 +148,12 @@ static inline int dev_pm_opp_set_regulator(struct device *dev, const char *id)
 {
 	return -EINVAL;
 }
+
+static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+{
+	return -EINVAL;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.4.0
