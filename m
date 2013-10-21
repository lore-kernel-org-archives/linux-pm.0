From: dirk.brandewie@gmail.com
Subject: [PATCH 1/4] cpufreq: intel_pstate: Improve accuracy by not truncating until final result
Date: Mon, 21 Oct 2013 09:20:32 -0700
Message-ID: <1382372435-29778-2-git-send-email-dirk.j.brandewie@intel.com>
References: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42736 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JUQUp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 12:20:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id fb1so5280128pad.17
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 09:20:44 -0700 (PDT)
In-Reply-To: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Brennan Shacklett <brennan@genyes.org>, Brennan Shacklet <bpshacklett@gmail.com>

From: Brennan Shacklett <brennan@genyes.org>

This patch addresses Bug 60727
(https://bugzilla.kernel.org/show_bug.cgi?id=60727)
which was due to the truncation of intermediate values in the
calculations, which causes the code to consistently underestimate the
current cpu frequency, specifically 100% cpu utilization was truncated
down to the setpoint of 97%. This patch fixes the problem by keeping
the results of all intermediate calculations as fixed point numbers
rather scaling them back and forth between integers and fixed point.

Signed-off-by: Brennan Shacklet <bpshacklett@gmail.com>
Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d576489..9f42b0a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -48,7 +48,7 @@ static inline int32_t div_fp(int32_t x, int32_t y)
 }
 
 struct sample {
-	int core_pct_busy;
+	int32_t core_pct_busy;
 	u64 aperf;
 	u64 mperf;
 	int freq;
@@ -68,7 +68,7 @@ struct _pid {
 	int32_t i_gain;
 	int32_t d_gain;
 	int deadband;
-	int last_err;
+	int32_t last_err;
 };
 
 struct cpudata {
@@ -153,16 +153,15 @@ static inline void pid_d_gain_set(struct _pid *pid, int percent)
 	pid->d_gain = div_fp(int_tofp(percent), int_tofp(100));
 }
 
-static signed int pid_calc(struct _pid *pid, int busy)
+static signed int pid_calc(struct _pid *pid, int32_t busy)
 {
-	signed int err, result;
+	signed int result;
 	int32_t pterm, dterm, fp_error;
 	int32_t integral_limit;
 
-	err = pid->setpoint - busy;
-	fp_error = int_tofp(err);
+	fp_error = int_tofp(pid->setpoint) - busy;
 
-	if (abs(err) <= pid->deadband)
+	if (abs(fp_error) <= int_tofp(pid->deadband))
 		return 0;
 
 	pterm = mul_fp(pid->p_gain, fp_error);
@@ -176,8 +175,8 @@ static signed int pid_calc(struct _pid *pid, int busy)
 	if (pid->integral < -integral_limit)
 		pid->integral = -integral_limit;
 
-	dterm = mul_fp(pid->d_gain, (err - pid->last_err));
-	pid->last_err = err;
+	dterm = mul_fp(pid->d_gain, fp_error - pid->last_err);
+	pid->last_err = fp_error;
 
 	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
 
@@ -436,8 +435,9 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu,
 					struct sample *sample)
 {
 	u64 core_pct;
-	core_pct = div64_u64(sample->aperf * 100, sample->mperf);
-	sample->freq = cpu->pstate.max_pstate * core_pct * 1000;
+	core_pct = div64_u64(int_tofp(sample->aperf * 100),
+			     sample->mperf);
+	sample->freq = fp_toint(cpu->pstate.max_pstate * core_pct * 1000);
 
 	sample->core_pct_busy = core_pct;
 }
@@ -469,22 +469,19 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
-static inline int intel_pstate_get_scaled_busy(struct cpudata *cpu)
+static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 {
-	int32_t busy_scaled;
 	int32_t core_busy, max_pstate, current_pstate;
 
-	core_busy = int_tofp(cpu->samples[cpu->sample_ptr].core_pct_busy);
+	core_busy = cpu->samples[cpu->sample_ptr].core_pct_busy;
 	max_pstate = int_tofp(cpu->pstate.max_pstate);
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
-	busy_scaled = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
-
-	return fp_toint(busy_scaled);
+	return mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 }
 
 static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 {
-	int busy_scaled;
+	int32_t busy_scaled;
 	struct _pid *pid;
 	signed int ctl = 0;
 	int steps;
-- 
1.8.3.1

