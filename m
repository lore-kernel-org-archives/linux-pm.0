From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/7] cpu_cooling: don't iterate over all allowed_cpus to update cpufreq policy
Date: Wed, 26 Nov 2014 11:23:01 +0530
Message-ID: <51626b4b1eb041fb19a06a90865dd92268465ffd.1416980448.git.viresh.kumar@linaro.org>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45295 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaKZFxl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 00:53:41 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so2186489pad.9
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 21:53:40 -0800 (PST)
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

All CPUs present in 'allowed_cpus' share the same 'struct cpufreq_policy'
structure and so calling cpufreq_update_policy() for each of them doesn't make
sense.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 1193cc4..41f5728 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -272,11 +272,10 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
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
@@ -289,10 +288,8 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
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

