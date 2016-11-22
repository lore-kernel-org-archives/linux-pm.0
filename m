From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: round up min_perf limits
Date: Mon, 21 Nov 2016 16:33:19 -0800
Message-ID: <1479774800-126589-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753695AbcKVAd0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 19:33:26 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In some use cases, user wants to enforce a minimum performance limit on
CPUs. But because of simple division the resultant performance is 100 MHz
less than the desired in some cases.

For example when the maximum frequency is 3.50 GHz, setting
scaling_min_frequency to 1.6 GHz always results in 1.5 GHz minimum. With
simple round up, the frequency can be set to 1.6 GHz to minimum in this
case. This round up is already done to max_policy_pct and max_perf, so do
the same for min_policy_pct and min_perf.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f07e591..2f27812 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1569,8 +1569,8 @@ static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 	if (policy->max == policy->min) {
 		limits->min_policy_pct = limits->max_policy_pct;
 	} else {
-		limits->min_policy_pct = (policy->min * 100) /
-						policy->cpuinfo.max_freq;
+		limits->min_policy_pct = DIV_ROUND_UP(policy->min * 100,
+						      policy->cpuinfo.max_freq);
 		limits->min_policy_pct = clamp_t(int, limits->min_policy_pct,
 						 0, 100);
 	}
@@ -1591,6 +1591,7 @@ static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 	limits->min_perf = div_fp(limits->min_perf_pct, 100);
 	limits->max_perf = div_fp(limits->max_perf_pct, 100);
 	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
+	limits->min_perf = round_up(limits->min_perf, FRAC_BITS);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-- 
2.7.4

