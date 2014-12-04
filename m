From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 17/26] thermal: cpu_cooling: initialize 'cpufreq_val' on registration
Date: Thu,  4 Dec 2014 09:41:59 +0530
Message-ID: <09752de4819071ad00297894d53439d801b7c120.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60778 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbaLDENu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:50 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so16912372pab.26
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:50 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

There is no point checking for validity of 'cpufreq_val' from
cpufreq_thermal_notifier() every time the routine is called. Its guaranteed to
be 0 on the first call but will be valid otherwise.

Lets update it once while the device registers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 491d90a..86bcf8d 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -316,11 +316,6 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 					&cpufreq_dev->allowed_cpus))
 			continue;
 
-		if (!cpufreq_dev->cpufreq_val)
-			cpufreq_dev->cpufreq_val = get_cpu_frequency(
-					cpumask_any(&cpufreq_dev->allowed_cpus),
-					cpufreq_dev->cpufreq_state);
-
 		max_freq = cpufreq_dev->cpufreq_val;
 
 		if (policy->max != max_freq)
@@ -444,6 +439,13 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
 
+	cpufreq_dev->cpufreq_val = get_cpu_frequency(cpumask_any(clip_cpus), 0);
+	if (!cpufreq_dev->cpufreq_val) {
+		pr_err("%s: Failed to get frequency", __func__);
+		cool_dev = ERR_PTR(-EINVAL);
+		goto free_cdev;
+	}
+
 	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
 
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
-- 
2.0.3.693.g996b0fd

