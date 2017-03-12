From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 08/14] cpufreq: intel_pstate: Drop driver_registered variable
Date: Sun, 12 Mar 2017 18:19:54 +0100
Message-ID: <3814685.71gt9ux6pf@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56084 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934653AbdCLRck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:40 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The driver_registered variable in intel_pstate is used for checking
whether or not the driver has been registered, but intel_pstate_driver
can be used for that too (with the rule that the driver is not
registered as long as it is NULL).

That is a bit more straightforward and the code may be simplified
a bit this way, so modify the driver accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   46 ++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -370,7 +370,7 @@ static struct pstate_adjust_policy pid_p
 static int hwp_active __read_mostly;
 static bool per_cpu_limits __read_mostly;
 
-static bool driver_registered __read_mostly;
+static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
@@ -1083,7 +1083,7 @@ static ssize_t show_turbo_pct(struct kob
 
 	mutex_lock(&intel_pstate_driver_lock);
 
-	if (!driver_registered) {
+	if (!intel_pstate_driver) {
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EAGAIN;
 	}
@@ -1108,7 +1108,7 @@ static ssize_t show_num_pstates(struct k
 
 	mutex_lock(&intel_pstate_driver_lock);
 
-	if (!driver_registered) {
+	if (!intel_pstate_driver) {
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EAGAIN;
 	}
@@ -1128,7 +1128,7 @@ static ssize_t show_no_turbo(struct kobj
 
 	mutex_lock(&intel_pstate_driver_lock);
 
-	if (!driver_registered) {
+	if (!intel_pstate_driver) {
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EAGAIN;
 	}
@@ -1156,7 +1156,7 @@ static ssize_t store_no_turbo(struct kob
 
 	mutex_lock(&intel_pstate_driver_lock);
 
-	if (!driver_registered) {
+	if (!intel_pstate_driver) {
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EAGAIN;
 	}
@@ -1194,7 +1194,7 @@ static ssize_t store_max_perf_pct(struct
 
 	mutex_lock(&intel_pstate_driver_lock);
 
-	if (!driver_registered) {
+	if (!intel_pstate_driver) {
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EAGAIN;
 	}
@@ -1231,7 +1231,7 @@ static ssize_t store_min_perf_pct(struct
 
 	mutex_lock(&intel_pstate_driver_lock);
 
-	if (!driver_registered) {
+	if (!intel_pstate_driver) {
 		mutex_unlock(&intel_pstate_driver_lock);
 		return -EAGAIN;
 	}
@@ -2346,7 +2346,7 @@ static struct cpufreq_driver intel_cpufr
 	.name		= "intel_cpufreq",
 };
 
-static struct cpufreq_driver *intel_pstate_driver = &intel_pstate;
+static struct cpufreq_driver *default_driver = &intel_pstate;
 
 static void intel_pstate_driver_cleanup(void)
 {
@@ -2363,12 +2363,14 @@ static void intel_pstate_driver_cleanup(
 		}
 	}
 	put_online_cpus();
+	intel_pstate_driver = NULL;
 }
 
-static int intel_pstate_register_driver(void)
+static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
 	int ret;
 
+	intel_pstate_driver = driver;
 	intel_pstate_init_limits(&powersave_limits);
 	intel_pstate_set_performance_limits(&performance_limits);
 	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE) &&
@@ -2383,10 +2385,6 @@ static int intel_pstate_register_driver(
 		return ret;
 	}
 
-	mutex_lock(&intel_pstate_limits_lock);
-	driver_registered = true;
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
 	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
 		intel_pstate_debug_expose_params();
@@ -2403,10 +2401,6 @@ static int intel_pstate_unregister_drive
 	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
 		intel_pstate_debug_hide_params();
 
-	mutex_lock(&intel_pstate_limits_lock);
-	driver_registered = false;
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	cpufreq_unregister_driver(intel_pstate_driver);
 	intel_pstate_driver_cleanup();
 
@@ -2415,7 +2409,7 @@ static int intel_pstate_unregister_drive
 
 static ssize_t intel_pstate_show_status(char *buf)
 {
-	if (!driver_registered)
+	if (!intel_pstate_driver)
 		return sprintf(buf, "off\n");
 
 	return sprintf(buf, "%s\n", intel_pstate_driver == &intel_pstate ?
@@ -2427,11 +2421,11 @@ static int intel_pstate_update_status(co
 	int ret;
 
 	if (size == 3 && !strncmp(buf, "off", size))
-		return driver_registered ?
+		return intel_pstate_driver ?
 			intel_pstate_unregister_driver() : -EINVAL;
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
-		if (driver_registered) {
+		if (intel_pstate_driver) {
 			if (intel_pstate_driver == &intel_pstate)
 				return 0;
 
@@ -2440,12 +2434,11 @@ static int intel_pstate_update_status(co
 				return ret;
 		}
 
-		intel_pstate_driver = &intel_pstate;
-		return intel_pstate_register_driver();
+		return intel_pstate_register_driver(&intel_pstate);
 	}
 
 	if (size == 7 && !strncmp(buf, "passive", size)) {
-		if (driver_registered) {
+		if (intel_pstate_driver) {
 			if (intel_pstate_driver != &intel_pstate)
 				return 0;
 
@@ -2454,8 +2447,7 @@ static int intel_pstate_update_status(co
 				return ret;
 		}
 
-		intel_pstate_driver = &intel_cpufreq;
-		return intel_pstate_register_driver();
+		return intel_pstate_register_driver(&intel_cpufreq);
 	}
 
 	return -EINVAL;
@@ -2684,7 +2676,7 @@ hwp_cpu_matched:
 	intel_pstate_sysfs_expose_params();
 
 	mutex_lock(&intel_pstate_driver_lock);
-	rc = intel_pstate_register_driver();
+	rc = intel_pstate_register_driver(default_driver);
 	mutex_unlock(&intel_pstate_driver_lock);
 	if (rc)
 		return rc;
@@ -2705,7 +2697,7 @@ static int __init intel_pstate_setup(cha
 		no_load = 1;
 	} else if (!strcmp(str, "passive")) {
 		pr_info("Passive mode enabled\n");
-		intel_pstate_driver = &intel_cpufreq;
+		default_driver = &intel_cpufreq;
 		no_hwp = 1;
 	}
 	if (!strcmp(str, "no_hwp")) {
