From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Move limits->max_perf to correct position
Date: Tue,  7 Jun 2016 17:38:52 -0700
Message-ID: <1465346333-3104-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30193 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbcFHAhR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jun 2016 20:37:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The limits->max_perf is rounded_up but immediately overwritten by
another assignment to limits->max_perf. Move it to correct
position.
While here also added a pr_debug call in set_policy to aid in
debugging.

Fixes: 785ee2788141 "cpufreq: intel_pstate: Fix limits->max_perf rounding error"
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0d159b5..724b905 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1460,6 +1460,9 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
 
+	pr_debug("set_policy cpuinfo.max %u policy->max %u\n",
+		 policy->cpuinfo.max_freq, policy->max);
+
 	cpu = all_cpu_data[0];
 	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
 	    policy->max < policy->cpuinfo.max_freq &&
@@ -1495,13 +1498,13 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 				   limits->max_sysfs_pct);
 	limits->max_perf_pct = max(limits->min_policy_pct,
 				   limits->max_perf_pct);
-	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
 
 	/* Make sure min_perf_pct <= max_perf_pct */
 	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
 
 	limits->min_perf = div_fp(limits->min_perf_pct, 100);
 	limits->max_perf = div_fp(limits->max_perf_pct, 100);
+	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
 
  out:
 	intel_pstate_set_update_util_hook(policy->cpu);
-- 
2.5.0

