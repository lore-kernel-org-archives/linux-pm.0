From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT
Date: Tue, 19 Jul 2016 16:34:44 -0700
Message-ID: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23726 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbcGSXfH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 19:35:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, spandruv <spandruv@spandruv-mobl.jf.intel.com>

From: spandruv <spandruv@spandruv-mobl.jf.intel.com>

The MSR MSR_HWP_INTERRUPT is valid only when CPUID.06H:EAX[8] = 1, so
check for feature before accessing this MSR.

Signed-off-by: spandruv <spandruv@spandruv-mobl.jf.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2fe9af1..712afbd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -822,8 +822,10 @@ static void __init intel_pstate_sysfs_expose_params(void)
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
+
 	/* First disable HWP notification interrupt as we don't process them */
-	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+	if (static_cpu_has(X86_FEATURE_HWP_NOTIFY))
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 }
-- 
2.7.4

