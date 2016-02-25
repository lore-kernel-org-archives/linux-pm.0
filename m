From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: disable HWP notifications
Date: Thu, 25 Feb 2016 15:09:31 -0800
Message-ID: <1456441771-4961-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:51886 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbcBYXLY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 18:11:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Disable HWP Interrupt notification before enabling HWP. Since we don't
have HWP interrupt handling for possible performance interrupts, there
is not much use of enabling HWP interrupts.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f4d85c2..80ea548 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -532,6 +532,9 @@ static void __init intel_pstate_sysfs_expose_params(void)
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
+	/* First disable HWP notification interrupt as we don't process them */
+	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 }
 
-- 
2.5.0

