From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Avoid pointless FRAC_BITS shifts under div_fp()
Date: Thu, 31 Mar 2016 15:46:22 +0200
Message-ID: <1928830.Q6zNtE60bQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44049 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757186AbcCaNoA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 09:44:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are multiple places in intel_pstate where int_tofp() is applied
to both arguments of div_fp(), but this is pointless, because int_tofp()
simply shifts its argument to the left by FRAC_BITS which mathematically
is equivalent to multuplication by 2^FRAC_BITS, so if this is done
to both arguments of a division, the extra factors will cancel each
other during that operation anyway.

Drop the pointless int_tofp() applied to div_fp() arguments throughout
the driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -206,17 +206,17 @@ static inline void pid_reset(struct _pid
 
 static inline void pid_p_gain_set(struct _pid *pid, int percent)
 {
-	pid->p_gain = div_fp(int_tofp(percent), int_tofp(100));
+	pid->p_gain = div_fp(percent, 100);
 }
 
 static inline void pid_i_gain_set(struct _pid *pid, int percent)
 {
-	pid->i_gain = div_fp(int_tofp(percent), int_tofp(100));
+	pid->i_gain = div_fp(percent, 100);
 }
 
 static inline void pid_d_gain_set(struct _pid *pid, int percent)
 {
-	pid->d_gain = div_fp(int_tofp(percent), int_tofp(100));
+	pid->d_gain = div_fp(percent, 100);
 }
 
 static signed int pid_calc(struct _pid *pid, int32_t busy)
@@ -394,7 +394,7 @@ static ssize_t show_turbo_pct(struct kob
 
 	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
 	no_turbo = cpu->pstate.max_pstate - cpu->pstate.min_pstate + 1;
-	turbo_fp = div_fp(int_tofp(no_turbo), int_tofp(total));
+	turbo_fp = div_fp(no_turbo, total);
 	turbo_pct = 100 - fp_toint(mul_fp(turbo_fp, int_tofp(100)));
 	return sprintf(buf, "%u\n", turbo_pct);
 }
@@ -465,8 +465,7 @@ static ssize_t store_max_perf_pct(struct
 				   limits->max_perf_pct);
 	limits->max_perf_pct = max(limits->min_perf_pct,
 				   limits->max_perf_pct);
-	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
-				  int_tofp(100));
+	limits->max_perf = div_fp(limits->max_perf_pct, 100);
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
@@ -490,8 +489,7 @@ static ssize_t store_min_perf_pct(struct
 				   limits->min_perf_pct);
 	limits->min_perf_pct = min(limits->max_perf_pct,
 				   limits->min_perf_pct);
-	limits->min_perf = div_fp(int_tofp(limits->min_perf_pct),
-				  int_tofp(100));
+	limits->min_perf = div_fp(limits->min_perf_pct, 100);
 
 	if (hwp_active)
 		intel_pstate_hwp_set_online_cpus();
@@ -973,8 +971,8 @@ static inline int32_t get_target_pstate_
 	 * specified pstate.
 	 */
 	core_busy = cpu->sample.core_pct_busy;
-	max_pstate = int_tofp(cpu->pstate.max_pstate_physical);
-	current_pstate = int_tofp(cpu->pstate.current_pstate);
+	max_pstate = cpu->pstate.max_pstate_physical;
+	current_pstate = cpu->pstate.current_pstate;
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 
 	/*
@@ -986,8 +984,7 @@ static inline int32_t get_target_pstate_
 	duration_ns = cpu->sample.time - cpu->last_sample_time;
 	if ((s64)duration_ns > pid_params.sample_rate_ns * 3
 	    && cpu->last_sample_time > 0) {
-		sample_ratio = div_fp(int_tofp(pid_params.sample_rate_ns),
-				      int_tofp(duration_ns));
+		sample_ratio = div_fp(pid_params.sample_rate_ns, duration_ns);
 		core_busy = mul_fp(core_busy, sample_ratio);
 	}
 
@@ -1167,10 +1164,8 @@ static int intel_pstate_set_policy(struc
 	/* Make sure min_perf_pct <= max_perf_pct */
 	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
 
-	limits->min_perf = div_fp(int_tofp(limits->min_perf_pct),
-				  int_tofp(100));
-	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
-				  int_tofp(100));
+	limits->min_perf = div_fp(limits->min_perf_pct, 100);
+	limits->max_perf = div_fp(limits->max_perf_pct, 100);
 
  out:
 	intel_pstate_set_update_util_hook(policy->cpu);

