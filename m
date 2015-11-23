From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v1 5/5] cpufreq: intel_pstate: try load instead of busy_scaled
Date: Mon, 23 Nov 2015 14:06:46 +0100
Message-ID: <1448284006-13596-12-git-send-email-philippe.longepe@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14848 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbbKWNGb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:06:31 -0500
In-Reply-To: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>, Stephane Gasparini <stephane.gasparini@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

- use the load instead of busy scales
- reactivate ioboost

The time spent in iowait is converted into cycles at max freq,
so it increases the load during IOs.

Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4f08fa7..61b31d4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -114,6 +114,7 @@ struct cpudata {
 	u64	prev_mperf;
 	u64	prev_tsc;
 	struct sample sample;
+	u64 prev_cummulative_iowait;
 };
 
 static struct cpudata **all_cpu_data;
@@ -931,12 +932,22 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
-
 static inline int32_t intel_pstate_calc_scaled_busy(struct cpudata *cpu)
 {
+	u64 cummulative_iowait, delta_iowait_us;
+	u64 delta_iowait_mperf;
+	u64 mperf, now;
 	struct sample *sample = &cpu->sample;
 	struct pstate_data *pstate = &cpu->pstate;
-	int64_t core_busy_ratio;
+
+	cummulative_iowait = get_cpu_iowait_time_us(cpu->cpu, &now);
+	/* Convert iowait time into number of IO cycles spent at max_freq */
+	delta_iowait_us = cummulative_iowait - cpu->prev_cummulative_iowait;
+	delta_iowait_mperf = div64_u64(delta_iowait_us * cpu->pstate.scaling *
+		cpu->pstate.max_pstate, 1000);
+
+	mperf = cpu->sample.mperf + delta_iowait_mperf;
+	cpu->prev_cummulative_iowait = cummulative_iowait;
 
 	/*
 	 * The load can be estimated as the ratio of the mperf counter
@@ -944,30 +955,11 @@ static inline int32_t intel_pstate_calc_scaled_busy(struct cpudata *cpu)
 	 * (C0) and the time stamp counter running at the same frequency
 	 * also during C-states.
 	 */
-	sample->cpu_load = div64_u64(100 * sample->mperf, sample->tsc);
-
-	/*
-	 * The target P-state can be estimated with the following formula:
-	 * PercentPerformance = PercentBusy * (delta_aperf/delta_mperf);
-	 * (see Section 14.2 from Intel Software Developer Manual)
-	 * with PercentBusy = 100 * (delta_mperf / delta_tsc) and
-	 * PercentPerformance can be simplified with:
-	 * (delta_mperf * delta_aperf) / (delta_tsc * delta_mperf) =
-	 * delta_aperf / delta_tsc. Finally, we normalize core_busy_ratio,
-	 * which was our actual percent performance to what we requested
-	 * during the last sample period. The result will be a percentage of
-	 * busy at a specified pstate.
-	 */
-	core_busy_ratio = div64_u64(int_tofp(100) * sample->aperf *
-		pstate->max_pstate, sample->tsc * pstate->current_pstate);
+	sample->cpu_load = div64_u64(100 * mperf, sample->tsc);
 
-	sample->freq = div64_u64(sample->aperf * pstate->max_pstate *
-		pstate->scaling, sample->mperf);
-
-	return core_busy_ratio;
+	return sample->cpu_load;
 }
 
-
 static inline int32_t intel_pstate_get_scaled_busy_estimate(struct cpudata *cpu)
 {
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
-- 
1.9.1

