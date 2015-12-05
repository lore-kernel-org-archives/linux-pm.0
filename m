From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] cpufreq: intel_pstate: Add powersave policy support
Date: Fri,  4 Dec 2015 16:08:38 -0800
Message-ID: <1449274118-15575-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50296 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013AbbLEAJt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:09:49 -0500
In-Reply-To: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Implement support for powersave policy. The powersave policy will limit
the max performance to P-State = Maximum Efficiency Ratio.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 49 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 61b7118..417d020 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -189,8 +189,23 @@ static struct perf_limits ondemand_limits = {
 	.min_sysfs_pct = 0,
 };
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
+static struct perf_limits powersave_limits = {
+	.no_turbo = 1,
+	.turbo_disabled = 1,
+	.max_perf_pct = 0,
+	.max_perf = int_tofp(1),
+	.min_perf_pct = 0,
+	.min_perf = int_tofp(1),
+	.max_policy_pct = 0,
+	.max_sysfs_pct = 0,
+	.min_policy_pct = 0,
+	.min_sysfs_pct = 0,
+};
+
+#if defined(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE)
 static struct perf_limits *limits = &performance_limits;
+#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE)
+static struct perf_limits *limits = &powersave_limits;
 #else
 static struct perf_limits *limits = &ondemand_limits;
 #endif
@@ -1143,13 +1158,26 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		return 0;
 	}
 
-	pr_debug("intel_pstate: set ondemand\n");
-	limits = &ondemand_limits;
-	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
-	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
-	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
-					      policy->cpuinfo.max_freq);
-	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
+	if (policy->policy == CPUFREQ_POLICY_POWERSAVE) {
+		pr_debug("intel_pstate: set powersave\n");
+		limits = &powersave_limits;
+		limits->min_policy_pct = (policy->cpuinfo.min_freq * 100) /
+					  policy->cpuinfo.max_freq;
+		limits->min_policy_pct = clamp_t(int, limits->min_policy_pct,
+						 0, 100);
+		limits->max_policy_pct = limits->min_policy_pct;
+	} else {
+		pr_debug("intel_pstate: set ondemand\n");
+		limits = &ondemand_limits;
+		limits->min_policy_pct = (policy->min * 100) /
+					  policy->cpuinfo.max_freq;
+		limits->min_policy_pct = clamp_t(int, limits->min_policy_pct,
+						 0, 100);
+		limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
+						policy->cpuinfo.max_freq);
+		limits->max_policy_pct = clamp_t(int, limits->max_policy_pct,
+						 0, 100);
+	}
 
 	/* Normalize user input to [min_policy_pct, max_policy_pct] */
 	limits->min_perf_pct = max(limits->min_policy_pct,
@@ -1181,7 +1209,8 @@ static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 	cpufreq_verify_within_cpu_limits(policy);
 
 	if (policy->policy != CPUFREQ_POLICY_ONDEMAND &&
-	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
+	    policy->policy != CPUFREQ_POLICY_PERFORMANCE &&
+	    policy->policy != CPUFREQ_POLICY_POWERSAVE)
 		return -EINVAL;
 
 	return 0;
@@ -1234,6 +1263,8 @@ static int intel_pstate_available_policies(u8 *mask)
 {
 
 	*mask = CPUFREQ_POLICY_PERFORMANCE | CPUFREQ_POLICY_ONDEMAND;
+	if (!hwp_active)
+		*mask |= CPUFREQ_POLICY_POWERSAVE;
 
 	return 0;
 }
-- 
2.4.3

