From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/26] cpu_cooling: Don't match min/max frequencies for all CPUs on cooling register
Date: Fri, 28 Nov 2014 15:14:06 +0530
Message-ID: <0ca43eb27849888b58a263bf589490b678bfffef.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48963 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbaK1JpW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:22 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so6389661pdj.7
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:22 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

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
index 964586f..c358ede 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -434,6 +434,7 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
+ * Normally this should be same as cpufreq policy->related_cpus.
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -449,25 +450,9 @@ __cpufreq_cooling_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev;
-	unsigned int min = 0, max = 0;
 	char dev_name[THERMAL_NAME_LENGTH];
-	int ret = 0, i;
-	struct cpufreq_policy policy;
+	int ret = 0;
 
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
 	cpufreq_dev = kzalloc(sizeof(*cool_dev), GFP_KERNEL);
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
-- 
2.0.3.693.g996b0fd

