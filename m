From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH 3/5] intel_pstate: Calculate target pstate directly.
Date: Sat, 11 Apr 2015 21:10:28 -0700
Message-ID: <1428811830-15006-4-git-send-email-dsmythies@telus.net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34949 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbDLELS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2015 00:11:18 -0400
Received: by pddn5 with SMTP id n5so68199826pdd.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2015 21:11:18 -0700 (PDT)
In-Reply-To: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-pm@vger.kernel.org

This patch eliminates the use of the PID controller
and calculates the target pstate directly.
This driver is subject to many complex situations,
beat frequencies and enormous variations in sample
time periods. It is not best suited to PID control.
In signal processing, derivatives are difficult at
the best of times, additionally so with  the extremely
variable sampling times, and the load / sleep sampling
interactions (beat frequencies).
For the integral term, this isn't really an integrate
and eventually null out the error scenario.
The remaining proportinal term can be better handled with
a different type of filter.
The PID driver, with fractional gains, also gets into
tradeoff difficutlites between setpoint, optimal gain
settings and finite integer arthimetic.
For now, the PID code, and a dummy call to it, remains.
Calculate the target pstate directly and add a simple
IIR output filter to the target PState.
As a function of load / sleep frequency and how it beats
against this drivers sampling times, the driver has a
tendency to be underdamped and to oscillate, requiring
a bandwidth limiting filter on the target PState.
It is a simple IIR (Infinite Impulse Response) type filter with the
purpose of damping down the inherent oscillations caused by a
sampled system that can have measured loads extremes in any
given sample. The /sys/kernel/debug/pstate_snb/p_gain_pct has
been re-tasked to be the gain for this filter. Optimal gain
setting is a tradeoff between response time and adequate
damping. The idle check flushes the filter if required,
as do the initialization routines.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ddc3602..0b38d17 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -68,6 +68,7 @@ struct sample {
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
+	u64 target;
 	int freq;
 	ktime_t time;
 };
@@ -645,7 +646,7 @@ static struct cpu_defaults byt_params = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
 		.setpoint = 97,
-		.p_gain_pct = 14,
+		.p_gain_pct = 20,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
 		.c0_ceiling = 950,
@@ -713,6 +714,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
+	cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
 }
 
 static inline void intel_pstate_calc_busy(struct cpudata *cpu)
@@ -820,13 +822,14 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	 * The very low C0 threshold of 0.1 percent is arbitrary,
 	 * but it should be a small number.
 	 * recall that the units of core_pct_busy are tenths of a percent.
-	 *
-	 * Note: the use of this calculation will become clear in the next patch
+	 * If prolonged idle is detected, then flush the IIR filter,
+	 * otherwise falling edge load response times can be on the order
+	 * of tens of seconds, because this driver runs very rarely.
 	 */
 	duration_us = (u32) ktime_us_delta(cpu->sample.time,
 					   cpu->last_sample_time);
 	if (duration_us > 500000 && cpu->sample.core_pct_busy < int_tofp(1))
-		return (int32_t) 0;
+		cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
 
 	if (cpu->sample.core_pct_busy <= nom)
 		return (int32_t) 0;
@@ -838,7 +841,6 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	 * Return an extra digit, tenths of a percent.
 	 */
 	return (int32_t) scaled_busy;
-
 }
 
 static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
@@ -848,16 +850,48 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	signed int ctl;
 	int from;
 	struct sample *sample;
+	int64_t max, min, nom, pmin, prange, scaled, target;
 
 	from = cpu->pstate.current_pstate;
 
 	pid = &cpu->pid;
 	busy_scaled = intel_pstate_get_scaled_busy(cpu);
 
+	scaled = (int64_t) busy_scaled;
+
+	/*
+	 * a null, for now. Will be removed in a future patch.
+	 * strictly: ctl = pid_calc(pid, busy_scaled / 10);
+	 * but it now a temp dummy call, so do not waste
+	 * the divide clock cycles.
+	 */
 	ctl = pid_calc(pid, busy_scaled);
 
-	/* Negative values of ctl increase the pstate and vice versa */
-	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
+	if (limits.no_turbo || limits.turbo_disabled)
+		max = int_tofp(cpu->pstate.max_pstate);
+	else
+		max = int_tofp(cpu->pstate.turbo_pstate);
+
+	pmin = int_tofp(cpu->pstate.min_pstate);
+	prange = max - pmin;
+	nom = int_tofp(cpu->pstate.max_pstate);
+	max = div_u64(max * int_tofp(1000), nom);
+	min = div_u64(pmin * int_tofp(1000), nom);
+
+	if ((scaled - min) <= 0)
+		target = int_tofp(cpu->pstate.min_pstate);
+	else
+		target = div_u64(prange * (scaled-min), (max - min)) + pmin;
+	/*
+	 * Bandwidth limit the output. Re-task p_gain_pct for this purpose.
+	 */
+	target = div_u64((int_tofp(100 - pid_params.p_gain_pct) *
+		cpu->sample.target + int_tofp(pid_params.p_gain_pct) *
+		target), int_tofp(100));
+	cpu->sample.target = target;
+
+	target = target + (1 << (FRAC_BITS-1));
+	intel_pstate_set_pstate(cpu, fp_toint(target));
 
 	sample = &cpu->sample;
 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
@@ -1020,6 +1054,7 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 		return;
 
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
+	cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
 }
 
 static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
-- 
1.9.1

