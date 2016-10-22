From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH] cpufreq: intel_pstate: Use cpu load based algorithm for PM_MOBILE
Date: Fri, 21 Oct 2016 18:31:25 -0700
Message-ID: <1477099885-6697-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14083 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755463AbcJVBfi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 21:35:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use get_target_pstate_use_cpu_load() to calculate target P-State for
devices, which uses preferred power management profile as PM_MOBILE
in ACPI FADT.
This may help in resolving some thermal issues caused by low sustained
cpu bound workloads. The current algorithm tend to over provision in this
case as it doesn't look at the CPU busyness.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
If some wants to look at test results, email me. I can't attach
pdf document here.

 drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d9a0196..637536d8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1746,6 +1746,19 @@ static void __init copy_pid_params(struct pstate_adjust_policy *policy)
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
@@ -1757,6 +1770,7 @@ static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_vid   = funcs->get_vid;
 	pstate_funcs.get_target_pstate = funcs->get_target_pstate;
 
+	intel_pstate_use_acpi_profile();
 }
 
 #ifdef CONFIG_ACPI
-- 
2.5.5

