From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 13/26] thermal: cpu_cooling: Don't match min/max frequencies for all CPUs on cooling register
Date: Thu,  4 Dec 2014 09:41:55 +0530
Message-ID: <6eae693e7f14744315bdff8b4bd7fb11de7b08ce.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:50855 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbaLDENg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:36 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so17074460pac.22
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:35 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

In __cpufreq_cooling_register() we try to match min/max frequencies for all CPUs
passed in 'clip_cpus' mask. This mask is the cpumask of cpus where the frequency
constraints will be applied.

Same frequency constraint can be applied only to the CPUs belonging to the same
cluster (i.e. CPUs sharing clock line). For all such CPUs we have a single
'struct cpufreq_policy' structure managing them and so getting policies for all
CPUs wouldn't make any sense as they will all return the same pointer.

So, remove this useless check of checking min/max for all CPUs. Also update doc
comment to make this more obvious that clip_cpus should be same as
policy->related_cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 5c9a2ef..f325738 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -437,6 +437,7 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
+ * Normally this should be same as cpufreq policy->related_cpus.
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -452,30 +453,14 @@ __cpufreq_cooling_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev;
-	unsigned int min = 0, max = 0;
 	char dev_name[THERMAL_NAME_LENGTH];
-	int ret, i;
-	struct cpufreq_policy policy;
+	int ret;
 
 	if (!cpufreq_frequency_get_table(cpumask_first(clip_cpus))) {
 		pr_debug("%s: CPUFreq table not found\n", __func__);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	/* Verify that all the clip cpus have same freq_min, freq_max limit */
-	for_each_cpu(i, clip_cpus) {
-		/* continue if cpufreq policy not found and not return error */
-		if (!cpufreq_get_policy(&policy, i))
-			continue;
-		if (min == 0 && max == 0) {
-			min = policy.cpuinfo.min_freq;
-			max = policy.cpuinfo.max_freq;
-		} else {
-			if (min != policy.cpuinfo.min_freq ||
-			    max != policy.cpuinfo.max_freq)
-				return ERR_PTR(-EINVAL);
-		}
-	}
 	cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
-- 
2.0.3.693.g996b0fd

