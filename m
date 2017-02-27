From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix operation mode switching
Date: Tue, 28 Feb 2017 00:05:01 +0100
Message-ID: <2958124.3ADodeN5Y5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61760 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751465AbdB0XQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2017 18:16:57 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a problem with intel_pstate operation mode switching
introduced by commit fb1fe1041c04 (cpufreq: intel_pstate: Operation
mode control from sysfs), because the global sysfs limits are
preserved across operation modes while per-policy limits are
reinitialized from scratch and both sets of limits may get out of
sync this wya.

Fix that by always reinitializing the global limits upon the
registration of the driver.

Fixes: fb1fe1041c04 (cpufreq: intel_pstate: Operation mode control from sysfs)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   65 +++++++++++++----------------------------
 1 file changed, 22 insertions(+), 43 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -364,37 +364,25 @@ static bool driver_registered __read_mos
 static bool acpi_ppc;
 #endif
 
-static struct perf_limits performance_limits = {
-	.no_turbo = 0,
-	.turbo_disabled = 0,
-	.max_perf_pct = 100,
-	.max_perf = int_ext_tofp(1),
-	.min_perf_pct = 100,
-	.min_perf = int_ext_tofp(1),
-	.max_policy_pct = 100,
-	.max_sysfs_pct = 100,
-	.min_policy_pct = 0,
-	.min_sysfs_pct = 0,
-};
+static struct perf_limits performance_limits;
+static struct perf_limits powersave_limits;
+static struct perf_limits *limits;
 
-static struct perf_limits powersave_limits = {
-	.no_turbo = 0,
-	.turbo_disabled = 0,
-	.max_perf_pct = 100,
-	.max_perf = int_ext_tofp(1),
-	.min_perf_pct = 0,
-	.min_perf = 0,
-	.max_policy_pct = 100,
-	.max_sysfs_pct = 100,
-	.min_policy_pct = 0,
-	.min_sysfs_pct = 0,
-};
+static void intel_pstate_init_limits(struct perf_limits *limits)
+{
+	memset(limits, 0, sizeof(*limits));
+	limits->max_perf_pct = 100;
+	limits->max_perf = int_ext_tofp(1);
+	limits->max_policy_pct = 100;
+	limits->max_sysfs_pct = 100;
+}
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-static struct perf_limits *limits = &performance_limits;
-#else
-static struct perf_limits *limits = &powersave_limits;
-#endif
+static void intel_pstate_set_performance_limits(struct perf_limits *limits)
+{
+	intel_pstate_init_limits(limits);
+	limits->min_perf_pct = 100;
+	limits->min_perf = int_ext_tofp(1);
+}
 
 static DEFINE_MUTEX(intel_pstate_driver_lock);
 static DEFINE_MUTEX(intel_pstate_limits_lock);
@@ -2084,20 +2072,6 @@ static void intel_pstate_clear_update_ut
 	synchronize_sched();
 }
 
-static void intel_pstate_set_performance_limits(struct perf_limits *limits)
-{
-	limits->no_turbo = 0;
-	limits->turbo_disabled = 0;
-	limits->max_perf_pct = 100;
-	limits->max_perf = int_ext_tofp(1);
-	limits->min_perf_pct = 100;
-	limits->min_perf = int_ext_tofp(1);
-	limits->max_policy_pct = 100;
-	limits->max_sysfs_pct = 100;
-	limits->min_policy_pct = 0;
-	limits->min_sysfs_pct = 0;
-}
-
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct perf_limits *limits)
 {
@@ -2466,6 +2440,11 @@ static int intel_pstate_register_driver(
 {
 	int ret;
 
+	intel_pstate_init_limits(&powersave_limits);
+	intel_pstate_set_performance_limits(&performance_limits);
+	limits = IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE) ?
+			&performance_limits : &powersave_limits;
+
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
 		intel_pstate_driver_cleanup();
