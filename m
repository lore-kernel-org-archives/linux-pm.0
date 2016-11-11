From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Use cpu load based algorithm for mobile class devices
Date: Fri, 11 Nov 2016 15:47:39 -0800
Message-ID: <1478908059-56178-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1532 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933797AbcKKXsV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 18:48:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use get_target_pstate_use_cpu_load() to calculate target P-State for
devices, which uses preferred power management profile as PM_MOBILE
in ACPI FADT.
This may help in resolving some thermal issues caused by low sustained
cpu bound workloads. The current algorithm tend to over provision in this
case as it doesn't look at the CPU busyness.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eb76073..8f683e2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1828,6 +1828,19 @@ static void __init copy_pid_params(struct pstate_adjust_policy *policy)
 	pid_params.setpoint = policy->setpoint;
 }
 
+#ifdef CONFIG_ACPI
+static void intel_pstate_use_acpi_profile(void)
+{
+	if (acpi_gbl_FADT.preferred_profile == PM_MOBILE)
+		pstate_funcs.get_target_pstate =
+				get_target_pstate_use_cpu_load;
+}
+#else
+static void intel_pstate_use_acpi_profile(struct pstate_funcs *funcs)
+{
+}
+#endif
+
 static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 {
 	pstate_funcs.get_max   = funcs->get_max;
@@ -1839,6 +1852,7 @@ static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_vid   = funcs->get_vid;
 	pstate_funcs.get_target_pstate = funcs->get_target_pstate;
 
+	intel_pstate_use_acpi_profile();
 }
 
 #ifdef CONFIG_ACPI
-- 
2.7.4

