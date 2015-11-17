From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [TEST PATCH] cpufreq: intel_pstate: Workaround to for wrong ACPI perf table entry
Date: Tue, 17 Nov 2015 15:00:52 -0800
Message-ID: <1447801252-3626-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2947 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbbKQXCd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 18:02:33 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: bp@alien8.de, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

With the implementation of ACPI _PSS and _PPC processing in the Intel P
state driver, a bad ACPI configuration can impact max/min states. For
example as reported by Borislav Petkov <bp@alien8.de>, the log shows:

[    0.826119] intel_pstate: default limits 0xc 0x1d 0x24
[    0.827000] intel_pstate: CPU0 - ACPI _PSS perf data
[    0.827020]      *P0: 2901 MHz, 35000 mW, 0xff00
The above control value of 0xff00, is invalid. The first entry sets the
max control value for turbo with a max non turbo frequency + 1 MHz. Here
the control values should be 0x1d00. intel_pstate_set_policy() depends on
this control value in setting correct max pstate.
Two fixes have been done here:
- If the control value is invalid then use the physical max turbo as the
max. Here 0xff00 will be changed to 0x1d00
- Always reset the limits->min_perf_ctl and limits->max_perf_ctl, so that
we will not use last value. In this case even if entry is not found the
_PSS it will fallback to limits->max_perf and limits-> limits->max_perf.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d3159f0..fc99e97 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -311,6 +311,13 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
 		 * correct max turbo frequency based on the turbo ratio.
 		 * Also need to convert to MHz as _PSS freq is in MHz.
 		 */
+		if (turbo_pss_ctl > cpu->pstate.turbo_pstate) {
+			/* We hava an invalid control value here */
+			turbo_pss_ctl = cpu->pstate.turbo_pstate;
+			cpu->acpi_perf_data.states[0].control =
+							turbo_pss_ctl << 8;
+		}
+
 		cpu->acpi_perf_data.states[0].core_frequency =
 				turbo_pss_ctl * cpu->pstate.scaling / 1000;
 	}
@@ -1272,6 +1279,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 #if IS_ENABLED(CONFIG_ACPI)
 	cpu = all_cpu_data[policy->cpu];
+	limits->min_perf_ctl = 0;
+	limits->max_perf_ctl = 0;
 	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
 		int control;
 
-- 
2.4.3

