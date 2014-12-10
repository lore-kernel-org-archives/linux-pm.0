From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: Add a few comments
Date: Wed, 10 Dec 2014 12:39:38 -0800
Message-ID: <1418243978-19461-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23109 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933064AbaLJUj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Dec 2014 15:39:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Add a few comments in the code which calculates busyness to
clarify parts of the algorithm.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 27bb6d3..9a58dcb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -198,7 +198,14 @@ static signed int pid_calc(struct _pid *pid, int32_t busy)
 
 	pid->integral += fp_error;
 
-	/* limit the integral term */
+	/*
+	 * We limit the integral here so that it will never
+	 * get higher than 30.  This prevents it from becoming
+	 * too large an input over long periods of time and allows
+	 * it to get factored out sooner.
+	 *
+	 * The value of 30 was chosen through experimentation.
+	 */
 	integral_limit = int_tofp(30);
 	if (pid->integral > integral_limit)
 		pid->integral = integral_limit;
@@ -569,6 +576,11 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 	if (limits.no_turbo || limits.turbo_disabled)
 		max_perf = cpu->pstate.max_pstate;
 
+	/*
+	 * performance can be limited by user through sysfs, by cpufreq
+	 * policy, or by cpu specific default values determined through
+	 * experimentation.
+	 */
 	max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits.max_perf));
 	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
@@ -662,11 +674,29 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	u32 duration_us;
 	u32 sample_time;
 
+	/*
+	 * core_busy is the ratio of actual performance to max
+	 * max_pstate is the max non turbo pstate available
+	 * current_pstate was the pstate that was requested during
+	 * 	the last sample period.
+	 *
+	 * We normalize core_busy, which was our actual percent
+	 * performance to what we requested during the last sample
+	 * period. The result will be a percentage of busy at a
+	 * specified pstate.
+	 */
 	core_busy = cpu->sample.core_pct_busy;
 	max_pstate = int_tofp(cpu->pstate.max_pstate);
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 
+	/*
+	 * Since we have a deferred timer, it will not fire unless
+	 * we are in C0.  So, determine if the actual elapsed time
+	 * is significantly greater (3x) than our sample interval.  If it
+	 * is, then we were idle for a long enough period of time
+	 * to adjust our busyness.
+	 */
 	sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
 	duration_us = (u32) ktime_us_delta(cpu->sample.time,
 					   cpu->last_sample_time);
-- 
1.9.3

