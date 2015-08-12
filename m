From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][rfc] intel_pstate: Fix user input of min/max to legal policy region
Date: Wed, 12 Aug 2015 11:49:19 +0800
Message-ID: <1439351359-29532-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10625 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933329AbbHLDpv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Aug 2015 23:45:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, lenb@kernel.org, Chen Yu <yu.c.chen@intel.com>

In current code, if system is using performance policy, user can
modify the max_perf_pct to any values lower than 100:

$ grep . /sys/devices/system/cpu/intel_pstate/m*_perf_pct
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:100

$ echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct

$ grep . /sys/devices/system/cpu/intel_pstate/m*_perf_pct
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:100

the max_perf_pct above is lower than min_perf_pct, which
is not reasonable.

This patch solves this problem by clamping min_perf_pct and max_perf_pct
to be strictly inside [min_policy_pct,max_policy_pct].

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fcb929e..3702c5a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -423,6 +423,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 
 	limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
+	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
 	if (hwp_active)
@@ -442,6 +443,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 
 	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
+	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 
 	if (hwp_active)
@@ -985,12 +987,14 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	limits.min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
 	limits.min_policy_pct = clamp_t(int, limits.min_policy_pct, 0 , 100);
-	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
-	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
-
 	limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
 	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
+
+	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
+	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
+	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
+	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
 	if (hwp_active)
-- 
1.8.3.1

