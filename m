From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Proportional algorithm for Atom
Date: Sun, 02 Oct 2016 19:03:43 +0200
Message-ID: <1565019.BFYQPSZAnN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PID algorithm used by the intel_pstate driver tends to drive
performance down too fast for lighter workloads, so replace it
with a modified "proportional" algorithm on Atom.

The new algorithm will set the new P-state to be 1.25 times the
available maximum times the (frequency-invariant) utilization during
the previous sampling period except when that utilization is lower
than the average performance ratio during the previous sampling
period.  In the latter case, it will increase the utilization by
50% of the difference between it and the performance ratio before
computing the target P-state to prevent performance from dropping
down too fast in some cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1231,9 +1231,10 @@ static inline int32_t get_avg_pstate(str
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
-	int32_t busy_frac, boost;
+	int32_t busy_frac, boost, avg_perf;
+	int target;
 
-	busy_frac = div_fp(sample->mperf, sample->tsc);
+	busy_frac = div_ext_fp(sample->mperf, sample->tsc);
 
 	boost = cpu->iowait_boost;
 	cpu->iowait_boost >>= 1;
@@ -1241,8 +1242,23 @@ static inline int32_t get_target_pstate_
 	if (busy_frac < boost)
 		busy_frac = boost;
 
-	sample->busy_scaled = busy_frac * 100;
-	return get_avg_pstate(cpu) - pid_calc(&cpu->pid, sample->busy_scaled);
+	/*
+	 * If the relative average performance ratio during the previous cycle
+	 * was higher than the current utilization, add 50% of the difference to
+	 * the utilization to reduce possible performance oscillations and
+	 * offset possible performance loss related to moving the workload from
+	 * one CPU to another withing a package/module.
+	 */
+	avg_perf = cpu->sample.core_avg_perf;
+	if (avg_perf > busy_frac)
+		busy_frac += (avg_perf - busy_frac) >> 1;
+
+	sample->busy_scaled = (busy_frac * 100) >> EXT_BITS;
+
+	target = limits->no_turbo || limits->turbo_disabled ?
+			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
+	target += target >> 2;
+	return mul_ext_fp(target, busy_frac);
 }
 
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
@@ -1317,7 +1333,7 @@ static inline void intel_pstate_adjust_b
 		sample->aperf,
 		sample->tsc,
 		get_avg_frequency(cpu),
-		fp_toint(cpu->iowait_boost * 100));
+		mul_ext_fp(cpu->iowait_boost, 100));
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
@@ -1328,7 +1344,7 @@ static void intel_pstate_update_util(str
 
 	if (pid_params.boost_iowait) {
 		if (flags & SCHED_CPUFREQ_IOWAIT) {
-			cpu->iowait_boost = int_tofp(1);
+			cpu->iowait_boost = int_tofp(1) << EXT_BITS;
 		} else if (cpu->iowait_boost) {
 			/* Clear iowait_boost if the CPU may have been idle. */
 			delta_ns = time - cpu->last_update;
