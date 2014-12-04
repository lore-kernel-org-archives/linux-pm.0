From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 15/26] thermal: cpu_cooling: Don't check is_cpufreq_valid()
Date: Thu,  4 Dec 2014 09:41:57 +0530
Message-ID: <3657df96fb462fc1825817f346edb68d42da9b55.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40599 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbaLDENn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:43 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so17101786pad.41
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:43 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Because get_cpu_frequency() has returned a valid frequency, it means that the
cpufreq policy is surely valid and so no point checking that again with
is_cpufreq_valid(). Get rid of the routine as well as there are no more users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7f27f1b..1dd4cc4 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -110,23 +110,6 @@ static void release_idr(struct idr *idr, int id)
 
 /* Below code defines functions to be used for cpufreq as cooling device */
 
-/**
- * is_cpufreq_valid - function to check frequency transitioning capability.
- * @cpu: cpu for which check is needed.
- *
- * This function will check the current state of the system if
- * it is capable of changing the frequency for a given @cpu.
- *
- * Return: 0 if the system is not currently capable of changing
- * the frequency of given cpu. !0 in case the frequency is changeable.
- */
-static int is_cpufreq_valid(int cpu)
-{
-	struct cpufreq_policy policy;
-
-	return !cpufreq_get_policy(&policy, cpu);
-}
-
 enum cpufreq_cooling_property {
 	GET_LEVEL,
 	GET_FREQ,
@@ -300,8 +283,7 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 	cpufreq_device->cpufreq_state = cooling_state;
 	cpufreq_device->cpufreq_val = clip_freq;
 
-	if (is_cpufreq_valid(cpu))
-		cpufreq_update_policy(cpu);
+	cpufreq_update_policy(cpu);
 
 	return 0;
 }
-- 
2.0.3.693.g996b0fd

