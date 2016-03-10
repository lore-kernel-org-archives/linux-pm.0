From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Do not skip samples partially
Date: Thu, 10 Mar 2016 23:45:19 +0100
Message-ID: <1608361.vYXCevKAEf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51072 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932431AbcCJWnZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 17:43:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the current value of MPERF or the current value of TSC is the
same as the previous one, respectively, intel_pstate_sample() bails
out early and skips the sample.

However, intel_pstate_adjust_busy_pstate() is still called in that
case which is not correct, so modify intel_pstate_sample() to
return a bool value indicating whether or not the sample has been
taken and use it to decide whether or not to call
intel_pstate_adjust_busy_pstate().

While at it, remove redundant parentheses from the MPERF/TSC
check in intel_pstate_sample().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of my linux-next branch.

---
 drivers/cpufreq/intel_pstate.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -890,7 +890,7 @@ static inline void intel_pstate_calc_bus
 	sample->core_pct_busy = (int32_t)core_pct;
 }
 
-static inline void intel_pstate_sample(struct cpudata *cpu, u64 time)
+static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
 {
 	u64 aperf, mperf;
 	unsigned long flags;
@@ -900,9 +900,9 @@ static inline void intel_pstate_sample(s
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
 	tsc = rdtsc();
-	if ((cpu->prev_mperf == mperf) || (cpu->prev_tsc == tsc)) {
+	if (cpu->prev_mperf == mperf || cpu->prev_tsc == tsc) {
 		local_irq_restore(flags);
-		return;
+		return false;
 	}
 	local_irq_restore(flags);
 
@@ -920,6 +920,7 @@ static inline void intel_pstate_sample(s
 	cpu->prev_aperf = aperf;
 	cpu->prev_mperf = mperf;
 	cpu->prev_tsc = tsc;
+	return true;
 }
 
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
@@ -1026,8 +1027,9 @@ static void intel_pstate_update_util(str
 	u64 delta_ns = time - cpu->sample.time;
 
 	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
-		intel_pstate_sample(cpu, time);
-		if (!hwp_active)
+		bool sample_taken = intel_pstate_sample(cpu, time);
+
+		if (sample_taken && !hwp_active)
 			intel_pstate_adjust_busy_pstate(cpu);
 	}
 }

