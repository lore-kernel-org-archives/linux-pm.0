From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/17] PM / OPP: Add dev_pm_opp_set_rate()
Date: Tue, 12 Jan 2016 12:28:32 +0530
Message-ID: <20160112065832.GN1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <5824076a64ad4215cfc63c238e8b8947bc996e87.1450777582.git.viresh.kumar@linaro.org>
 <20160112014010.GM22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33096 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbcALG6h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 01:58:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id cy9so334906367pac.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 22:58:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112014010.GM22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 17:40, Stephen Boyd wrote:
> > +	ret = regulator_set_voltage_triplet(reg, opp->u_volt_min, opp->u_volt,
> 
> This can't be called under an RCU read lock.
> 

> > +	rcu_read_lock();
> 
> This lock is held way too long.
> 

> > +	freq = clk_round_rate(clk, target_freq);
> 
> This can't be called under RCU.
> 
> > +	if ((long)freq <= 0)
> > +		freq = target_freq;
> > +
> > +	old_freq = clk_get_rate(clk);
> 
> Same for this.

Some of these I figured out earlier (after sending the series), and
fixed them by dropping rcu lock at certain points. But the problem is
that we will be using opp/clk/reg here for almost the complete routine
and the lock must be acquired for all the time.

(Untested for now)

-------------------------8<-------------------------

Subject: [PATCH] PM / OPP: Add dev_pm_opp_set_rate()

This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
power-supply and clock source for an OPP.

The OPP is found by matching against the target_freq passed to the
routine. This shall replace similar code present in most of the OPP
users and help simplify them a lot.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 155 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |   6 ++
 2 files changed, 161 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 2b1e8cb3897f..ca6b31ab5c87 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -527,6 +527,161 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+static int _set_opp_voltage(struct device *dev, struct regulator *reg,
+			    unsigned long u_volt, unsigned long u_volt_min,
+			    unsigned long u_volt_max)
+{
+	int ret;
+
+	/* Regulator not be available for device */
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
+ * Locking: This function internally uses mutex locks to keep the integrity of
+ * the internal data structures. Callers should ensure that this function is
+ * *NOT* called under RCU protection or in contexts where mutex cannot be
+ * locked.
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
+	/*
+	 * Hold our list modification lock here as clk/regulator routines called
+	 * below can possibly take another mutex, which isn't allowed within rcu
+	 * locks.
+	 */
+	mutex_lock(&dev_opp_list_lock);
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
+	reg = dev_opp->regulator;
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
+	u_volt = opp->u_volt;
+	u_volt_min = opp->u_volt_min;
+	u_volt_max = opp->u_volt_max;
+
+	ou_volt = old_opp->u_volt;
+	ou_volt_min = old_opp->u_volt_min;
+	ou_volt_max = old_opp->u_volt_max;
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
+	mutex_unlock(&dev_opp_list_lock);
+
+	return 0;
+
+restore_freq:
+	if (clk_set_rate(clk, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_voltage:
+	/* This shouldn't harm if the voltages weren't updated earlier */
+	_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
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
viresh
