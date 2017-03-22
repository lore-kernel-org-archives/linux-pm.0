From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/5] cpufreq: intel_pstate: Support HWP processors in all operation modes
Date: Wed, 22 Mar 2017 23:52:18 +0100
Message-ID: <1516950.NJ47SGUCpy@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54337 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751711AbdCVXow (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 19:44:52 -0400
In-Reply-To: <2025489.DxMTzKos7o@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, some processors supporting HWP are only supported by
intel_pstate if HWP is actually going to be used and not supported
otherwise which is confusing.

Specifically, they are not supported if "intel_pstate=no_hwp" is
passed to the kernel in the command line or if the driver is started
in the passive mode ("intel_pstate=passive").

There is no real reason for that, because everything about those
processor is known anyway and the driver can work with them in all
modes, so make that happen, but use the load-based P-state selection
algorithm for the active mode "powersave" policy with them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2627,28 +2627,33 @@ static const struct x86_cpu_id hwp_suppo
 
 static int __init intel_pstate_init(void)
 {
-	const struct x86_cpu_id *id;
-	struct cpu_defaults *cpu_def;
-	int rc = 0;
+	int rc;
 
 	if (no_load)
 		return -ENODEV;
 
-	if (x86_match_cpu(hwp_support_ids) && !no_hwp) {
+	if (x86_match_cpu(hwp_support_ids)) {
 		copy_cpu_funcs(&core_params.funcs);
-		hwp_active++;
-		intel_pstate.attr = hwp_cpufreq_attrs;
-		goto hwp_cpu_matched;
-	}
-
-	id = x86_match_cpu(intel_pstate_cpu_ids);
-	if (!id)
-		return -ENODEV;
+		if (no_hwp) {
+			pstate_funcs.get_target_pstate = get_target_pstate_use_cpu_load;
+		} else {
+			hwp_active++;
+			intel_pstate.attr = hwp_cpufreq_attrs;
+			goto hwp_cpu_matched;
+		}
+	} else {
+		const struct x86_cpu_id *id;
+		struct cpu_defaults *cpu_def;
+
+		id = x86_match_cpu(intel_pstate_cpu_ids);
+		if (!id)
+			return -ENODEV;
 
-	cpu_def = (struct cpu_defaults *)id->driver_data;
+		cpu_def = (struct cpu_defaults *)id->driver_data;
 
-	copy_pid_params(&cpu_def->pid_policy);
-	copy_cpu_funcs(&cpu_def->funcs);
+		copy_pid_params(&cpu_def->pid_policy);
+		copy_cpu_funcs(&cpu_def->funcs);
+	}
 
 	if (intel_pstate_msrs_not_valid())
 		return -ENODEV;
