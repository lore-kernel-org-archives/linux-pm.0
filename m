From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/26] cpu_cooling: Don't check is_cpufreq_valid()
Date: Fri, 28 Nov 2014 15:14:08 +0530
Message-ID: <4104dfae900b639da7d7eb0e097e4a4e2a6970ad.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40535 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaK1Jpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:30 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so6568622pad.13
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:29 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

Because get_cpu_frequency() has returned a valid frequency, it means that the
cpufreq policy is surely valid and so no point checking that again with
is_cpufreq_valid(). Get rid of the routine as well as there are no more users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 8ca0380..41aa7d5 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -111,23 +111,6 @@ static void release_idr(struct idr *idr, int id)
 
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
@@ -302,8 +285,7 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 	cpufreq_device->cpufreq_val = clip_freq;
 	notify_device = cpufreq_device;
 
-	if (is_cpufreq_valid(cpu))
-		cpufreq_update_policy(cpu);
+	cpufreq_update_policy(cpu);
 
 	notify_device = NOTIFY_INVALID;
 
-- 
2.0.3.693.g996b0fd

