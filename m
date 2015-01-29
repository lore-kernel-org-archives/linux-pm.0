From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: honor user space min_perf_pct override on resume
Date: Thu, 29 Jan 2015 13:03:52 -0800
Message-ID: <1422565432-11914-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22658 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755084AbbA2VDy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 16:03:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

If the user has requested an override of the min_perf_pct via
sysfs, then it should be restored whenever policy is updated,
such as on resume.  Take the max of whatever the user requested
and whatever the policy is.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dfee572..e7e808d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -148,6 +148,8 @@ struct perf_limits {
 	int32_t min_perf;
 	int max_policy_pct;
 	int max_sysfs_pct;
+	int min_policy_pct;
+	int min_sysfs_pct;
 };
 
 static struct perf_limits limits = {
@@ -159,6 +161,8 @@ static struct perf_limits limits = {
 	.min_perf = 0,
 	.max_policy_pct = 100,
 	.max_sysfs_pct = 100,
+	.min_policy_pct = 0,
+	.min_sysfs_pct = 0,
 };
 
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
@@ -431,7 +435,9 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
-	limits.min_perf_pct = clamp_t(int, input, 0 , 100);
+
+	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
+	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 
 	if (hwp_active)
@@ -921,6 +927,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
 	    policy->max >= policy->cpuinfo.max_freq) {
+		limits.min_policy_pct = 100;
 		limits.min_perf_pct = 100;
 		limits.min_perf = int_tofp(1);
 		limits.max_policy_pct = 100;
@@ -930,8 +937,9 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		return 0;
 	}
 
-	limits.min_perf_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
-	limits.min_perf_pct = clamp_t(int, limits.min_perf_pct, 0 , 100);
+	limits.min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
+	limits.min_policy_pct = clamp_t(int, limits.min_policy_pct, 0 , 100);
+	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 
 	limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
-- 
1.9.3

