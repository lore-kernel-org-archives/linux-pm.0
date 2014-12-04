From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 14/26] thermal: cpu_cooling: don't iterate over all allowed_cpus to update cpufreq policy
Date: Thu,  4 Dec 2014 09:41:56 +0530
Message-ID: <07ca368899ab998090119eabdd70c3336356d836.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49389 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbaLDENj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:39 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so17074561pac.22
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:39 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

All CPUs present in 'allowed_cpus' share the same 'struct cpufreq_policy'
structure and so calling cpufreq_update_policy() for each of them doesn't make
sense.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f325738..7f27f1b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -285,11 +285,10 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 				 unsigned long cooling_state)
 {
-	unsigned int cpuid, clip_freq;
+	unsigned int clip_freq;
 	struct cpumask *mask = &cpufreq_device->allowed_cpus;
 	unsigned int cpu = cpumask_any(mask);
 
-
 	/* Check if the old cooling action is same as new cooling action */
 	if (cpufreq_device->cpufreq_state == cooling_state)
 		return 0;
@@ -301,10 +300,8 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 	cpufreq_device->cpufreq_state = cooling_state;
 	cpufreq_device->cpufreq_val = clip_freq;
 
-	for_each_cpu(cpuid, mask) {
-		if (is_cpufreq_valid(cpuid))
-			cpufreq_update_policy(cpuid);
-	}
+	if (is_cpufreq_valid(cpu))
+		cpufreq_update_policy(cpu);
 
 	return 0;
 }
-- 
2.0.3.693.g996b0fd

