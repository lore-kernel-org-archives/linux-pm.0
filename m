From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/16] PM / OPP: Add dev_pm_opp_set_rate()
Date: Tue, 2 Feb 2016 09:08:56 +0530
Message-ID: <20160202033856.GB31828@vireshk>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <9151a47d7235855032be559372398edf809fe52b.1453965717.git.viresh.kumar@linaro.org>
 <20160202021046.GH4848@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35389 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcBBDjA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 22:39:00 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so95142181pfd.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2016 19:39:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160202021046.GH4848@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 01-02-16, 18:10, Stephen Boyd wrote:
> clk = ERR_CAST(dev_opp);
> 
> not available?
> 
> Why is current capitalized?
> 
> The error gotos above this don't have rcu lock held, so this is
> sometimes wrong to do.

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 4 Sep 2015 12:28:39 +0530
Subject: [PATCH] PM / OPP: Add dev_pm_opp_set_rate()

This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
power-supply and clock source for an OPP.

The OPP is found by matching against the target_freq passed to the
routine. This shall replace similar code present in most of the OPP
users and help simplify them a lot.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 176 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |   6 ++
 2 files changed, 182 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7d7749ce1ce4..ab711c2c3e00 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -529,6 +529,182 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/*
+ * The caller needs to ensure that device_opp (and hence the clk) isn't freed,
+ * while clk returned here is used.
+ */
+static struct clk *_get_opp_clk(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct clk *clk;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		clk = ERR_CAST(dev_opp);
+		goto unlock;
+	}
+
+	clk = dev_opp->clk;
+	if (IS_ERR(clk))
+		dev_err(dev, "%s: No clock available for the device\n",
+			__func__);
+
+unlock:
+	rcu_read_unlock();
+	return clk;
+}
+
+static int _set_opp_voltage(struct device *dev, struct regulator *reg,
+			    unsigned long u_volt, unsigned long u_volt_min,
+			    unsigned long u_volt_max)
+{
+	int ret;
+
+	/* Regulator not available for device */
+	if (IS_ERR(reg)) {
+		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
+			PTR_ERR(reg));
+		return 0;
+	}
+
+	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__, u_volt_min,
+		u_volt, u_volt_max);
+
+	ret = regulator_set_voltage_triplet(reg, u_volt_min, u_volt,
+					    u_volt_max);
+	if (ret)
+		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+			__func__, u_volt_min, u_volt, u_volt_max, ret);
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
+ * by the OPP corresponding to the target_freq.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *old_opp, *opp;
+	struct regulator *reg;
+	struct clk *clk;
+	unsigned long freq, old_freq;
+	unsigned long u_volt, u_volt_min, u_volt_max;
+	unsigned long ou_volt, ou_volt_min, ou_volt_max;
+	int ret;
+
+	if (unlikely(!target_freq)) {
+		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
+			target_freq);
+		return -EINVAL;
+	}
+
+	clk = _get_opp_clk(dev);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
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
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		rcu_read_unlock();
+		return PTR_ERR(dev_opp);
+	}
+
+	old_opp = dev_pm_opp_find_freq_ceil(dev, &old_freq);
+	if (!IS_ERR(old_opp)) {
+		ou_volt = old_opp->u_volt;
+		ou_volt_min = old_opp->u_volt_min;
+		ou_volt_max = old_opp->u_volt_max;
+	} else {
+		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
+			__func__, old_freq, PTR_ERR(old_opp));
+	}
+
+	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
+			__func__, freq, ret);
+		rcu_read_unlock();
+		return ret;
+	}
+
+	u_volt = opp->u_volt;
+	u_volt_min = opp->u_volt_min;
+	u_volt_max = opp->u_volt_max;
+
+	reg = dev_opp->regulator;
+
+	rcu_read_unlock();
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
+				       u_volt_max);
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
+		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
+				       u_volt_max);
+		if (ret)
+			goto restore_freq;
+	}
+
+	return 0;
+
+restore_freq:
+	if (clk_set_rate(clk, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_voltage:
+	/* This shouldn't harm even if the voltages weren't updated earlier */
+	if (!IS_ERR(old_opp))
+		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
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
