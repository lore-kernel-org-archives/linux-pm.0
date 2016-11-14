From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Use cpu load based algorithm for PM_MOBILE
Date: Mon, 14 Nov 2016 10:31:11 -0800
Message-ID: <1479148271-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49389 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936411AbcKNSbm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 13:31:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, rdunlap@infradead.org, sfr@canb.auug.org.au, arnd@arndb.de, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use get_target_pstate_use_cpu_load() to calculate target P-State for
devices, which uses preferred power management profile as PM_MOBILE
in ACPI FADT.
This may help in resolving some thermal issues caused by low sustained
cpu bound workloads. The current algorithm tend to over provision in this
case as it doesn't look at the CPU busyness.

Also included the fix from Arnd Bergmann <arnd@arndb.de> to solve compile
issue, when CONFIG_ACPI is not defined.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Include fix from Arnd Bergmann for fixing compile issue

 drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eb76073..9be0720 100644
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
+static void intel_pstate_use_acpi_profile(void)
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

