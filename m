From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 3/4] cpufreq: intel_pstate: Use average P-state in get_target_pstate_default()
Date: Sat, 03 Sep 2016 03:03:35 +0200
Message-ID: <4068903.sPRXPKuvpJ@vostro.rjw.lan>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59398 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752625AbcICA7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2016 20:59:15 -0400
In-Reply-To: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <doug.smythies@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adjust the next P-state formula in get_target_pstate_default()
(in the filtered case) to use the average P-state as given by
the APERF and MPERF feedback registers instead of the exact
P-state requested previously, as that request might not be
granted.

Suggested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -98,7 +98,6 @@ static inline u64 div_ext_fp(u64 x, u64
  * @tsc:		Difference of time stamp counter between last and
  *			current sample
  * @time:		Current time from scheduler
- * @target:		Target P-state
  *
  * This structure is used in the cpudata structure to store performance sample
  * data for choosing next P State.
@@ -110,7 +109,6 @@ struct sample {
 	u64 mperf;
 	u64 tsc;
 	u64 time;
-	int target;
 };
 
 /**
@@ -1149,7 +1147,6 @@ static void intel_pstate_set_min_pstate(
 
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
 	cpu->pstate.current_pstate = pstate;
-	cpu->sample.target = pstate;
 	/*
 	 * Generally, there is no guarantee that this code will always run on
 	 * the CPU being updated, so force the register update to run on the
@@ -1305,8 +1302,8 @@ static inline int32_t get_target_pstate_
 {
 	struct sample *sample = &cpu->sample;
 	int32_t busy_frac, boost;
-	int pstate, max_perf, min_perf;
 	int64_t target;
+	int pstate;
 
 	pstate = limits->no_turbo || limits->turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
@@ -1341,17 +1338,20 @@ static inline int32_t get_target_pstate_
 		 * Take the raw gain as 1/8 and compute the effective gain as
 		 *
 		 *	iir_gain = 1/8 * delta_t / sampling_interval
+		 *
+		 * Moreover, since the output is a request that may or may not
+		 * be granted (depending on what the other CPUs are doing, for
+		 * example), instead of using the output value obtained
+		 * previously in the computation, use the effective average
+		 * P-state since the last pass as given by APERF and MPERF.
 		 */
 		iir_gain = div_fp(sample->time - cpu->last_sample_time,
 				  pid_params.sample_rate_ns << 3);
 		if (iir_gain < int_tofp(1))
-			target = sample->target * (int_tofp(1) - iir_gain) +
+			target = get_avg_pstate(cpu) * (int_tofp(1) - iir_gain) +
 					mul_fp(target, iir_gain);
 	}
-	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
-	target = clamp_val(target, int_tofp(min_perf), int_tofp(max_perf));
-	sample->target = fp_toint(target + (1 << (FRAC_BITS-1)));
-	return sample->target;
+	return fp_toint(target + (1 << (FRAC_BITS-1)));
 }
 
 static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)

