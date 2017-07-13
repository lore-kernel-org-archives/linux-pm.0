From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Correct the busy calculation for KNL
Date: Thu, 13 Jul 2017 15:03:51 -0700
Message-ID: <1499983431-65396-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbdGMWDx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jul 2017 18:03:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

The busy percent calculated for Knights Landing (KNL) platform is 1024
times smaller than the correct busy value. This causes performance to get
stuck at the lowest ratio.

The scaling algorithm used for KNL is performance based but it will
still use cpu busy less than 1 percent to set the scaled busy to 0. In
this case since the busy is 1024x smaller, the scaled busy will always
be 0, irrespective of CPU business.

This needs similar fix done to turbostat in
commit b2b34dfe4d9a ("tools/power turbostat: KNL workaround for %Busy
and Avg_MHz")

Added another callback to processor specific callbacks to specify a
multiplier to aper & mperf by specifying number of left shifts. This
shift value is used during CPU busy calculations.

Fixes: ffb810563c ("intel_pstate: Avoid getting stuck in high P-states
when idle")
Reported-and-tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
---
 drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b7fb8b7..6cd5035 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -225,6 +225,9 @@ struct global_params {
  * @vid:		Stores VID limits for this CPU
  * @pid:		Stores PID parameters for this CPU
  * @last_sample_time:	Last Sample time
+ * @aperf_mperf_shift:	Number of clock cycles after aperf, merf is incremented
+ *			This shift is a multiplier to mperf delta to
+ *			calculate CPU busy.
  * @prev_aperf:		Last APERF value read from APERF MSR
  * @prev_mperf:		Last MPERF value read from MPERF MSR
  * @prev_tsc:		Last timestamp counter (TSC) value
@@ -259,6 +262,7 @@ struct cpudata {
 
 	u64	last_update;
 	u64	last_sample_time;
+	u64	aperf_mperf_shift;
 	u64	prev_aperf;
 	u64	prev_mperf;
 	u64	prev_tsc;
@@ -321,6 +325,7 @@ struct pstate_funcs {
 	int (*get_min)(void);
 	int (*get_turbo)(void);
 	int (*get_scaling)(void);
+	int (*get_aperf_mperf_shift)(void);
 	u64 (*get_val)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
 	void (*update_util)(struct update_util_data *data, u64 time,
@@ -1486,6 +1491,11 @@ static u64 core_get_val(struct cpudata *cpudata, int pstate)
 	return val;
 }
 
+static int knl_get_aperf_mperf_shift(void)
+{
+	return 10;
+}
+
 static int knl_get_turbo_pstate(void)
 {
 	u64 value;
@@ -1543,6 +1553,9 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
 	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
+	if (pstate_funcs.get_aperf_mperf_shift)
+		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
+
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
 
@@ -1616,7 +1629,8 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 	int32_t busy_frac, boost;
 	int target, avg_pstate;
 
-	busy_frac = div_fp(sample->mperf, sample->tsc);
+	busy_frac = div_fp(sample->mperf << cpu->aperf_mperf_shift,
+			   sample->tsc);
 
 	boost = cpu->iowait_boost;
 	cpu->iowait_boost >>= 1;
@@ -1675,7 +1689,8 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 		sample_ratio = div_fp(pid_params.sample_rate_ns, duration_ns);
 		perf_scaled = mul_fp(perf_scaled, sample_ratio);
 	} else {
-		sample_ratio = div_fp(100 * cpu->sample.mperf, cpu->sample.tsc);
+		sample_ratio = div_fp(100 * (cpu->sample.mperf << cpu->aperf_mperf_shift),
+				      cpu->sample.tsc);
 		if (sample_ratio < int_tofp(1))
 			perf_scaled = 0;
 	}
@@ -1807,6 +1822,7 @@ static const struct pstate_funcs knl_funcs = {
 	.get_max_physical = core_get_max_pstate_physical,
 	.get_min = core_get_min_pstate,
 	.get_turbo = knl_get_turbo_pstate,
+	.get_aperf_mperf_shift = knl_get_aperf_mperf_shift,
 	.get_scaling = core_get_scaling,
 	.get_val = core_get_val,
 	.update_util = intel_pstate_update_util_pid,
@@ -2403,6 +2419,7 @@ static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_val   = funcs->get_val;
 	pstate_funcs.get_vid   = funcs->get_vid;
 	pstate_funcs.update_util = funcs->update_util;
+	pstate_funcs.get_aperf_mperf_shift = funcs->get_aperf_mperf_shift;
 
 	intel_pstate_use_acpi_profile();
 }
-- 
2.7.5
