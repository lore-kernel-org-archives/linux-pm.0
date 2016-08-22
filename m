From: Doug Smythies <doug.smythies@gmail.com>
Subject: [RFC][PATCH 8 of 7] cpufreq: intel_pstate: add iir filter to pstate.
Date: Mon, 22 Aug 2016 16:11:33 -0700
Message-ID: <1471907493-26639-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35697 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932846AbcHVXNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 19:13:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id h186so7074652pfg.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2016 16:12:07 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>

Note: This is not a formal version of this patch, but rather
an interim version.

As a function of load / sleep frequency and how it beats
against this drivers sampling times, the driver has a
tendency to be underdamped and to oscillate, requiring
a bandwidth limiting filter on the target PState.
Add a simple IIR (Infinite Impulse Response) type filter
to the target PState.
The purpose is to dampen the inherent oscillations caused by a
sampled system that can have measured load extremes in any
given sample. The /sys/kernel/debug/pstate_snb/p_gain_pct has
been temporarily re-tasked to be the gain for this filter.
Optimal nominal gain setting is a tradeoff between response time
and adequate damping. Since the time between runs of this driver
are so extreme, the gain is adjusted as a function of the time
since the last pass so as to reduce, or even eliminate, the influence
of what might be a very stale old value.
The default gain is 10 percent.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 92 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c43ef55..ab5c004 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -98,6 +98,7 @@ static inline u64 div_ext_fp(u64 x, u64 y)
  * @tsc:		Difference of time stamp counter between last and
  *			current sample
  * @time:		Current time from scheduler
+ * @target:		target pstate filtered.
  *
  * This structure is used in the cpudata structure to store performance sample
  * data for choosing next P State.
@@ -108,6 +109,7 @@ struct sample {
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
+	u64 target;
 	u64 time;
 };
 
@@ -1021,7 +1023,7 @@ static struct cpu_defaults core_params = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
 		.setpoint = 97,
-		.p_gain_pct = 20,
+		.p_gain_pct = 10,
 		.d_gain_pct = 0,
 		.i_gain_pct = 0,
 		.boost_iowait = true,
@@ -1168,6 +1170,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		pstate_funcs.get_vid(cpu);
 
 	intel_pstate_set_min_pstate(cpu);
+	cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
 }
 
 static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
@@ -1301,8 +1304,10 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 static inline int32_t get_target_pstate_default(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
+	int64_t scaled_gain, unfiltered_target;
 	int32_t busy_frac;
 	int pstate;
+	u64 duration_ns;
 
 	busy_frac = div_fp(sample->mperf, sample->tsc);
 	sample->busy_scaled = busy_frac * 100;
@@ -1313,7 +1318,89 @@ static inline int32_t get_target_pstate_default(struct cpudata *cpu)
 	cpu->iowait_boost >>= 1;
 
 	pstate = cpu->pstate.turbo_pstate;
-	return fp_toint((pstate + (pstate >> 2)) * busy_frac);
+	/* To Do: I think the above should be:
+	 *
+	 * if (limits.no_turbo || limits.turbo_disabled)
+	 *	pstate = cpu->pstate.max_pstate;
+	 * else
+	 *	pstate = cpu->pstate.turbo_pstate;
+	 *
+	 * figure it out.
+	 *
+	 * no clamps. Pre-filter clamping was needed in past implementations.
+	 * To Do: Is any pre-filter clamping needed here? */
+
+	unfiltered_target = (pstate + (pstate >> 2)) * busy_frac;
+
+	/*
+	 * Idle check.
+	 * We have a deferrable timer. Very long durations can be
+	 * either due to long idle (C0 time near 0),
+	 * or due to short idle times that spanned jiffy boundaries
+	 * (C0 time not near zero).
+	 *
+	 * To Do: As of the utilization stuff, I do not think the the
+	 * spanning jiffy boundaries thing is true anymore.
+	 * Check, and fix the comment.
+	 *
+	 * The very long durations are 0.4 seconds or more.
+	 * Either way, a very long duration will effectively flush
+	 * the IIR filter, otherwise falling edge load response times
+	 * can be on the order of tens of seconds, because this driver
+	 * runs very rarely. Furthermore, for higher periodic loads that
+	 * just so happen to not be in the C0 state on jiffy boundaries,
+	 * the long ago history should be forgotten.
+	 * For cases of durations that are a few times the set sample
+	 * period, increase the IIR filter gain so as to weight
+	 * the current sample more appropriately.
+	 *
+	 * To Do: sample_time should be forced to be accurate. For
+	 * example if the kernel is a 250 Hz kernel, then a
+	 * sample_rate_ms of 10 should result in a sample_time of 12.
+	 *
+	 * To Do: Check that the IO Boost case is not filtered too much.
+	 *	  It might be that a filter by-pass is needed for the boost case.
+	 *	  However, the existing gain = f(duration) might be good enough.
+	 *
+	 * Bandwidth limit the output. For now, re-task p_gain_pct for this purpose.
+	 * Use a smple IIR (Infinite Impulse Response) filter.
+	 *
+	 * scale the gain as a function of the time since the last run of this driver.
+	 * For example, if the time since the last run is 5 times nominal, then the
+	 * scaled gain is 5 times nominal.
+	 * scaled_gain = gain * duration / nominal
+	 */
+
+	duration_ns = cpu->sample.time - cpu->last_sample_time;
+
+	scaled_gain = div_u64(int_tofp(duration_ns) *
+		(pid_params.p_gain_pct), (pid_params.sample_rate_ns));
+	if (scaled_gain > int_tofp(100))
+		scaled_gain = int_tofp(100);
+	/*
+	 * This code should not be required,
+	 * but short duration times have been observed
+	 * To Do: Check if this code is actually still needed. I don't think so.
+	 */
+	if (scaled_gain < int_tofp(pid_params.p_gain_pct))
+		scaled_gain = int_tofp(pid_params.p_gain_pct);
+
+	/*
+	 * Actual IIR filter:
+	 * new output = old output * (1 - gain) + input * gain
+	 *
+	 * To Do: Often the actual pstate the system ran at over the last
+	 * 	  interval is not what was asked for, due to influence from
+	 *	  other CPUs. It might make sense to use the average pstate
+	 *	  (get_avg_pstate) as the old_output here (as per previous
+	 *	  work by Philippe Longepe and Stephane Gasparini on the
+	 *	  get_target_pstate_use_cpu_load method). Test it.
+	 */
+	cpu->sample.target = div_u64((int_tofp(100) - scaled_gain) *
+			cpu->sample.target + scaled_gain *
+			unfiltered_target, int_tofp(100));
+
+	return fp_toint(cpu->sample.target + (1 << (FRAC_BITS-1)));
 }
 
 static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
@@ -1579,6 +1666,7 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 		return;
 
 	intel_pstate_set_min_pstate(cpu);
+	cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
 }
 
 static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
-- 
2.7.4

