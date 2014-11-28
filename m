From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/26] cpu_cooling: don't iterate over all allowed_cpus to update cpufreq policy
Date: Fri, 28 Nov 2014 15:14:07 +0530
Message-ID: <52b233ae071b3f51d05e96f060ef35903e6c3b03.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38248 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbaK1Jp0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:26 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so6438298pab.26
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:26 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

All CPUs present in 'allowed_cpus' share the same 'struct cpufreq_policy'
structure and so calling cpufreq_update_policy() for each of them doesn't make
sense.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c358ede..8ca0380 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -286,11 +286,10 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
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
@@ -303,10 +302,8 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 	cpufreq_device->cpufreq_val = clip_freq;
 	notify_device = cpufreq_device;
 
-	for_each_cpu(cpuid, mask) {
-		if (is_cpufreq_valid(cpuid))
-			cpufreq_update_policy(cpuid);
-	}
+	if (is_cpufreq_valid(cpu))
+		cpufreq_update_policy(cpu);
 
 	notify_device = NOTIFY_INVALID;
 
-- 
2.0.3.693.g996b0fd

