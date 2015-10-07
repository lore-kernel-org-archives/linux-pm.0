From: Prarit Bhargava <prarit@redhat.com>
Subject: RE: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct on governor switch
Date: Wed,  7 Oct 2015 10:34:12 -0400
Message-ID: <1444228452-23726-1-git-send-email-prarit@redhat.com>
References: <000001d10109$10d34630$3279d290$@net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbbJGOe2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 10:34:28 -0400
In-Reply-To: <000001d10109$10d34630$3279d290$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dsmythies@telus.net
Cc: kristen@linux.intel.com, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Prarit Bhargava <prarit@redhat.com>

Doug, please apply and test.

My result is:

\# initial load of driver, set to PERFORMANCE governor by default.

[   21.406525] intel_pstate_set_policy[1001] min_perf_pct = 100
[   21.421288] intel_pstate_set_policy[1001] min_perf_pct = 100
[   21.436038] intel_pstate_set_policy[1001] min_perf_pct = 100
[   21.450505] intel_pstate_set_policy[1001] min_perf_pct = 100

\#  echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct

[   21.483436] store_min_perf_pct[453] min_sysfs_pct = 100
[   21.489373] store_min_perf_pct[456] min_perf_pct = 100
[   21.495203] store_min_perf_pct[459] min_perf_pct = 100
[   21.501050] store_min_perf_pct[462] min_perf_pct = 100

\#  cpupower -c all frequency-set -g powersave

[  214.187212] intel_pstate_set_policy[1023] min_perf_pct = 100
[  214.193643] intel_pstate_set_policy[1028] min_perf_pct = 100
[  214.200205] intel_pstate_set_policy[1020] min_perf_pct = 100
[  214.206626] intel_pstate_set_policy[1023] min_perf_pct = 100
[  214.213064] intel_pstate_set_policy[1028] min_perf_pct = 100
[  214.219601] intel_pstate_set_policy[1020] min_perf_pct = 100
[  214.226008] intel_pstate_set_policy[1023] min_perf_pct = 100
[  214.232471] intel_pstate_set_policy[1028] min_perf_pct = 100
[  214.238990] intel_pstate_set_policy[1020] min_perf_pct = 100
[  214.245408] intel_pstate_set_policy[1023] min_perf_pct = 100
[  214.251845] intel_pstate_set_policy[1028] min_perf_pct = 100

\#  cat /sys/devices/system/cpu/intel_pstate/*_perf_pct

100
100

Thanks!

P.
---
 drivers/cpufreq/intel_pstate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3af9dd7..95f6b9f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -450,9 +450,17 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 		return -EINVAL;
 
 	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
+	printk("%s[%d] min_sysfs_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_sysfs_pct);
 	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
+	printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_perf_pct);
 	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
+	printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_perf_pct);
 	limits.min_perf_pct = min(limits.max_perf_pct, limits.min_perf_pct);
+	printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_perf_pct);
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 
 	if (hwp_active)
@@ -990,6 +998,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	    policy->max >= policy->cpuinfo.max_freq) {
 		limits.min_policy_pct = 100;
 		limits.min_perf_pct = 100;
+		printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+		       limits.min_perf_pct);
 		limits.min_perf = int_tofp(1);
 		limits.max_policy_pct = 100;
 		limits.max_perf_pct = 100;
@@ -1007,10 +1017,16 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
 	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
+	printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_perf_pct);
 	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
+	printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_perf_pct);
 
 	/* Make sure min_perf_pct <= max_perf_pct */
 	limits.min_perf_pct = min(limits.max_perf_pct, limits.min_perf_pct);
+	printk("%s[%d] min_perf_pct = %d\n", __FUNCTION__, __LINE__,
+	       limits.min_perf_pct);
 
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
-- 
1.8.3.1

