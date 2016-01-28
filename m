From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/16] PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
Date: Thu, 28 Jan 2016 13:50:32 +0530
Message-ID: <81d90b48867dbdbb6e5e9a911de3873bc5ec4d14.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34770 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965162AbcA1IVF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:21:05 -0500
Received: by mail-pf0-f177.google.com with SMTP id o185so15197012pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2016 00:21:02 -0800 (PST)
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

In few use cases (like: cpufreq), it is desired to get the maximum
voltage latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |  6 +++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 71545becfca1..ffe2406af882 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -231,6 +231,65 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
 
 /**
+ * dev_pm_opp_get_max_volt_latency() - Get max voltage latency in nanoseconds
+ * @dev: device for which we do this operation
+ *
+ * Return: This function returns the max voltage latency in nanoseconds.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp;
+	struct regulator *reg;
+	unsigned long latency_ns = 0;
+	unsigned long min_uV = ~0, max_uV = 0;
+	int ret;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	reg = dev_opp->regulator;
+	if (IS_ERR_OR_NULL(reg)) {
+		/* Regulator may not be required for device */
+		if (reg)
+			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
+				PTR_ERR(reg));
+		rcu_read_unlock();
+		return 0;
+	}
+
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+		if (!opp->available)
+			continue;
+
+		if (opp->u_volt_min < min_uV)
+			min_uV = opp->u_volt_min;
+		if (opp->u_volt_max > max_uV)
+			max_uV = opp->u_volt_max;
+	}
+
+	rcu_read_unlock();
+
+	/*
+	 * The caller needs to ensure that dev_opp (and hence the regulator)
+	 * isn't freed, while we are executing this routine.
+	 */
+	ret = regulator_set_voltage_time(reg, min_uV, max_uV);
+	if (ret > 0)
+		latency_ns = ret * 1000;
+
+	return latency_ns;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
+
+/**
  * dev_pm_opp_get_suspend_opp() - Get suspend opp
  * @dev:	device for which we do this operation
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c70a18ac9c8a..5daa43058ac1 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -34,6 +34,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
+unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
@@ -88,6 +89,11 @@ static inline unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
 {
 	return NULL;
-- 
2.7.0.79.gdc08a19

