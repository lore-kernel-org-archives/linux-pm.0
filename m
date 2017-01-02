From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 08/10] PM / OPP: Rename dev_pm_opp_get_suspend_opp() and return OPP rate
Date: Mon,  2 Jan 2017 14:41:02 +0530
Message-ID: <8b9ee8efb3981b4b85cd31b5f013f780fc72025b.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There is only one user of dev_pm_opp_get_suspend_opp() and that uses it
to get the OPP rate for the suspend_opp.

Rename dev_pm_opp_get_suspend_opp() as dev_pm_opp_get_suspend_opp_freq()
and return the rate directly from it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 27 +++++++++++++--------------
 drivers/cpufreq/cpufreq-dt.c  |  7 +------
 include/linux/pm_opp.h        |  6 +++---
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index dde7dd099aa0..614d779ab6a2 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -328,32 +328,31 @@ unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
 
 /**
- * dev_pm_opp_get_suspend_opp() - Get suspend opp
+ * dev_pm_opp_get_suspend_opp_freq() - Get frequency of suspend opp in Hz
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
+	freq = dev_pm_opp_get_freq(opp_table->suspend_opp);
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
index 269013311e79..c943787d761e 100644
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
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu_dev) / 1000;
 
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
