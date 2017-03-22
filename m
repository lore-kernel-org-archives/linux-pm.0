From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/5] cpufreq: intel_pstate: Use load-based P-state selection more widely
Date: Wed, 22 Mar 2017 23:53:54 +0100
Message-ID: <135486514.0oxrMEpPDc@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56652 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751569AbdCVXov (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 19:44:51 -0400
In-Reply-To: <2025489.DxMTzKos7o@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Extend the set of systems for which intel_pstate will use the
"powersave" P-state selection algorithm based on CPU load in the
active mode by systems with ACPI preferred profile set to "tablet",
"appliance PC", "desktop", or "workstation" (ie. everything with a
specified preferred profile that is not a "server").

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2469,9 +2469,15 @@ static void __init copy_pid_params(struc
 #ifdef CONFIG_ACPI
 static void intel_pstate_use_acpi_profile(void)
 {
-	if (acpi_gbl_FADT.preferred_profile == PM_MOBILE)
+	switch (acpi_gbl_FADT.preferred_profile) {
+	case PM_MOBILE:
+	case PM_TABLET:
+	case PM_APPLIANCE_PC:
+	case PM_DESKTOP:
+	case PM_WORKSTATION:
 		pstate_funcs.get_target_pstate =
 				get_target_pstate_use_cpu_load;
+	}
 }
 #else
 static void intel_pstate_use_acpi_profile(void)
