From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH v3] cpufreq: intel_pstate: Proportional algorithm for Atom
Date: Mon, 10 Oct 2016 23:41:25 +0200
Message-ID: <3001586.30BU9lMrGG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41092 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751609AbcJJVlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 17:41:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PID algorithm used by the intel_pstate driver tends to drive
performance to the minimum for workloads with utilization below the
setpoint, which is undesirable, so replace it with a modified
"proportional" algorithm on Atom.

The new algorithm will set the new P-state to be 1.25 times the
available maximum times the (frequency-invariant) utilization during
the previous sampling period except when the target P-state computed
this way is lower than the average P-state during the previous
sampling period.  In the latter case, it will increase the target by
50% of the difference between it and the average P-state to prevent
performance from dropping down too fast in some cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

Resending without the [RFC/RFT] tag as it has been tested by Srinivas in the
meantime and the performance is fine (better than the current algorithm in
some cases).

v1 -> v2:
  It is better to compare the average P-state to the target (than to
  compare the average perf ratio to the utilization), because that takes
  turbo into account more accurately.

  Plus if the target is below the min, it is better to compare the min
  to the average instead of comparing the target to it.

v2 -> v3:
  Fix a typo in the ternary operator reported by Doug.

---
 drivers/cpufreq/intel_pstate.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1232,6 +1232,7 @@ static inline int32_t get_target_pstate_
 {
 	struct sample *sample = &cpu->sample;
 	int32_t busy_frac, boost;
+	int target, avg_pstate;
 
 	busy_frac = div_fp(sample->mperf, sample->tsc);
 
@@ -1242,7 +1243,26 @@ static inline int32_t get_target_pstate_
 		busy_frac = boost;
 
 	sample->busy_scaled = busy_frac * 100;
-	return get_avg_pstate(cpu) - pid_calc(&cpu->pid, sample->busy_scaled);
+
+	target = limits->no_turbo || limits->turbo_disabled ?
+			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
+	target += target >> 2;
+	target = mul_fp(target, busy_frac);
+	if (target < cpu->pstate.min_pstate)
+		target = cpu->pstate.min_pstate;
+
+	/*
+	 * If the average P-state during the previous cycle was higher than the
+	 * current target, add 50% of the difference to the target to reduce
+	 * possible performance oscillations and offset possible performance
+	 * loss related to moving the workload from one CPU to another within
+	 * a package/module.
+	 */
+	avg_pstate = get_avg_pstate(cpu);
+	if (avg_pstate > target)
+		target += (avg_pstate - target) >> 1;
+
+	return target;
 }
 
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)

