From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH 1/5] cpufreq: intel_pstate: change function name for calculation for busy
Date: Mon, 23 Nov 2015 14:06:38 +0100
Message-ID: <1448284006-13596-4-git-send-email-philippe.longepe@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40543 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbbKWNGL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:06:11 -0500
In-Reply-To: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

APERF/MPERF is not giving busy but average performance of frequency.
Also core_pct_busy is not busy but core percent for performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d3b0e50..423a12a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -65,7 +65,7 @@ static inline int ceiling_fp(int32_t x)
 }
 
 struct sample {
-	int32_t core_pct_busy;
+	int32_t core_pct_perf;
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
@@ -856,7 +856,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
 }
 
-static inline void intel_pstate_calc_busy(struct cpudata *cpu)
+static inline void intel_pstate_calc_performance(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
 	int64_t core_pct;
@@ -870,7 +870,7 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 			cpu->pstate.scaling / 100),
 			core_pct));
 
-	sample->core_pct_busy = (int32_t)core_pct;
+	sample->core_pct_perf = (int32_t)core_pct;
 }
 
 static inline void intel_pstate_sample(struct cpudata *cpu)
@@ -899,7 +899,7 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 	cpu->sample.mperf -= cpu->prev_mperf;
 	cpu->sample.tsc -= cpu->prev_tsc;
 
-	intel_pstate_calc_busy(cpu);
+	intel_pstate_calc_performance(cpu);
 
 	cpu->prev_aperf = aperf;
 	cpu->prev_mperf = mperf;
@@ -939,7 +939,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	 * period. The result will be a percentage of busy at a
 	 * specified pstate.
 	 */
-	core_busy = cpu->sample.core_pct_busy;
+	core_busy = cpu->sample.core_pct_perf;
 	max_pstate = int_tofp(cpu->pstate.max_pstate_physical);
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
@@ -982,7 +982,7 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl, true);
 
 	sample = &cpu->sample;
-	trace_pstate_sample(fp_toint(sample->core_pct_busy),
+	trace_pstate_sample(fp_toint(sample->core_pct_perf),
 		fp_toint(busy_scaled),
 		from,
 		cpu->pstate.current_pstate,
-- 
1.9.1

