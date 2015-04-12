From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH 2/5] intel_pstate: Use C0 time for busy calculations (again).
Date: Sat, 11 Apr 2015 21:10:27 -0700
Message-ID: <1428811830-15006-3-git-send-email-dsmythies@telus.net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32925 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbDLELM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2015 00:11:12 -0400
Received: by paboj16 with SMTP id oj16so65263869pab.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2015 21:11:11 -0700 (PDT)
In-Reply-To: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-pm@vger.kernel.org

This patch brings back the inclusion of C0 time
for the calculation of core_busy.
scaled_busy ultimatley defines the target pstate
(CPU frequency) verses load (C0) response curve.
The target pstate will be held at minimum until the load
is larger than the c0_floor. Thereafter, the response
is roughly linear until the maximum target pstate is
reached at the c0_ceiling.
A larger co_floor and lesser c0_ceiling tends towards
minimum energy, at a cost of performance and slower rising
edge load response times. A lesser c0_floor and larger
c0_ceiling tends towards more energy consumption, but
better performance and faster rising edge load response
times. Note, for falling edge loads, response times are
dominated by durations, and this driver runs very rarely.
c0_floor and c0_ceiling are available in the debugfs.
c0_floor and c0_ceiling are in units of tenths of a percent.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 Documentation/cpu-freq/intel-pstate.txt |  2 +
 drivers/cpufreq/intel_pstate.c          | 87 +++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index 6557507..583a048 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -56,6 +56,8 @@ For legacy mode debugfs files have also been added to allow tuning of
 the internal governor algorythm. These files are located at
 /sys/kernel/debug/pstate_snb/ These files are NOT present in HWP mode.
 
+      c0_ceiling
+      c0_floor
       deadband
       d_gain_pct
       i_gain_pct
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f181ce5..ddc3602 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -121,6 +121,8 @@ struct pstate_adjust_policy {
 	int p_gain_pct;
 	int d_gain_pct;
 	int i_gain_pct;
+	int c0_ceiling;
+	int c0_floor;
 };
 
 struct pstate_funcs {
@@ -313,6 +315,8 @@ static struct pid_param pid_files[] = {
 	{"deadband", &pid_params.deadband},
 	{"setpoint", &pid_params.setpoint},
 	{"p_gain_pct", &pid_params.p_gain_pct},
+	{"c0_ceiling", &pid_params.c0_ceiling},
+	{"c0_floor", &pid_params.c0_floor},
 	{NULL, NULL}
 };
 
@@ -624,6 +628,8 @@ static struct cpu_defaults core_params = {
 		.p_gain_pct = 20,
 		.d_gain_pct = 0,
 		.i_gain_pct = 0,
+		.c0_ceiling = 950,
+		.c0_floor = 450,
 	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
@@ -642,6 +648,8 @@ static struct cpu_defaults byt_params = {
 		.p_gain_pct = 14,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
+		.c0_ceiling = 950,
+		.c0_floor = 450,
 	},
 	.funcs = {
 		.get_max = byt_get_max_pstate,
@@ -720,6 +728,14 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 			cpu->pstate.max_pstate * cpu->pstate.scaling / 100),
 			core_pct));
 
+	core_pct = int_tofp(sample->mperf) * int_tofp(1000);
+	core_pct = div64_u64(core_pct, int_tofp(sample->tsc));
+
+	/*
+	 * Basically CO (or load) has been calculated
+	 * in units of tenths of a percent
+	*/
+
 	sample->core_pct_busy = (int32_t)core_pct;
 }
 
@@ -769,43 +785,60 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 
 static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 {
-	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
+	int64_t scaled_busy, max, min, nom;
 	u32 duration_us;
-	u32 sample_time;
 
 	/*
-	 * core_busy is the ratio of actual performance to max
-	 * max_pstate is the max non turbo pstate available
-	 * current_pstate was the pstate that was requested during
-	 * 	the last sample period.
+	 * The target pstate veres CPU load is adjusted
+	 * as per the desired floor and ceiling values.
+	 * this is a simple y = mx + b line defined by
+	 * c0_floor results in minimum pstate percent
+	 * c0_ceiling results in maximum pstate percent
 	 *
-	 * We normalize core_busy, which was our actual percent
-	 * performance to what we requested during the last sample
-	 * period. The result will be a percentage of busy at a
-	 * specified pstate.
+	 * carry an extra digit herein.
 	 */
-	core_busy = cpu->sample.core_pct_busy;
-	max_pstate = int_tofp(cpu->pstate.max_pstate);
-	current_pstate = int_tofp(cpu->pstate.current_pstate);
-	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
+
+	if (limits.no_turbo || limits.turbo_disabled)
+		max = int_tofp(cpu->pstate.max_pstate);
+	else
+		max = int_tofp(cpu->pstate.turbo_pstate);
+
+	nom = int_tofp(cpu->pstate.max_pstate);
+	min = int_tofp(cpu->pstate.min_pstate);
+	max = div_u64(max * int_tofp(1000), nom);
+	min = div_u64(min * int_tofp(1000), nom);
+	nom = int_tofp(pid_params.c0_floor);
 
 	/*
-	 * Since we have a deferred timer, it will not fire unless
-	 * we are in C0.  So, determine if the actual elapsed time
-	 * is significantly greater (3x) than our sample interval.  If it
-	 * is, then we were idle for a long enough period of time
-	 * to adjust our busyness.
+	 * Idle check.
+	 * Since we have a deferable timer, it will not fire unless
+	 * we are in the C0 state on a jiffy boundary.  Very long
+	 * durations can be either due to long idle (C0 time near 0),
+	 * or due to short idle times that spaned jiffy boundaries
+	 * (C0 time not near zreo).
+	 * The very long durations are 0.5 seconds or more.
+	 * The very low C0 threshold of 0.1 percent is arbitrary,
+	 * but it should be a small number.
+	 * recall that the units of core_pct_busy are tenths of a percent.
+	 *
+	 * Note: the use of this calculation will become clear in the next patch
 	 */
-	sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
 	duration_us = (u32) ktime_us_delta(cpu->sample.time,
 					   cpu->last_sample_time);
-	if (duration_us > sample_time * 3) {
-		sample_ratio = div_fp(int_tofp(sample_time),
-				      int_tofp(duration_us));
-		core_busy = mul_fp(core_busy, sample_ratio);
-	}
+	if (duration_us > 500000 && cpu->sample.core_pct_busy < int_tofp(1))
+		return (int32_t) 0;
+
+	if (cpu->sample.core_pct_busy <= nom)
+		return (int32_t) 0;
+
+	scaled_busy = div_u64((max - min) * (cpu->sample.core_pct_busy - nom),
+		(int_tofp(pid_params.c0_ceiling) - nom)) + min;
+
+	/*
+	 * Return an extra digit, tenths of a percent.
+	 */
+	return (int32_t) scaled_busy;
 
-	return core_busy;
 }
 
 static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
@@ -1065,6 +1098,8 @@ static void copy_pid_params(struct pstate_adjust_policy *policy)
 	pid_params.d_gain_pct = policy->d_gain_pct;
 	pid_params.deadband = policy->deadband;
 	pid_params.setpoint = policy->setpoint;
+	pid_params.c0_ceiling = policy->c0_ceiling;
+	pid_params.c0_floor = policy->c0_floor;
 }
 
 static void copy_cpu_funcs(struct pstate_funcs *funcs)
-- 
1.9.1

