From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 4/4] intel_pstate: Remove the freq calculation from the intel_pstate_calc_busy function
Date: Tue,  8 Mar 2016 10:31:20 +0100
Message-ID: <1457429481-13283-9-git-send-email-philippe.longepe@linux.intel.com>
References: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32312 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291AbcCHJa2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 04:30:28 -0500
In-Reply-To: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

Use a helper function to compute the average pstate and call it only
where it is needed (only when tracing or in intel_pstate_get).

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 903341f..6e07366 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -878,12 +878,6 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 	core_pct = int_tofp(sample->aperf) * int_tofp(100);
 	core_pct = div64_u64(core_pct, int_tofp(sample->mperf));
 
-	sample->freq = fp_toint(
-		mul_fp(int_tofp(
-			cpu->pstate.max_pstate_physical *
-			cpu->pstate.scaling / 100),
-			core_pct));
-
 	sample->core_pct_busy = (int32_t)core_pct;
 }
 
@@ -917,6 +911,12 @@ static inline void intel_pstate_sample(struct cpudata *cpu, u64 time)
 	cpu->prev_tsc = tsc;
 }
 
+static inline int32_t get_avg_frequency(struct cpudata *cpu)
+{
+	return div64_u64(cpu->pstate.max_pstate_physical * cpu->sample.aperf *
+		cpu->pstate.scaling, cpu->sample.mperf);
+}
+
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
@@ -1012,7 +1012,7 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 		sample->mperf,
 		sample->aperf,
 		sample->tsc,
-		sample->freq);
+		get_avg_frequency(cpu));
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
@@ -1101,7 +1101,7 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
 	if (!cpu)
 		return 0;
 	sample = &cpu->sample;
-	return sample->freq;
+	return get_avg_frequency(cpu);
 }
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
-- 
1.9.1

