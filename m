From: dirk.brandewie@gmail.com
Subject: [PATCH 05/11] cpufreq: intel_pstate: Cleanup parentheses
Date: Fri, 18 Jul 2014 08:37:21 -0700
Message-ID: <1405697848-13546-6-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44483 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422773AbaGRPhr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:47 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so5644338pad.37
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:46 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

Remove unnecessary parentheses.
Also, add parentheses in one case for better readability.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 424c5a9..dee9e58 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -443,7 +443,7 @@ static int core_get_turbo_pstate(void)
 
 	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
 	nont = core_get_max_pstate();
-	ret = ((value) & 255);
+	ret = (value) & 255;
 	if (ret <= nont)
 		ret = nont;
 	return ret;
@@ -617,7 +617,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 
-	sample_time = (pid_params.sample_rate_ms  * USEC_PER_MSEC);
+	sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
 	duration_us = (u32) ktime_us_delta(cpu->sample.time,
 					cpu->last_sample_time);
 	if (duration_us > sample_time * 3) {
@@ -751,7 +751,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits.min_perf_pct = clamp_t(int, limits.min_perf_pct, 0 , 100);
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 
-	limits.max_policy_pct = policy->max * 100 / policy->cpuinfo.max_freq;
+	limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
 	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
@@ -763,8 +763,8 @@ static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
 
-	if ((policy->policy != CPUFREQ_POLICY_POWERSAVE) &&
-		(policy->policy != CPUFREQ_POLICY_PERFORMANCE))
+	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
+		policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
 	return 0;
-- 
1.9.3

