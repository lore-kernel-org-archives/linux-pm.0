From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/4] cpufreq: intel_pstate: Change powersave to ondemand policy
Date: Tue,  8 Dec 2015 14:31:30 -0800
Message-ID: <1449613890-10403-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45822 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbbLHWcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 17:32:45 -0500
In-Reply-To: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Move the current Intel powersave policy processing to ondemand policy.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fb92402..76108e6 100644
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
 
@@ -1215,8 +1215,10 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
-		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		policy->policy = CPUFREQ_POLICY_ONDEMAND;
 
+	policy->available_policies = CPUFREQ_POLICY_PERFORMANCE |
+						CPUFREQ_POLICY_ONDEMAND;
 	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
-- 
2.4.3

