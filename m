From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v1 3/5] cpufreq: intel_pstate: account for non C0 time
Date: Mon, 23 Nov 2015 14:06:42 +0100
Message-ID: <1448284006-13596-8-git-send-email-philippe.longepe@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14848 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909AbbKWNGX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:06:23 -0500
In-Reply-To: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>, Stephane Gasparini <stephane.gasparini@linux.intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

Aperf and Mperf counter are not enough to determine the Target P-state
because they measure performance only when the targeted processor is
in the C0 state (active state).
Because of that, we were computing the average P-state during the last
period which can be very different from the average frequency
(or percentage of performance).

As defined in the SDM (section 14.2), the PercentPerformance is defined by:

PercentPerformance = PercentBusy * (delta_aperf / delta_mperf);

The PercentBusy (or load) can be estimated as the ratio of the mperf
counter running at a constant frequency only during active periods (C0)
and the time stamp counter running at the same frequency but also
during idle.

So, PercentBusy = 100 * (delta_mperf / delta_tsc)

and, PercentPerformance = 100 * (delta_mperf / delta_tsc) *
                                (delta_aperf / delta_mperf)
That can be simplified with:
PercentPerformance = 100 * (delta_aperf / delta_tsc)

Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fa27ec5..f9acfb0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -66,6 +66,7 @@ static inline int ceiling_fp(int32_t x)
 
 struct sample {
 	int32_t core_pct_perf;
+	int32_t	cpu_load;
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
@@ -922,6 +923,43 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
+
+static inline int32_t intel_pstate_calc_scaled_busy(struct cpudata *cpu)
+{
+	struct sample *sample = &cpu->sample;
+	struct pstate_data *pstate = &cpu->pstate;
+	int64_t core_busy_ratio;
+
+	/*
+	 * The load can be estimated as the ratio of the mperf counter
+	 * running at a constant frequency only during active periods
+	 * (C0) and the time stamp counter running at the same frequency
+	 * also during C-states.
+	 */
+	sample->cpu_load = div64_u64(100 * sample->mperf, sample->tsc);
+
+	/*
+	 * The target P-state can be estimated with the following formula:
+	 * PercentPerformance = PercentBusy * (delta_aperf/delta_mperf);
+	 * (see Section 14.2 from Intel Software Developer Manual)
+	 * with PercentBusy = 100 * (delta_mperf / delta_tsc) and
+	 * PercentPerformance can be simplified with:
+	 * (delta_mperf * delta_aperf) / (delta_tsc * delta_mperf) =
+	 * delta_aperf / delta_tsc. Finally, we normalize core_busy_ratio,
+	 * which was our actual percent performance to what we requested
+	 * during the last sample period. The result will be a percentage of
+	 * busy at a specified pstate.
+	 */
+	core_busy_ratio = div64_u64(int_tofp(100) * sample->aperf *
+		pstate->max_pstate, sample->tsc * pstate->current_pstate);
+
+	sample->freq = div64_u64(sample->aperf * pstate->max_pstate *
+		pstate->scaling, sample->mperf);
+
+	return core_busy_ratio;
+}
+
+
 static inline int32_t intel_pstate_get_scaled_busy_estimate(struct cpudata *cpu)
 {
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
@@ -974,7 +1012,7 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	from = cpu->pstate.current_pstate;
 
 	pid = &cpu->pid;
-	busy_scaled = intel_pstate_get_scaled_busy_estimate(cpu);
+	busy_scaled = intel_pstate_calc_scaled_busy(cpu);
 
 	ctl = pid_calc(pid, busy_scaled);
 
-- 
1.9.1

