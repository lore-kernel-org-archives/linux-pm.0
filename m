From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH][resend] cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT
Date: Tue, 19 Jul 2016 16:52:01 -0700
Message-ID: <1468972321-26332-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63316 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbcGSXwE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 19:52:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The MSR MSR_HWP_INTERRUPT is valid only when CPUID.06H:EAX[8] = 1, so
check for feature before accessing this MSR.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2fe9af1..4704fb2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -823,7 +823,8 @@ static void __init intel_pstate_sysfs_expose_params(void)
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
 	/* First disable HWP notification interrupt as we don't process them */
-	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+	if (static_cpu_has(X86_FEATURE_HWP_NOTIFY))
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 }
-- 
2.7.4

