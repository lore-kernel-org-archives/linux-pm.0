From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 10/17] thermal: cpu_cooling: OPPs are registered for all CPUs
Date: Tue, 25 Apr 2017 15:57:17 +0530
Message-ID: <ab4b99ee37d789f445ef488e3eb1b6bcddd98c61.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35628 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1429564AbdDYK2E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 06:28:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id v14so21410948pfd.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 03:28:04 -0700 (PDT)
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

The OPPs are registered for all CPUs of a cpufreq policy now and we
don't need to run the loop in build_dyn_power_table(). Just check for
the policy->cpu and we should be fine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7dddc7443f5d..ce387f62c93e 100644
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
@@ -207,24 +207,20 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_cdev,
 	struct power_table *power_table;
 	struct dev_pm_opp *opp;
 	struct device *dev = NULL;
-	int num_opps = 0, cpu, i, ret = 0;
+	int num_opps = 0, cpu = cpufreq_cdev->policy->cpu, i, ret = 0;
 	unsigned long freq;
 
-	for_each_cpu(cpu, &cpufreq_cdev->allowed_cpus) {
-		dev = get_cpu_device(cpu);
-		if (!dev) {
-			dev_warn(&cpufreq_cdev->cdev->device,
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
+		dev_warn(&cpufreq_cdev->cdev->device,
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
2.12.0.432.g71c3a4f4ba37
