From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH 4/5] intel_pstate: Compensate for intermediate durations (v2).
Date: Sat, 11 Apr 2015 21:10:29 -0700
Message-ID: <1428811830-15006-5-git-send-email-dsmythies@telus.net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35573 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbDLELZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2015 00:11:25 -0400
Received: by pabtp1 with SMTP id tp1so65119363pab.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2015 21:11:25 -0700 (PDT)
In-Reply-To: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-pm@vger.kernel.org

On the falling edge of lower frequency periodic loads the
duration is always longer than the rising edge. The result
is a tendancy for the average target pstate to end up a
little high due to what basically ends up as asymetric
weighting. Note that at some limit point a lower frequency
periodic load has to be considered as separate 100 percent load
followed by idle events.
This patch modifies the IIR filter gain as a function of
duration so as to more properly represent the longer duration
cases. In the limit the IIR filter history is flushed with the
new value.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 79 ++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0b38d17..66e662d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -788,7 +788,6 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 {
 	int64_t scaled_busy, max, min, nom;
-	u32 duration_us;
 
 	/*
 	 * The target pstate veres CPU load is adjusted
@@ -811,26 +810,6 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	min = div_u64(min * int_tofp(1000), nom);
 	nom = int_tofp(pid_params.c0_floor);
 
-	/*
-	 * Idle check.
-	 * Since we have a deferable timer, it will not fire unless
-	 * we are in the C0 state on a jiffy boundary.  Very long
-	 * durations can be either due to long idle (C0 time near 0),
-	 * or due to short idle times that spaned jiffy boundaries
-	 * (C0 time not near zreo).
-	 * The very long durations are 0.5 seconds or more.
-	 * The very low C0 threshold of 0.1 percent is arbitrary,
-	 * but it should be a small number.
-	 * recall that the units of core_pct_busy are tenths of a percent.
-	 * If prolonged idle is detected, then flush the IIR filter,
-	 * otherwise falling edge load response times can be on the order
-	 * of tens of seconds, because this driver runs very rarely.
-	 */
-	duration_us = (u32) ktime_us_delta(cpu->sample.time,
-					   cpu->last_sample_time);
-	if (duration_us > 500000 && cpu->sample.core_pct_busy < int_tofp(1))
-		cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
-
 	if (cpu->sample.core_pct_busy <= nom)
 		return (int32_t) 0;
 
@@ -850,7 +829,9 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	signed int ctl;
 	int from;
 	struct sample *sample;
-	int64_t max, min, nom, pmin, prange, scaled, target;
+	int64_t max, min, nom, pmin, prange, scaled, unfiltered_target;
+	u32 duration_us;
+	u32 sample_time;
 
 	from = cpu->pstate.current_pstate;
 
@@ -879,19 +860,57 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	min = div_u64(pmin * int_tofp(1000), nom);
 
 	if ((scaled - min) <= 0)
-		target = int_tofp(cpu->pstate.min_pstate);
+		unfiltered_target = int_tofp(cpu->pstate.min_pstate);
 	else
-		target = div_u64(prange * (scaled-min), (max - min)) + pmin;
+		unfiltered_target = div_u64(prange * (scaled-min),
+		(max - min)) + pmin;
+
+	/*
+	 * Idle check.
+	 * Since we have a deferable timer, it will not fire unless
+	 * we are in the C0 state on a jiffy boundary.  Very long
+	 * durations can be either due to long idle (C0 time near 0),
+	 * or due to short idle times that spaned jiffy boundaries
+	 * (C0 time not near zreo).
+	 * The very long durations are 0.5 seconds or more.
+	 * Recall that the units of core_pct_busy are tenths of a percent.
+	 * Either way, a very long duration will effectively flush
+	 * the IIR filter, otherwise falling edge load response times
+	 * can be on the order of tens of seconds, because this driver
+	 * runs very rarely. Furthermore, for higher periodic loads that
+	 * just so happen to not be in the C0 state on jiffy boundaries,
+	 * the long ago history should be forgotten.
+	 * For cases of durations that are a few times the set sample
+	 * period, increase the IIR filter gain so as to weight
+	 * the sample more appropriately.
+	 *
+	 * To Do: sample_time should be forced to be accurate. For
+	 * example if the kernel is a 250 Hz kernel, then a
+	 * sample_rate_ms of 10 should result in a sample_time of 12.
+	 */
+	sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
+	duration_us = (u32) ktime_us_delta(cpu->sample.time,
+		cpu->last_sample_time);
+	scaled = div_u64(int_tofp(duration_us) *
+		int_tofp(pid_params.p_gain_pct), int_tofp(sample_time));
+	if (scaled > int_tofp(100))
+		scaled = int_tofp(100);
+	/*
+	 * This code should not be required,
+	 * but short duration times have been observed
+	 */
+	if (scaled < int_tofp(pid_params.p_gain_pct))
+		scaled = int_tofp(pid_params.p_gain_pct);
+
 	/*
 	 * Bandwidth limit the output. Re-task p_gain_pct for this purpose.
 	 */
-	target = div_u64((int_tofp(100 - pid_params.p_gain_pct) *
-		cpu->sample.target + int_tofp(pid_params.p_gain_pct) *
-		target), int_tofp(100));
-	cpu->sample.target = target;
+	cpu->sample.target = div_u64((int_tofp(100) - scaled) *
+			cpu->sample.target + scaled *
+			unfiltered_target, int_tofp(100));
 
-	target = target + (1 << (FRAC_BITS-1));
-	intel_pstate_set_pstate(cpu, fp_toint(target));
+	intel_pstate_set_pstate(cpu, fp_toint(cpu->sample.target +
+			(1 << (FRAC_BITS-1))));
 
 	sample = &cpu->sample;
 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
-- 
1.9.1

