From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/16] PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
Date: Fri, 11 Sep 2015 17:32:07 +0530
Message-ID: <bbddb4af2f6345d9cc0876dce31a1fc6babf04a9.1441972771.git.viresh.kumar@linaro.org>
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
latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 17 +++++++++++++++++
 include/linux/pm_opp.h        |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index e272e738a8d0..d0678e804a75 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -285,6 +285,23 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
 
 /**
+ * dev_pm_opp_get_max_transition_latency() - Get max transition latency in
+ *					     nanoseconds
+ * @dev:	device for which we do this operation
+ *
+ * Return: This function returns the max transition latency, in nanoseconds, to
+ * switch from one OPP to other.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
+{
+	return dev_pm_opp_get_max_volt_latency(dev) +
+		dev_pm_opp_get_max_clock_latency(dev);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
+
+/**
  * dev_pm_opp_get_suspend_opp() - Get suspend opp
  * @dev:	device for which we do this operation
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index fd58e2074721..e36f347ff32b 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -35,6 +35,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
+unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
@@ -87,6 +88,11 @@ static inline unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
 {
 	return NULL;
-- 
2.4.0
