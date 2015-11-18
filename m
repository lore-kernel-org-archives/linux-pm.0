From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] SKL intel_pstate update MSR values when changing governors
Date: Tue, 17 Nov 2015 17:58:11 -0800
Message-ID: <1447811891-3266-1-git-send-email-alexandra.yates@linux.intel.com>
References: <SKL intel_pstate update MSR values when changing governors>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51979 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbbKRBzP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 20:55:15 -0500
In-Reply-To: <SKL intel_pstate update MSR values when changing governors>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, srinivas.pandruvada@linux.intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: root <root@skl-s-fedora22.jf.intel.com>

From: root <root@skl-s-fedora22.jf.intel.com>

When changing from powersave to performance governors
Intel_pstate fails to update the MSR values that reflect the
max_perf_pct to 100%. For instance in SKL reading rdmsr 0x774:

Governor 	MSR			max_perf_pct
=========	========		============
Powersave 	80002808		100%
Powersave	80002008		80%
Performance	80002028 [error]	100%
Performance	80002828 [expected]	100%

The line label [error] shows the culprit. At this point the MSR
should reflect the max_perf_pct that is 100%, that corresponds
to MSR 80002828 as shown on the next line of the example. Which
is the maximum performance for the Performance governor.
Instead it holds back the MSR value previously set by the
Powersave, in this case 80002028.

This patch allows the system to print the correct MSR value
80002828 that corresponds to the 100% max_perf_pct when changing
from powersave to performance governors.

For more information on the MSR values for SKL please visit
ISDM under Managing HWP.

Signed-off-by: root <root@skl-s-fedora22.jf.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2e31d09..0eeb7da 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1242,6 +1242,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	    policy->max >= policy->cpuinfo.max_freq) {
 		pr_debug("intel_pstate: set performance\n");
 		limits = &performance_limits;
+		if (hwp_active)
+			intel_pstate_hwp_set();
 		return 0;
 	}
 
-- 
1.9.1

