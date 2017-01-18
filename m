From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/4] cpufreq: intel_pstate: Fix sysfs limits enforcement for performance policy
Date: Wed, 18 Jan 2017 10:48:22 -0800
Message-ID: <1484765305-185352-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The side effect of keeping intel_pstate sysfs limits in sync with cpufreq
is that the now sysfs limits can't enforced under performance policy.
For example if the max_perf_pct is changed from 100 to 80, this will call
intel_pstate_set_policy(), which will change the max_perf to 100 again for
performance policy. Same issue happens, when no_turbo is set.

This change calculates max and min frequency using sysfs performance
limits in intel_pstate_verify_policy() and adjusts policy limits by
calling cpufreq_verify_within_limits(). Also when no_turbo is set, don't
set performance limits.

Fixes: 111b8b3fe4fa (cpufreq: intel_pstate: Always keep all limits settings in sync)
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f91c257..a54d65a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2005,7 +2005,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 			limits = &performance_limits;
 			perf_limits = limits;
 		}
-		if (policy->max >= policy->cpuinfo.max_freq) {
+		if (policy->max >= policy->cpuinfo.max_freq &&
+		    !limits->no_turbo) {
 			pr_debug("set performance\n");
 			intel_pstate_set_performance_limits(perf_limits);
 			goto out;
@@ -2047,6 +2048,17 @@ static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
+	/* When per-CPU limits are used, sysfs limits are not used */
+	if (!per_cpu_limits) {
+		unsigned int max_freq, min_freq;
+
+		max_freq = policy->cpuinfo.max_freq *
+						limits->max_sysfs_pct / 100;
+		min_freq = policy->cpuinfo.max_freq *
+						limits->min_sysfs_pct / 100;
+		cpufreq_verify_within_limits(policy, min_freq, max_freq);
+	}
+
 	return 0;
 }
 
-- 
2.7.4
