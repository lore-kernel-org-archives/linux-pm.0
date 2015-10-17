From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH] fix intel_pstate to update MSR values when changing governors
Date: Fri, 16 Oct 2015 17:51:41 -0700
Message-ID: <1445043101-19079-1-git-send-email-alexandra.yates@linux.intel.com>
References: <fix intel_pstate to update MSR values when changing governors>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56884 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbbJQAtM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 20:49:12 -0400
In-Reply-To: <fix intel_pstate to update MSR values when changing governors>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, linux-pm@vger.kernel.org
Cc: root <root@skl-s-fedora22.jf.intel.com>

From: root <root@skl-s-fedora22.jf.intel.com>

When changing from powersave to performance governors
Intel_pstate fails to update the MSR values that reflect the
max_perf_pct to 100%. For instance:

Governor 	MSR	max_perf_pct
=========	====	============
Powersave 	2828	100%
Powersave	2028	80%
Performance	2028	100% <-

The arrow shows the culprit. At this point the  MSR should
reflect the max_perf_pct that is 100% that corresponds MSR 2828
the maximum performance for the Performance governor.
Instead it holds back the MSR value previously set
by the Powersave governor 2028.

Signed-off-by: root <root@skl-s-fedora22.jf.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cde38c8..992dbb5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1239,6 +1239,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	    policy->max >= policy->cpuinfo.max_freq) {
 		pr_debug("intel_pstate: set performance\n");
 		limits = &performance_limits;
+		if (hwp_active)
+			intel_pstate_hwp_set();
 		return 0;
 	}
 
-- 
2.4.3

