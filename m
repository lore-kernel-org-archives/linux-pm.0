From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/16] PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
Date: Fri, 11 Sep 2015 17:32:06 +0530
Message-ID: <c590232d9bbeb709325075f1d9667f17f30e1489.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

In few use cases (like: cpufreq), it is desired to get the maximum
voltage latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |  6 +++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 04fe181b8132..e272e738a8d0 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -226,6 +226,65 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
 
 /**
+ * dev_pm_opp_get_max_volt_latency() - Get max voltage latency in nanoseconds
+ * @dev:	device for which we do this operation
+ *
+ * Return: This function returns the max voltage latency in nanoseconds.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp;
+	struct opp_supply *supply;
+	struct regulator *reg;
+	unsigned long latency_ns = 0;
+	unsigned long min_uV, max_uV;
+	int count, ret;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		goto unlock;
+
+	/* Sum max latencies for all supplies */
+	for (count = 0; count < dev_opp->supply_count; count++) {
+		min_uV = ~0;
+		max_uV = 0;
+
+		reg = dev_opp->regulators[count];
+
+		/* Regulator may not be available for device */
+		if (IS_ERR(reg))
+			continue;
+
+		list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+			if (!opp->available)
+				continue;
+
+			supply = opp->supplies + count;
+
+			if (supply->u_volt_min < min_uV)
+				min_uV = supply->u_volt_min;
+			if (supply->u_volt_max > max_uV)
+				max_uV = supply->u_volt_max;
+		}
+
+		ret = regulator_set_voltage_time(reg, min_uV, max_uV);
+		if (ret > 0)
+			latency_ns += ret * 1000;
+	}
+
+unlock:
+	rcu_read_unlock();
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
index 9a2e50337af9..fd58e2074721 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -34,6 +34,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
+unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
@@ -81,6 +82,11 @@ static inline unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
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
2.4.0
