From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] cpufreq: intel_pstate: Change powersave to ondemand policy
Date: Fri,  4 Dec 2015 16:08:37 -0800
Message-ID: <1449274118-15575-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbbLEAJt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:09:49 -0500
In-Reply-To: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Move the current Intel powersave policy processing to ondemand policy.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fb92402..61b7118 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -176,7 +176,7 @@ static struct perf_limits performance_limits = {
 	.min_sysfs_pct = 0,
 };
 
-static struct perf_limits powersave_limits = {
+static struct perf_limits ondemand_limits = {
 	.no_turbo = 0,
 	.turbo_disabled = 0,
 	.max_perf_pct = 100,
@@ -192,7 +192,7 @@ static struct perf_limits powersave_limits = {
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 static struct perf_limits *limits = &performance_limits;
 #else
-static struct perf_limits *limits = &powersave_limits;
+static struct perf_limits *limits = &ondemand_limits;
 #endif
 
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
@@ -1143,8 +1143,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		return 0;
 	}
 
-	pr_debug("intel_pstate: set powersave\n");
-	limits = &powersave_limits;
+	pr_debug("intel_pstate: set ondemand\n");
+	limits = &ondemand_limits;
 	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
 	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
 	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
@@ -1180,7 +1180,7 @@ static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
 
-	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
+	if (policy->policy != CPUFREQ_POLICY_ONDEMAND &&
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
@@ -1215,7 +1215,7 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
-		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		policy->policy = CPUFREQ_POLICY_ONDEMAND;
 
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
@@ -1230,10 +1230,19 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int intel_pstate_available_policies(u8 *mask)
+{
+
+	*mask = CPUFREQ_POLICY_PERFORMANCE | CPUFREQ_POLICY_ONDEMAND;
+
+	return 0;
+}
+
 static struct cpufreq_driver intel_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
+	.get_available_policies = intel_pstate_available_policies,
 	.get		= intel_pstate_get,
 	.init		= intel_pstate_cpu_init,
 	.stop_cpu	= intel_pstate_stop_cpu,
-- 
2.4.3

