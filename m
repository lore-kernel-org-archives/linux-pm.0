From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: fix inconsistency in setting policy limits
Date: Sun,  3 Apr 2016 19:42:11 -0700
Message-ID: <1459737731-7386-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12384 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbcDDCpW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 3 Apr 2016 22:45:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When user sets performance policy using cpufreq interface, it is possible
that because of policy->max limits, the actual performance is still
limited. But the current implementation will silently switch the
policy to powersave and start using powersave limits. If user modifies
any limits using intel_pstate sysfs, this is actually changing powersave
limits.

The current implementation tracks limits under powersave and performance
policy using two different variables. When policy->max is less than
policy->cpuinfo.max_freq, only powersave limit variable is used.

This fix involves uses performance limits variable always when policy
is performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Rebased on top of 
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
branch: linux-next


 drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a382195..4674804 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1140,6 +1140,20 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 	synchronize_sched();
 }
 
+static void intel_pstate_set_performance_limits(struct perf_limits *limits)
+{
+	limits->no_turbo = 0;
+	limits->turbo_disabled = 0;
+	limits->max_perf_pct = 100;
+	limits->max_perf = int_tofp(1);
+	limits->min_perf_pct = 100;
+	limits->min_perf = int_tofp(1);
+	limits->max_policy_pct = 100;
+	limits->max_sysfs_pct = 100;
+	limits->min_policy_pct = 0;
+	limits->min_sysfs_pct = 0;
+}
+
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	if (!policy->cpuinfo.max_freq)
@@ -1147,15 +1161,18 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
 
-	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
-	    policy->max >= policy->cpuinfo.max_freq) {
-		pr_debug("intel_pstate: set performance\n");
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		limits = &performance_limits;
-		goto out;
+		if (policy->max >= policy->cpuinfo.max_freq) {
+			pr_debug("intel_pstate: set performance\n");
+			intel_pstate_set_performance_limits(limits);
+			goto out;
+		}
+	} else {
+		pr_debug("intel_pstate: set powersave\n");
+		limits = &powersave_limits;
 	}
 
-	pr_debug("intel_pstate: set powersave\n");
-	limits = &powersave_limits;
 	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
 	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
 	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
-- 
2.5.0

