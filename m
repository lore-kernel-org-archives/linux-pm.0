From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq / intel_pstate: Optimize intel_pstate_set_policy
Date: Tue,  9 Apr 2013 15:38:18 -0700
Message-ID: <1365547098-23847-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64239 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932361Ab3DIWeR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Apr 2013 18:34:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This function is called quite often from other subsystems.
Removed unused call to intel_pstate_get_min_max().
Also when "policy->policy == CPUFREQ_POLICY_PERFORMANCE", then
no need to do calculations as the limits will be forced anyway.
Also corrected filename in the header.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f6dd1e7..f3729d4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1,5 +1,5 @@
 /*
- * cpufreq_snb.c: Native P state management for Intel processors
+ * intel_pstate.c: Native P state management for Intel processors
  *
  * (C) Copyright 2012 Intel Corporation
  * Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
@@ -658,30 +658,27 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
-	int min, max;
 
 	cpu = all_cpu_data[policy->cpu];
 
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	intel_pstate_get_min_max(cpu, &min, &max);
-
-	limits.min_perf_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
-	limits.min_perf_pct = clamp_t(int, limits.min_perf_pct, 0 , 100);
-	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
-
-	limits.max_perf_pct = policy->max * 100 / policy->cpuinfo.max_freq;
-	limits.max_perf_pct = clamp_t(int, limits.max_perf_pct, 0 , 100);
-	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
-
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		limits.min_perf_pct = 100;
 		limits.min_perf = int_tofp(1);
 		limits.max_perf_pct = 100;
 		limits.max_perf = int_tofp(1);
 		limits.no_turbo = 0;
+		return 0;
 	}
+	limits.min_perf_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
+	limits.min_perf_pct = clamp_t(int, limits.min_perf_pct, 0 , 100);
+	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
+
+	limits.max_perf_pct = policy->max * 100 / policy->cpuinfo.max_freq;
+	limits.max_perf_pct = clamp_t(int, limits.max_perf_pct, 0 , 100);
+	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
 	return 0;
 }
-- 
1.7.11.7

