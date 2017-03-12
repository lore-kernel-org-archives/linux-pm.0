From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 02/14] cpufreq: intel_pstate: Drop pointless initialization of PID parameters
Date: Sun, 12 Mar 2017 18:13:57 +0100
Message-ID: <4421678.SbyKC18OPh@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60092 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934670AbdCLRco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:44 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The P-state selection algorithm used by intel_pstate for Atom
processors is not based on the PID controller and the initialization
of PID parametrs for those processors is pointless and confusing, so
drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1592,14 +1592,6 @@ static struct cpu_defaults core_params =
 };
 
 static const struct cpu_defaults silvermont_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 60,
-		.p_gain_pct = 14,
-		.d_gain_pct = 0,
-		.i_gain_pct = 4,
-	},
 	.funcs = {
 		.get_max = atom_get_max_pstate,
 		.get_max_physical = atom_get_max_pstate,
@@ -1613,14 +1605,6 @@ static const struct cpu_defaults silverm
 };
 
 static const struct cpu_defaults airmont_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 60,
-		.p_gain_pct = 14,
-		.d_gain_pct = 0,
-		.i_gain_pct = 4,
-	},
 	.funcs = {
 		.get_max = atom_get_max_pstate,
 		.get_max_physical = atom_get_max_pstate,
@@ -1654,14 +1638,6 @@ static const struct cpu_defaults knl_par
 };
 
 static const struct cpu_defaults bxt_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 60,
-		.p_gain_pct = 14,
-		.d_gain_pct = 0,
-		.i_gain_pct = 4,
-	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
 		.get_max_physical = core_get_max_pstate_physical,
@@ -2721,9 +2697,9 @@ static int __init intel_pstate_init(void
 		return -ENODEV;
 
 	cpu_def = (struct cpu_defaults *)id->driver_data;
-
-	copy_pid_params(&cpu_def->pid_policy);
 	copy_cpu_funcs(&cpu_def->funcs);
+	if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance)
+		copy_pid_params(&cpu_def->pid_policy);
 
 	if (intel_pstate_msrs_not_valid())
 		return -ENODEV;
