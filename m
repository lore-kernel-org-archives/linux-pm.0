From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Add additional OOB Ids
Date: Sat, 23 Jul 2016 15:12:06 -0700
Message-ID: <1469311926-12153-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43309 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbcGWWNE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 Jul 2016 18:13:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add Skylake-X and Broadwell-X ids for out of band control of P-States.
If the MSR_MISC_PWR_MGMT BIT(8) == 1, then Intel P-State driver should
exit as OS can't control P-States.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d15e29e..02bdf1d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1379,6 +1379,8 @@ MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] = {
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D, core_params),
+	ICPU(INTEL_FAM6_BROADWELL_X, core_params),
+	ICPU(INTEL_FAM6_SKYLAKE_X, core_params),
 	{}
 };
 
-- 
2.7.4

