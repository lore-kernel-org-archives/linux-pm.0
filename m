From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/10] PM / OPP: Rename dev_pm_opp_get_suspend_opp() and return OPP rate
Date: Tue,  6 Dec 2016 14:46:00 +0530
Message-ID: <1da9ba0dd518f51fa73ca33e06ba868a267fb5d6.1481015522.git.viresh.kumar@linaro.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36187 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbcLFJQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 04:16:51 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so69680189pfz.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 01:16:40 -0800 (PST)
In-Reply-To: <cover.1481015522.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481015522.git.viresh.kumar@linaro.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

There is only one user of dev_pm_opp_get_suspend_opp() and that uses it
to get the OPP rate for the suspend_opp.

Rename dev_pm_opp_get_suspend_opp() as dev_pm_opp_get_suspend_opp_freq()
and return the rate directly from it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 27 +++++++++++++--------------
 drivers/cpufreq/cpufreq-dt.c  |  7 +------
 include/linux/pm_opp.h        |  6 +++---
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6bcbb64a5582..6fd098618683 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -328,32 +328,31 @@ unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
 
 /**
- * dev_pm_opp_get_suspend_opp() - Get suspend opp
+ * dev_pm_opp_get_suspend_opp_freq() - Get frequency of suspend opp
  * @dev:	device for which we do this operation
  *
- * Return: This function returns pointer to the suspend opp if it is
- * defined and available, otherwise it returns NULL.
- *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. The reason for the same is that the opp pointer which is
- * returned will remain valid for use with opp_get_{voltage, freq} only while
- * under the locked area. The pointer returned must be used prior to unlocking
- * with rcu_read_unlock() to maintain the integrity of the pointer.
+ * Return: This function returns the frequency of the OPP marked as suspend_opp
+ * if one is available, else returns 0;
  */
-struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
+unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 {
 	struct opp_table *opp_table;
+	unsigned long freq = 0;
 
-	opp_rcu_lockdep_assert();
+	rcu_read_lock();
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table) || !opp_table->suspend_opp ||
 	    !opp_table->suspend_opp->available)
-		return NULL;
+		goto unlock;
 
-	return opp_table->suspend_opp;
+	freq = dev_pm_opp_get_freq(opp_table->suspend_opp) / 1000;
+
+unlock:
+	rcu_read_unlock();
+	return freq;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp);
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
 
 /**
  * dev_pm_opp_get_opp_count() - Get number of opps available in the opp table
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 269013311e79..d0a53119d8a2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -148,7 +148,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
-	struct dev_pm_opp *suspend_opp;
 	unsigned int transition_latency;
 	bool fallback = false;
 	const char *name;
@@ -252,11 +251,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = priv;
 	policy->clk = cpu_clk;
 
-	rcu_read_lock();
-	suspend_opp = dev_pm_opp_get_suspend_opp(cpu_dev);
-	if (suspend_opp)
-		policy->suspend_freq = dev_pm_opp_get_freq(suspend_opp) / 1000;
-	rcu_read_unlock();
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu_dev);
 
 	ret = cpufreq_table_validate_and_show(policy, freq_table);
 	if (ret) {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0edd88f93904..7483ff291a8e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -88,7 +88,7 @@ int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
-struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
+unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -159,9 +159,9 @@ static inline unsigned long dev_pm_opp_get_max_transition_latency(struct device
 	return 0;
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
+static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 {
-	return NULL;
+	return 0;
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
-- 
2.7.1.410.g6faf27b

