From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V5 2/3] cpufreq: intel_pstate: account for non C0 time
Date: Thu,  3 Dec 2015 18:55:57 +0100
Message-ID: <1449165359-25832-6-git-send-email-philippe.longepe@linux.intel.com>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28380 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbbLCRzB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Dec 2015 12:55:01 -0500
In-Reply-To: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Stephane Gasparini <stephane.gasparini@linux.intel.com>

The current function to calculate business uses the ratio of actual
performance to max non turbo state requested during the last sample
period. This causes overestimation of busyness which results in higher
power consumption. This is a problem for low power systems.
The algorithm here uses cpu busyness to select next target P state.
The Percent Busy (or load) can be estimated as the ratio of the mperf
counter running at a constant frequency only during active periods (C0)
and the time stamp counter running at the same frequency but also during
idle. So,
Percent Busy = 100 * (delta_mperf / delta_tsc)
Use this algorithm for platforms with SoCs based on airmont and silvermont
cores.

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c2553a1..2cf8bb6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -143,6 +143,7 @@ struct cpu_defaults {
 };
 
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
+static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 
 static struct pstate_adjust_policy pid_params;
 static struct pstate_funcs pstate_funcs;
@@ -763,7 +764,7 @@ static struct cpu_defaults silvermont_params = {
 		.set = atom_set_pstate,
 		.get_scaling = silvermont_get_scaling,
 		.get_vid = atom_get_vid,
-		.get_target_pstate = get_target_pstate_use_performance,
+		.get_target_pstate = get_target_pstate_use_cpu_load,
 	},
 };
 
@@ -784,7 +785,7 @@ static struct cpu_defaults airmont_params = {
 		.set = atom_set_pstate,
 		.get_scaling = airmont_get_scaling,
 		.get_vid = atom_get_vid,
-		.get_target_pstate = get_target_pstate_use_performance,
+		.get_target_pstate = get_target_pstate_use_cpu_load,
 	},
 };
 
@@ -930,6 +931,26 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
+static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
+{
+	struct sample *sample = &cpu->sample;
+	int32_t cpu_load;
+
+	/*
+	 * The load can be estimated as the ratio of the mperf counter
+	 * running at a constant frequency during active periods
+	 * (C0) and the time stamp counter running at the same frequency
+	 * also during C-states.
+	 */
+	cpu_load = div64_u64(100 * sample->mperf, sample->tsc);
+
+	cpu->sample.busy_scaled = int_tofp(cpu_load);
+
+	return (cpu->pstate.current_pstate - pid_calc(&cpu->pid,
+						cpu->sample.busy_scaled));
+}
+
+
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 {
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
-- 
1.9.1

