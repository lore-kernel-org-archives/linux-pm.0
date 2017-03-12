From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 05/14] cpufreq: intel_pstate: Clean up intel_pstate_busy_pid_reset()
Date: Sun, 12 Mar 2017 18:16:45 +0100
Message-ID: <1538192.VSKEjOmrrl@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51182 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934664AbdCLRcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:42 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

intel_pstate_busy_pid_reset() is the only caller of pid_reset(),
pid_p_gain_set(), pid_i_gain_set(), and pid_d_gain_set().  Moreover,
it passes constatns as two parameters of pid_reset() and all of
the other routines above essentially contain the same code, so
fold all of them into the caller and drop unnecessary computations.

Introduce percent_fp() for converting integer values in percent
to fixed-point fractions and use it in the above code cleanup.

Finally, rename intel_pstate_busy_pid_reset() to
intel_pstate_pid_reset() as it also is used for the
initialization of PID parameters for every CPU and the
meaning of the "busy" part of the name is not particularly
clear.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   46 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -79,6 +79,11 @@ static inline int ceiling_fp(int32_t x)
 	return ret;
 }
 
+static inline int32_t percent_fp(int percent)
+{
+	return div_fp(percent, 100);
+}
+
 static inline u64 mul_ext_fp(u64 x, u64 y)
 {
 	return (x * y) >> EXT_FRAC_BITS;
@@ -547,29 +552,6 @@ static inline void intel_pstate_exit_per
 }
 #endif
 
-static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
-			     int deadband, int integral) {
-	pid->setpoint = int_tofp(setpoint);
-	pid->deadband  = int_tofp(deadband);
-	pid->integral  = int_tofp(integral);
-	pid->last_err  = int_tofp(setpoint) - int_tofp(busy);
-}
-
-static inline void pid_p_gain_set(struct _pid *pid, int percent)
-{
-	pid->p_gain = div_fp(percent, 100);
-}
-
-static inline void pid_i_gain_set(struct _pid *pid, int percent)
-{
-	pid->i_gain = div_fp(percent, 100);
-}
-
-static inline void pid_d_gain_set(struct _pid *pid, int percent)
-{
-	pid->d_gain = div_fp(percent, 100);
-}
-
 static signed int pid_calc(struct _pid *pid, int32_t busy)
 {
 	signed int result;
@@ -607,13 +589,17 @@ static signed int pid_calc(struct _pid *
 	return (signed int)fp_toint(result);
 }
 
-static inline void intel_pstate_busy_pid_reset(struct cpudata *cpu)
+static inline void intel_pstate_pid_reset(struct cpudata *cpu)
 {
-	pid_p_gain_set(&cpu->pid, pid_params.p_gain_pct);
-	pid_d_gain_set(&cpu->pid, pid_params.d_gain_pct);
-	pid_i_gain_set(&cpu->pid, pid_params.i_gain_pct);
+	struct _pid *pid = &cpu->pid;
 
-	pid_reset(&cpu->pid, pid_params.setpoint, 100, pid_params.deadband, 0);
+	pid->p_gain = percent_fp(pid_params.p_gain_pct);
+	pid->d_gain = percent_fp(pid_params.d_gain_pct);
+	pid->i_gain = percent_fp(pid_params.i_gain_pct);
+	pid->setpoint = int_tofp(pid_params.setpoint);
+	pid->last_err  = pid->setpoint - int_tofp(100);
+	pid->deadband  = int_tofp(pid_params.deadband);
+	pid->integral  = 0;
 }
 
 static inline void update_turbo_state(void)
@@ -985,7 +971,7 @@ static int pid_param_set(void *data, u64
 	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
 	for_each_possible_cpu(cpu)
 		if (all_cpu_data[cpu])
-			intel_pstate_busy_pid_reset(all_cpu_data[cpu]);
+			intel_pstate_pid_reset(all_cpu_data[cpu]);
 
 	return 0;
 }
@@ -1994,7 +1980,7 @@ static int intel_pstate_init_cpu(unsigne
 
 	intel_pstate_get_cpu_pstates(cpu);
 
-	intel_pstate_busy_pid_reset(cpu);
+	intel_pstate_pid_reset(cpu);
 
 	pr_debug("controlling: cpu %d\n", cpunum);
 
