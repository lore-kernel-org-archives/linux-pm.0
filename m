From: dirk.brandewie@gmail.com
Subject: [PATCH 2/4] intel_pstate: Correct rounding in busy calculation
Date: Thu, 29 May 2014 09:32:23 -0700
Message-ID: <1401381145-17745-3-git-send-email-dirk.j.brandewie@intel.com>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: stable-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dirk.brandewie@gmail.com, rjw@rjwysocki.net, dsmythies@telus.net, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Changing to fixed point math throughout the busy calculation in
commit e66c1768 Change busy calculation to use fixed point
math. Introduced some inaccuracies by rounding the busy value at two
points in the calculation.  This change removes roundings and moves
the rounding to the output of the PID where the calculations are
complete and the value returned as an integer.

Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: <stable@vger.kernel.org> # 3.14.x
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ffef765..db8a992 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -38,10 +38,10 @@
 #define BYT_TURBO_VIDS		0x66d
 
 
-#define FRAC_BITS 6
+#define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
-#define FP_ROUNDUP(X) ((X) += 1 << FRAC_BITS)
+
 
 static inline int32_t mul_fp(int32_t x, int32_t y)
 {
@@ -194,7 +194,10 @@ static signed int pid_calc(struct _pid *pid, int32_t busy)
 	pid->last_err = fp_error;
 
 	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
-
+	if (result >= 0)
+		result = result + (1 << (FRAC_BITS-1));
+	else
+		result = result - (1 << (FRAC_BITS-1));
 	return (signed int)fp_toint(result);
 }
 
@@ -556,7 +559,6 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 
 	core_pct = div_fp(int_tofp(sample->aperf), int_tofp(sample->mperf));
 	core_pct = mul_fp(core_pct, int_tofp(100));
-	FP_ROUNDUP(core_pct);
 
 	sample->freq = fp_toint(
 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
@@ -602,7 +604,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	max_pstate = int_tofp(cpu->pstate.max_pstate);
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
-	return FP_ROUNDUP(core_busy);
+	return core_busy;
 }
 
 static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
-- 
1.9.0
