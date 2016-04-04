From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Avoid pointless FRAC_BITS shifts under div_fp()
Date: Mon, 04 Apr 2016 03:31:50 +0200
Message-ID: <1686698.Q1MpTgeaeN@vostro.rjw.lan>
References: <1928830.Q6zNtE60bQ@vostro.rjw.lan> <56FE26EB.7090608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47317 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751018AbcDDB3X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2016 21:29:23 -0400
In-Reply-To: <56FE26EB.7090608@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, April 01, 2016 09:44:43 AM Philippe Longepe wrote:
> I proposed also to simplify the intel_pstate_calc_busy function:
> 
>      core_pct = int_tofp(sample->aperf) * int_tofp(100);
>      core_pct = div64_u64(core_pct, int_tofp(sample->mperf));
> 
> is equivalent to:
> 
>      core_pct = sample->aperf * int_tofp(100);
>      core_pct = div64_u64(core_pct, sample->mperf);

Right, this can be done too.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] intel_pstate: Avoid pointless FRAC_BITS shifts under div_fp()

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
 drivers/cpufreq/intel_pstate.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

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
@@ -876,8 +874,8 @@ static inline void intel_pstate_calc_bus
 	struct sample *sample = &cpu->sample;
 	int64_t core_pct;
 
-	core_pct = int_tofp(sample->aperf) * int_tofp(100);
-	core_pct = div64_u64(core_pct, int_tofp(sample->mperf));
+	core_pct = sample->aperf * int_tofp(100);
+	core_pct = div64_u64(core_pct, sample->mperf);
 
 	sample->core_pct_busy = (int32_t)core_pct;
 }
@@ -980,8 +978,8 @@ static inline int32_t get_target_pstate_
 	 * specified pstate.
 	 */
 	core_busy = cpu->sample.core_pct_busy;
-	max_pstate = int_tofp(cpu->pstate.max_pstate_physical);
-	current_pstate = int_tofp(cpu->pstate.current_pstate);
+	max_pstate = cpu->pstate.max_pstate_physical;
+	current_pstate = cpu->pstate.current_pstate;
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 
 	/*
@@ -992,8 +990,7 @@ static inline int32_t get_target_pstate_
 	 */
 	duration_ns = cpu->sample.time - cpu->last_sample_time;
 	if ((s64)duration_ns > pid_params.sample_rate_ns * 3) {
-		sample_ratio = div_fp(int_tofp(pid_params.sample_rate_ns),
-				      int_tofp(duration_ns));
+		sample_ratio = div_fp(pid_params.sample_rate_ns, duration_ns);
 		core_busy = mul_fp(core_busy, sample_ratio);
 	}
 
@@ -1176,10 +1173,8 @@ static int intel_pstate_set_policy(struc
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

