From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/17] thermal: cpu_cooling: OPPs are registered for all CPUs
Date: Thu, 16 Mar 2017 10:59:45 +0530
Message-ID: <7a99a212c7c7b4a0b8ce9cc723bb2f16b7ef0962.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35907 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdCPFaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 01:30:35 -0400
Received: by mail-pf0-f172.google.com with SMTP id o126so18994103pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 22:30:34 -0700 (PDT)
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

The OPPs are registered for all CPUs of a cpufreq policy now and we
don't need to run the loop in build_dyn_power_table(). Just check for
the policy->cpu and we should be fine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7590279bf1de..1df6c9039e45 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -83,7 +83,7 @@ struct power_table {
  * @dyn_power_table: array of struct power_table for frequency to power
  *	conversion, sorted in ascending order.
  * @dyn_power_table_entries: number of entries in the @dyn_power_table array
- * @cpu_dev: the first cpu_device from @allowed_cpus that has OPPs registered
+ * @cpu_dev: the cpu_device of policy->cpu.
  * @plat_get_static_power: callback to calculate the static power
  *
  * This structure is required for keeping information of each registered
@@ -208,24 +208,20 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_dev,
 	struct power_table *power_table;
 	struct dev_pm_opp *opp;
 	struct device *dev = NULL;
-	int num_opps = 0, cpu, i, ret = 0;
+	int num_opps = 0, cpu = cpufreq_dev->policy->cpu, i, ret = 0;
 	unsigned long freq;
 
-	for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
-		dev = get_cpu_device(cpu);
-		if (!dev) {
-			dev_warn(&cpufreq_dev->cdev->device,
-				 "No cpu device for cpu %d\n", cpu);
-			continue;
-		}
-
-		num_opps = dev_pm_opp_get_opp_count(dev);
-		if (num_opps > 0)
-			break;
-		else if (num_opps < 0)
-			return num_opps;
+	dev = get_cpu_device(cpu);
+	if (unlikely(!dev)) {
+		dev_warn(&cpufreq_dev->cdev->device,
+			 "No cpu device for cpu %d\n", cpu);
+		return -ENODEV;
 	}
 
+	num_opps = dev_pm_opp_get_opp_count(dev);
+	if (num_opps < 0)
+		return num_opps;
+
 	if (num_opps == 0)
 		return -EINVAL;
 
-- 
2.7.1.410.g6faf27b
