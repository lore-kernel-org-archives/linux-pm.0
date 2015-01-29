From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: respect cpufreq policy request
Date: Thu, 29 Jan 2015 12:17:13 -0800
Message-ID: <1422562633-10370-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24766 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757298AbbA2URO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 15:17:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When thermal or other subsystem requests to change the policy,
use that irrepective of whether cpufreq policy is PERFORMANCE or
not. Without this change, when thermal subsystem passive policy wants
to reduce performance, it still runs at 100%.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 742eefb..61ac9c8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -887,7 +887,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
+	    policy->max >= policy->cpuinfo.max_freq) {
 		limits.min_perf_pct = 100;
 		limits.min_perf = int_tofp(1);
 		limits.max_policy_pct = 100;
-- 
1.9.3

