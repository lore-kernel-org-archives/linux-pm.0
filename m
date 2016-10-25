From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/4] cpufreq: intel_pstate: Reduce impact due to rounding error
Date: Tue, 25 Oct 2016 13:20:41 -0700
Message-ID: <1477426843-63821-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941992AbcJYUU4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Oct 2016 16:20:56 -0400
In-Reply-To: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When policy->max and policy->min are same, in some cases they don't
result in the same frequency cap. The max_policy_pct is rounded up but
not min_perf_pct. So even when they are same, results in different
percentage or maximum and minimum.
Since minimum is a conservative value for power, a lower value without
rounding is better in most of the cases, unless user wants
policy->max = policy->min.
This change uses use the same policy percentage when policy->max and
policy->min are same.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b6e9b49..8e7390b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1543,11 +1543,17 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct perf_limits *limits)
 {
-	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
-	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0, 100);
 	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
 					      policy->cpuinfo.max_freq);
 	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0, 100);
+	if (policy->max == policy->min) {
+		limits->min_policy_pct = limits->max_policy_pct;
+	} else {
+		limits->min_policy_pct = (policy->min * 100) /
+						policy->cpuinfo.max_freq;
+		limits->min_policy_pct = clamp_t(int, limits->min_policy_pct,
+						 0, 100);
+	}
 
 	/* Normalize user input to [min_policy_pct, max_policy_pct] */
 	limits->min_perf_pct = max(limits->min_policy_pct,
-- 
2.7.4

