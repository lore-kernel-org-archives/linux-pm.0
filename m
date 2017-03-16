From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/17] thermal: cpu_cooling: don't store cpu_dev in cpufreq_dev
Date: Thu, 16 Mar 2017 10:59:50 +0530
Message-ID: <c231659587b19c013a5457ab141faef3f21ae3d3.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36202 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCPFa4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 01:30:56 -0400
Received: by mail-pg0-f45.google.com with SMTP id g2so19548198pge.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 22:30:51 -0700 (PDT)
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

'cpu_dev' is used by only one function, get_static_power(), and it
wouldn't be time consuming to get the cpu device structure within it.
This would help removing cpu_dev from struct cpufreq_cooling_device.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index fd84802d2e8e..fb535fd5aa12 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -87,7 +87,6 @@ struct time_in_idle {
  * @node: list_head to link all cpufreq_cooling_device together.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @idle_time: idle time stats
- * @cpu_dev: the cpu_device of policy->cpu.
  * @plat_get_static_power: callback to calculate the static power
  *
  * This structure is required for keeping information of each registered
@@ -104,7 +103,6 @@ struct cpufreq_cooling_device {
 	struct list_head node;
 	u32 last_load;
 	struct time_in_idle *idle_time;
-	struct device *cpu_dev;
 	get_static_t plat_get_static_power;
 };
 
@@ -256,8 +254,6 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_dev,
 		freq_table[i].power = power;
 	}
 
-	cpufreq_dev->cpu_dev = dev;
-
 	return 0;
 }
 
@@ -339,19 +335,22 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_dev,
 {
 	struct dev_pm_opp *opp;
 	unsigned long voltage;
-	struct cpumask *cpumask = cpufreq_dev->policy->related_cpus;
+	struct cpufreq_policy *policy = cpufreq_dev->policy;
+	struct cpumask *cpumask = policy->related_cpus;
 	unsigned long freq_hz = freq * 1000;
+	struct device *dev;
 
-	if (!cpufreq_dev->plat_get_static_power || !cpufreq_dev->cpu_dev) {
+	if (!cpufreq_dev->plat_get_static_power) {
 		*power = 0;
 		return 0;
 	}
 
-	opp = dev_pm_opp_find_freq_exact(cpufreq_dev->cpu_dev, freq_hz,
-					 true);
+	dev = get_cpu_device(policy->cpu);
+	WARN_ON(!dev);
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
 	if (IS_ERR(opp)) {
-		dev_warn_ratelimited(cpufreq_dev->cpu_dev,
-				     "Failed to find OPP for frequency %lu: %ld\n",
+		dev_warn_ratelimited(dev, "Failed to find OPP for frequency %lu: %ld\n",
 				     freq_hz, PTR_ERR(opp));
 		return -EINVAL;
 	}
@@ -360,8 +359,7 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_dev,
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_err_ratelimited(cpufreq_dev->cpu_dev,
-				    "Failed to get voltage for frequency %lu\n",
+		dev_err_ratelimited(dev, "Failed to get voltage for frequency %lu\n",
 				    freq_hz);
 		return -EINVAL;
 	}
-- 
2.7.1.410.g6faf27b
