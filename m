From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Tue, 12 Jan 2016 10:40:58 +0530
Message-ID: <20160112051058.GJ1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
 <20160112012512.GJ22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33943 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbcALFLC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 00:11:02 -0500
Received: by mail-pa0-f47.google.com with SMTP id uo6so316670795pac.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 21:11:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112012512.GJ22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 17:25, Stephen Boyd wrote:
> Doesn't rcu_read_lock() disable preemption sometimes? I don't
> think we can call regulator ops with preemption disabled because
> regulators use mutex locking. It looks like
> regulator_list_voltage() may take a mutex anyway.

-------------------------8<-------------------------

Subject: [PATCH] PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()

In few use cases (like: cpufreq), it is desired to get the maximum
voltage latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 56 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_opp.h        |  6 +++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 052fc6b78dc3..62976d0bd61c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -231,8 +231,62 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
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
+	/*
+	 * Hold our list modification lock here as regulator_set_voltage_time()
+	 * can possibly take another mutex, which isn't allowed within rcu
+	 * locks.
+	 */
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		goto unlock;
+
+	reg = dev_opp->regulator;
+	/* Regulator may not be available for device */
+	if (IS_ERR(reg))
+		goto unlock;
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
+	ret = regulator_set_voltage_time(reg, min_uV, max_uV);
+	if (ret > 0)
+		latency_ns = ret * 1000;
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+
+	return latency_ns;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
+
+/**
  * dev_pm_opp_get_suspend_opp() - Get suspend opp
- * @dev:	device for which we do this operation
+ * @dev: device for which we do this operation
  *
  * Return: This function returns pointer to the suspend opp if it is
  * defined and available, otherwise it returns NULL.
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
viresh
