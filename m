From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 3/3] cpufreq: intel_pstate: Account for IO wait time
Date: Fri,  4 Dec 2015 17:40:35 +0100
Message-ID: <1449247235-29389-8-git-send-email-philippe.longepe@linux.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59932 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374AbbLDQku (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 11:40:50 -0500
In-Reply-To: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>, Stephane Gasparini <stephane.gasparini@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

In cases where we have many IOs, the global load becomes low and the
load algorithm will decrease the requested P-State. Because of that,
the IOs overheads will increase and impact the IO performances.

To improve IO bound work, we can count the io-wait time as busy time
in calculating CPU busy.

This change uses get_cpu_iowait_time_us() to obtain the IO wait time value
and converts time into number of cycles spent waiting on IO at the TSC
rate. At the moment, this trick is only used for Atom.

Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c8437861..6964df9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -113,6 +113,7 @@ struct cpudata {
 	u64	prev_aperf;
 	u64	prev_mperf;
 	u64	prev_tsc;
+	u64	prev_cummulative_iowait;
 	struct sample sample;
 };
 
@@ -933,22 +934,39 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
+	u64 cummulative_iowait, delta_iowait_us;
+	u64 delta_iowait_mperf;
+	u64 mperf, now;
 	int32_t cpu_load;
 
+	cummulative_iowait = get_cpu_iowait_time_us(cpu->cpu, &now);
+
+	/*
+	 * Convert iowait time into number of IO cycles spent at max_freq.
+	 * IO is considered as busy only for the cpu_load algorithm. For
+	 * performance this is not needed since we always try to reach the
+	 * maximum P-State, so we are already boosting the IOs.
+	 */
+	delta_iowait_us = cummulative_iowait - cpu->prev_cummulative_iowait;
+	delta_iowait_mperf = div64_u64(delta_iowait_us * cpu->pstate.scaling *
+		cpu->pstate.max_pstate, MSEC_PER_SEC);
+
+	mperf = cpu->sample.mperf + delta_iowait_mperf;
+	cpu->prev_cummulative_iowait = cummulative_iowait;
+
+
 	/*
 	 * The load can be estimated as the ratio of the mperf counter
 	 * running at a constant frequency during active periods
 	 * (C0) and the time stamp counter running at the same frequency
 	 * also during C-states.
 	 */
-	cpu_load = div64_u64(int_tofp(100) * sample->mperf, sample->tsc);
-
+	cpu_load = div64_u64(int_tofp(100) * mperf, sample->tsc);
 	cpu->sample.busy_scaled = cpu_load;
 
 	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, cpu_load);
 }
 
-
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 {
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
-- 
1.9.1

