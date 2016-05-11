From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2, 3/3] intel_pstate: Clean up get_target_pstate_use_performance()
Date: Wed, 11 May 2016 19:11:26 +0200
Message-ID: <1942272.lC5nrrGFM2@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan> <4400018.TlI4RAhtYU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52021 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751948AbcEKRIs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 13:08:48 -0400
In-Reply-To: <4400018.TlI4RAhtYU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The comments and the core_busy variable name in
get_target_pstate_use_performance() are totally confusing,
so modify them to reflect what's going on.

The results of the computations should be the same as before.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1254,43 +1254,38 @@ static inline int32_t get_target_pstate_
 
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 {
-	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
+	int32_t perf_scaled, max_pstate, current_pstate, sample_ratio;
 	u64 duration_ns;
 
 	/*
-	 * core_busy is the ratio of actual performance to max
-	 * max_pstate is the max non turbo pstate available
-	 * current_pstate was the pstate that was requested during
-	 * 	the last sample period.
-	 *
-	 * We normalize core_busy, which was our actual percent
-	 * performance to what we requested during the last sample
-	 * period. The result will be a percentage of busy at a
-	 * specified pstate.
+	 * perf_scaled is the average performance during the last sampling
+	 * period scaled by the ratio of the maximum P-state to the P-state
+	 * requested last time (in percent).  That measures the system's
+	 * response to the previous P-state selection.
 	 */
 	max_pstate = cpu->pstate.max_pstate_physical;
 	current_pstate = cpu->pstate.current_pstate;
-	core_busy = mul_ext_fp(cpu->sample.core_avg_perf,
+	perf_scaled = mul_ext_fp(cpu->sample.core_avg_perf,
 			       div_fp(100 * max_pstate, current_pstate));
 
 	/*
 	 * Since our utilization update callback will not run unless we are
 	 * in C0, check if the actual elapsed time is significantly greater (3x)
 	 * than our sample interval.  If it is, then we were idle for a long
-	 * enough period of time to adjust our busyness.
+	 * enough period of time to adjust our performance metric.
 	 */
 	duration_ns = cpu->sample.time - cpu->last_sample_time;
 	if ((s64)duration_ns > pid_params.sample_rate_ns * 3) {
 		sample_ratio = div_fp(pid_params.sample_rate_ns, duration_ns);
-		core_busy = mul_fp(core_busy, sample_ratio);
+		perf_scaled = mul_fp(perf_scaled, sample_ratio);
 	} else {
 		sample_ratio = div_fp(100 * cpu->sample.mperf, cpu->sample.tsc);
 		if (sample_ratio < int_tofp(1))
-			core_busy = 0;
+			perf_scaled = 0;
 	}
 
-	cpu->sample.busy_scaled = core_busy;
-	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, core_busy);
+	cpu->sample.busy_scaled = perf_scaled;
+	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, perf_scaled);
 }
 
 static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)

