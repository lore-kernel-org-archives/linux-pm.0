From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/3] cpufreq: intel_pstate: Adjust policy->max
Date: Fri, 22 Apr 2016 21:01:07 -0700
Message-ID: <1461384068-23969-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1461384068-23969-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45271 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbcDWEEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 Apr 2016 00:04:32 -0400
In-Reply-To: <1461384068-23969-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When policy->max is changed via _PPC or sysfs and is more than the max non
turbo frequency, it does not really change resulting performance in some
processors. When policy->max results in a P-State ratio more than the
turbo activation ratio, then processor can choose any P-State up to max
turbo. So the user or _PPC setting has no value, but this can cause
undesirable side effects like:
- Showing reduced max percentage in Intel P-State sysfs
- It can cause reduced max performance, if the policy->max is set to
the least turbo frequency and because of precision error in calculation
of ceiling limit, we may end up in a limit which is in non turbo region.
This issue is more prone when we enforce _PPC limit, because of the way
_PPC limit is set to indicate the beginning of turbo region when config
TDP feature is in use.

When config TDP feature is ON, the max non turbo ratio can be less than
max physical non turbo ratio. In this case _PPC points to turbo activation
ratio + 1. In this case we don't need to treat this as the reduced
frequency in set_policy callback, as we can get performance up to max
turbo frequency.

In this change when config TDP is active (When the physical max non turbo
ratio is more than the current max non turbo ratio), any request above
current max non turbo is treated as full performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b3e8124..c9cc72d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1428,11 +1428,23 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu;
+
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
 
+	cpu = all_cpu_data[0];
+	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate) {
+		if (policy->max < policy->cpuinfo.max_freq &&
+		    policy->max > (cpu->pstate.max_pstate *
+				   cpu->pstate.scaling)) {
+			pr_info("policy->max > max non turbo frequency\n");
+			policy->max = policy->cpuinfo.max_freq;
+		}
+	}
+
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		limits = &performance_limits;
 		if (policy->max >= policy->cpuinfo.max_freq) {
-- 
2.5.0

