From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/17] PM / OPP: Add dev_pm_opp_set_rate()
Date: Tue, 22 Dec 2015 15:46:09 +0530
Message-ID: <5824076a64ad4215cfc63c238e8b8947bc996e87.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36179 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKQw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:16:52 -0500
Received: by mail-pf0-f171.google.com with SMTP id o64so104284889pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:16:52 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
power-supply and clock source for an OPP.

The OPP is found by matching against the target_freq passed to the
routine. This shall replace similar code present in most of the OPP
users and help simplify them a lot.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 142 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |   6 ++
 2 files changed, 148 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 1d1b0faa825d..c76818f69f14 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -517,6 +517,148 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/*
+ * _set_opp_voltage() - Configure device supply for an OPP
+ * @dev:	device for which we do this operation
+ * @dev_opp:	dev_opp for the device
+ * @opp:	opp for getting supply voltage levels
+ *
+ * This is used to configure the power supply, used by the device, to the
+ * voltage levels specified by a particular OPP.
+ */
+static int _set_opp_voltage(struct device *dev, struct device_opp *dev_opp,
+			    struct dev_pm_opp *opp)
+{
+	struct regulator *reg = dev_opp->regulator;
+	int ret;
+
+	/* Regulator not be available for device */
+	if (IS_ERR(reg)) {
+		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
+			PTR_ERR(reg));
+		return 0;
+	}
+
+	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+		opp->u_volt_min, opp->u_volt, opp->u_volt_max);
+
+	ret = regulator_set_voltage_triplet(reg, opp->u_volt_min, opp->u_volt,
+					    opp->u_volt_max);
+	if (ret)
+		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+			__func__, opp->u_volt_min, opp->u_volt, opp->u_volt_max,
+			ret);
+
+	return ret;
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
+	if (unlikely(!target_freq)) {
+		dev_err(dev, "%s: Invalid target frequemncy %lu\n", __func__,
+			target_freq);
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		ret = PTR_ERR(dev_opp);
+		goto unlock;
+	}
+
+	clk = dev_opp->clk;
+	if (IS_ERR(clk)) {
+		dev_err(dev, "%s: No clock available for the device\n",
+			__func__);
+		ret = -EINVAL;
+		goto unlock;
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
+		ret = 0;
+		goto unlock;
+	}
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
+		ret = _set_opp_voltage(dev, dev_opp, opp);
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
+		ret = _set_opp_voltage(dev, dev_opp, opp);
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
+	_set_opp_voltage(dev, dev_opp, old_opp);
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
index 59da3d9e11ea..cccaf4a29e9f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -64,6 +64,7 @@ int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
 int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -172,6 +173,11 @@ static inline int dev_pm_opp_set_regulator(struct device *dev, const char *name)
 
 static inline void dev_pm_opp_put_regulator(struct device *dev) {}
 
+static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+{
+	return -EINVAL;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.7.0.rc1.186.g94414c4

