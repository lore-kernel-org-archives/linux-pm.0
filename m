From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V5 3/3] cpufreq: intel_pstate: Account for IO wait time
Date: Thu,  3 Dec 2015 18:55:59 +0100
Message-ID: <1449165359-25832-8-git-send-email-philippe.longepe@linux.intel.com>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28380 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbbLCRzE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Dec 2015 12:55:04 -0500
In-Reply-To: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Stephane Gasparini <stephane.gasparini@intel.com>, Philippe Longepe <philippe.longepe@intel.com>

From: Stephane Gasparini <stephane.gasparini@intel.com>

To improve IO bound work, account IO wait time in calculating
CPU busy. This change gets IO wait time using get_cpu_iowait_time_us,
and converts time into number of IO cycles spent at max non turbo
frequency. This IO cycle count is added to mperf value to account
for IO wait time.

Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2cf8bb6..fb92402 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -114,6 +114,7 @@ struct cpudata {
 	u64	prev_mperf;
 	u64	prev_tsc;
 	struct sample sample;
+	u64 prev_cummulative_iowait;
 };
 
 static struct cpudata **all_cpu_data;
@@ -934,16 +935,28 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
+	u64 cummulative_iowait, delta_iowait_us;
+	u64 delta_iowait_mperf;
+	u64 mperf, now;
 	int32_t cpu_load;
 
+	cummulative_iowait = get_cpu_iowait_time_us(cpu->cpu, &now);
+
+	/* Convert iowait time into number of IO cycles spent at max_freq */
+	delta_iowait_us = cummulative_iowait - cpu->prev_cummulative_iowait;
+	delta_iowait_mperf = div64_u64(delta_iowait_us * cpu->pstate.scaling *
+		cpu->pstate.max_pstate, 1000);
+
+	mperf = cpu->sample.mperf + delta_iowait_mperf;
+	cpu->prev_cummulative_iowait = cummulative_iowait;
+
 	/*
 	 * The load can be estimated as the ratio of the mperf counter
 	 * running at a constant frequency during active periods
 	 * (C0) and the time stamp counter running at the same frequency
 	 * also during C-states.
 	 */
-	cpu_load = div64_u64(100 * sample->mperf, sample->tsc);
-
+	cpu_load = div64_u64(100 * mperf, sample->tsc);
 	cpu->sample.busy_scaled = int_tofp(cpu_load);
 
 	return (cpu->pstate.current_pstate - pid_calc(&cpu->pid,
-- 
1.9.1

