From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Subject: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
Date: Fri, 4 Sep 2015 19:58:59 +0900
Message-ID: <55E97973.1020301@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:25292 "EHLO
	mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbIDLB6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 07:01:58 -0400
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E39BAC039F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2015 20:01:55 +0900 (JST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org

Add some value check to prevent a reversal, max_perf_pct < min_perf_pct.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>

---
 drivers/cpufreq/intel_pstate.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fcb929e..03dda19 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -423,6 +423,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 
 	limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
+	limits.max_perf_pct = max(limits.max_perf_pct, limits.min_perf_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
 	if (hwp_active)
@@ -442,6 +443,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 
 	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
+	limits.min_perf_pct = min(limits.min_perf_pct, limits.max_perf_pct);
 	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
 
 	if (hwp_active)
