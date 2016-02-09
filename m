From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 04/16] PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
Date: Tue,  9 Feb 2016 10:30:36 +0530
Message-ID: <d1b7a10043a011e50c28d9ca95afc6f9d5cad734.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34057 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbcBIFB2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 00:01:28 -0500
Received: by mail-pa0-f45.google.com with SMTP id kp3so1842122pab.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 21:01:28 -0800 (PST)
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

In few use cases (like: cpufreq), it is desired to get the maximum
latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 17 +++++++++++++++++
 include/linux/pm_opp.h        |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index ffe2406af882..b0f5c72f0fc3 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -290,6 +290,23 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
 
 /**
+ * dev_pm_opp_get_max_transition_latency() - Get max transition latency in
+ *					     nanoseconds
+ * @dev: device for which we do this operation
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
index 5daa43058ac1..59da3d9e11ea 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -35,6 +35,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
+unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
@@ -94,6 +95,11 @@ static inline unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
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
2.7.1.370.gb2aa7f8

