From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 16/16] cpufreq: intel_pstate: Eliminate intel_pstate_get_min_max()
Date: Tue, 28 Mar 2017 00:24:26 +0200
Message-ID: <51413518.j7MmntgXCY@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51049 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752503AbdC0WjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:39:08 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some computations in intel_pstate_get_min_max() are not necessary
and one of its two callers doesn't even use the full result.

First off, the fixed-point value of cpu->max_perf represents a
non-negative number between 0 and 1 inclusive and cpu->min_perf
cannot be greater than cpu->max_perf.  It is not necessary to check
those conditions every time the numbers in question are used.

Moreover, since intel_pstate_max_within_limits() only needs the
upper boundary, it doesn't make sense to compute the lower one in
there and returning min and max from intel_pstate_get_min_max()
via pointers doesn't look particularly nice.

For the above reasons, drop intel_pstate_get_min_max(), add a helper
to get the base P-state for min/max computations and carry out them
directly in the previous callers of intel_pstate_get_min_max().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1496,26 +1496,10 @@ static int knl_get_turbo_pstate(void)
 	return ret;
 }
 
-static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
+static int intel_pstate_get_base_pstate(struct cpudata *cpu)
 {
-	int max_perf = cpu->pstate.turbo_pstate;
-	int max_perf_adj;
-	int min_perf;
-
-	if (global.no_turbo || global.turbo_disabled)
-		max_perf = cpu->pstate.max_pstate;
-
-	/*
-	 * performance can be limited by user through sysfs, by cpufreq
-	 * policy, or by cpu specific default values determined through
-	 * experimentation.
-	 */
-	max_perf_adj = fp_ext_toint(max_perf * cpu->max_perf);
-	*max = clamp_t(int, max_perf_adj,
-			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
-
-	min_perf = fp_ext_toint(max_perf * cpu->min_perf);
-	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
+	return global.no_turbo || global.turbo_disabled ?
+			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 }
 
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
@@ -1538,11 +1522,13 @@ static void intel_pstate_set_min_pstate(
 
 static void intel_pstate_max_within_limits(struct cpudata *cpu)
 {
-	int min_pstate, max_pstate;
+	int pstate;
 
 	update_turbo_state();
-	intel_pstate_get_min_max(cpu, &min_pstate, &max_pstate);
-	intel_pstate_set_pstate(cpu, max_pstate);
+	pstate = intel_pstate_get_base_pstate(cpu);
+	pstate = max(cpu->pstate.min_pstate,
+		     fp_ext_toint(pstate * cpu->max_perf));
+	intel_pstate_set_pstate(cpu, pstate);
 }
 
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
@@ -1704,11 +1690,13 @@ static inline int32_t get_target_pstate_
 
 static int intel_pstate_prepare_request(struct cpudata *cpu, int pstate)
 {
-	int max_perf, min_perf;
+	int max_pstate = intel_pstate_get_base_pstate(cpu);
+	int min_pstate;
 
-	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
-	pstate = clamp_t(int, pstate, min_perf, max_perf);
-	return pstate;
+	min_pstate = max(cpu->pstate.min_pstate,
+			 fp_ext_toint(max_pstate * cpu->min_perf));
+	max_pstate = max(min_pstate, fp_ext_toint(max_pstate * cpu->max_perf));
+	return clamp_t(int, pstate, min_pstate, max_pstate);
 }
 
 static void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
