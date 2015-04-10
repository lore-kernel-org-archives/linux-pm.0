From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: remove MSR test
Date: Fri, 10 Apr 2015 10:21:09 -0700
Message-ID: <1428686469-10441-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30821 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785AbbDJRVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Apr 2015 13:21:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

x86_match_cpu will not match our cpuid unless APERF/MPERF flag is
set, so there is no need to do the manual check for this MSR.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a1dd871..c5b81be 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1055,25 +1055,11 @@ static unsigned int force_load;
 
 static int intel_pstate_msrs_not_valid(void)
 {
-	/* Check that all the msr's we are using are valid. */
-	u64 aperf, mperf, tmp;
-
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-
 	if (!pstate_funcs.get_max() ||
 	    !pstate_funcs.get_min() ||
 	    !pstate_funcs.get_turbo())
 		return -ENODEV;
 
-	rdmsrl(MSR_IA32_APERF, tmp);
-	if (!(tmp - aperf))
-		return -ENODEV;
-
-	rdmsrl(MSR_IA32_MPERF, tmp);
-	if (!(tmp - mperf))
-		return -ENODEV;
-
 	return 0;
 }
 
-- 
1.9.3

