From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] cpufreq, intel_pstate, minor cleanup for FRAC_BITS
Date: Tue,  8 Dec 2015 13:44:59 -0500
Message-ID: <1449600299-4647-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbbLHSpD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 13:45:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

785ee27 ("cpufreq: intel_pstate: Fix limits->max_perf rounding error")
hardcodes the value of FRAC_BITS.  This patch fixes that minor issue.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4d07cbd..98fb882 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1123,7 +1123,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 				   limits->max_sysfs_pct);
 	limits->max_perf_pct = max(limits->min_policy_pct,
 				   limits->max_perf_pct);
-	limits->max_perf = round_up(limits->max_perf, 8);
+	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
 
 	/* Make sure min_perf_pct <= max_perf_pct */
 	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
-- 
1.7.9.3

