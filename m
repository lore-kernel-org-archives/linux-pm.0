From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 03/16] cpufreq: intel_pstate: Initialize pid_params statically
Date: Tue, 28 Mar 2017 00:05:44 +0200
Message-ID: <3316890.rXW5Ee2Yl6@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58594 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752633AbdC0Wno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:43:44 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that both the existing struct cpu_defaults instances in which
PID parameters are actually initialized use the same values of those
parameters, so it is not really necessary to copy them over to
pid_params dynamically.

Instead, initialize pid_params statically with those values and
drop the unused pid_policy member from struct cpu_defaults along
with copy_pid_params() used for initializing it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   42 +++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -321,19 +321,26 @@ struct pstate_funcs {
 
 /**
  * struct cpu_defaults- Per CPU model default config data
- * @pid_policy:	PID config data
  * @funcs:		Callback function data
  */
 struct cpu_defaults {
-	struct pstate_adjust_policy pid_policy;
 	struct pstate_funcs funcs;
 };
 
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 
-static struct pstate_adjust_policy pid_params __read_mostly;
 static struct pstate_funcs pstate_funcs __read_mostly;
+static struct pstate_adjust_policy pid_params __read_mostly = {
+	.sample_rate_ms = 10,
+	.sample_rate_ns = 10 * NSEC_PER_MSEC,
+	.deadband = 0,
+	.setpoint = 97,
+	.p_gain_pct = 20,
+	.d_gain_pct = 0,
+	.i_gain_pct = 0,
+};
+
 static int hwp_active __read_mostly;
 static bool per_cpu_limits __read_mostly;
 
@@ -1520,14 +1527,6 @@ static int knl_get_turbo_pstate(void)
 }
 
 static struct cpu_defaults core_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 97,
-		.p_gain_pct = 20,
-		.d_gain_pct = 0,
-		.i_gain_pct = 0,
-	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
 		.get_max_physical = core_get_max_pstate_physical,
@@ -1566,14 +1565,6 @@ static const struct cpu_defaults airmont
 };
 
 static const struct cpu_defaults knl_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 97,
-		.p_gain_pct = 20,
-		.d_gain_pct = 0,
-		.i_gain_pct = 0,
-	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
 		.get_max_physical = core_get_max_pstate_physical,
@@ -2412,17 +2403,6 @@ static int __init intel_pstate_msrs_not_
 	return 0;
 }
 
-static void __init copy_pid_params(struct pstate_adjust_policy *policy)
-{
-	pid_params.sample_rate_ms = policy->sample_rate_ms;
-	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
-	pid_params.p_gain_pct = policy->p_gain_pct;
-	pid_params.i_gain_pct = policy->i_gain_pct;
-	pid_params.d_gain_pct = policy->d_gain_pct;
-	pid_params.deadband = policy->deadband;
-	pid_params.setpoint = policy->setpoint;
-}
-
 #ifdef CONFIG_ACPI
 static void intel_pstate_use_acpi_profile(void)
 {
@@ -2614,8 +2594,6 @@ static int __init intel_pstate_init(void
 
 		cpu_def = (struct cpu_defaults *)id->driver_data;
 		copy_cpu_funcs(&cpu_def->funcs);
-		if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance)
-			copy_pid_params(&cpu_def->pid_policy);
 	}
 
 	if (intel_pstate_msrs_not_valid())
