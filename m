From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 1/2] cpufreq: intel_pstate: Expose global sysfs attributes upfront
Date: Thu, 05 Jan 2017 02:51:38 +0100
Message-ID: <2389828.jxMzLa8mev@aspire.rjw.lan>
References: <21825845.nN3skUNMsO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53997 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758918AbdAEB5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2017 20:57:31 -0500
In-Reply-To: <21825845.nN3skUNMsO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Expose the intel_pstate's global sysfs attributes before registering
the driver to prepare for the addition of an attribute that also will
have to work if the driver is not registered.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   67 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -358,6 +358,8 @@ static struct pstate_funcs pstate_funcs
 static int hwp_active __read_mostly;
 static bool per_cpu_limits __read_mostly;
 
+static bool driver_registered __read_mostly;
+
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
 #endif
@@ -394,6 +396,7 @@ static struct perf_limits *limits = &per
 static struct perf_limits *limits = &powersave_limits;
 #endif
 
+static DEFINE_MUTEX(intel_pstate_driver_lock);
 static DEFINE_MUTEX(intel_pstate_limits_lock);
 
 #ifdef CONFIG_ACPI
@@ -1055,12 +1058,22 @@ static ssize_t show_turbo_pct(struct kob
 	int total, no_turbo, turbo_pct;
 	uint32_t turbo_fp;
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!driver_registered) {
+		mutex_unlock(&intel_pstate_limits_lock);
+		return -EAGAIN;
+	}
+
 	cpu = all_cpu_data[0];
 
 	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
 	no_turbo = cpu->pstate.max_pstate - cpu->pstate.min_pstate + 1;
 	turbo_fp = div_fp(no_turbo, total);
 	turbo_pct = 100 - fp_toint(mul_fp(turbo_fp, int_tofp(100)));
+
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return sprintf(buf, "%u\n", turbo_pct);
 }
 
@@ -1070,8 +1083,18 @@ static ssize_t show_num_pstates(struct k
 	struct cpudata *cpu;
 	int total;
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!driver_registered) {
+		mutex_unlock(&intel_pstate_limits_lock);
+		return -EAGAIN;
+	}
+
 	cpu = all_cpu_data[0];
 	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
+
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return sprintf(buf, "%u\n", total);
 }
 
@@ -1080,12 +1103,21 @@ static ssize_t show_no_turbo(struct kobj
 {
 	ssize_t ret;
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!driver_registered) {
+		mutex_unlock(&intel_pstate_limits_lock);
+		return -EAGAIN;
+	}
+
 	update_turbo_state();
 	if (limits->turbo_disabled)
 		ret = sprintf(buf, "%u\n", limits->turbo_disabled);
 	else
 		ret = sprintf(buf, "%u\n", limits->no_turbo);
 
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return ret;
 }
 
@@ -1099,6 +1131,13 @@ static ssize_t store_no_turbo(struct kob
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!driver_registered) {
+		mutex_unlock(&intel_pstate_driver_lock);
+		return -EAGAIN;
+	}
+
 	mutex_lock(&intel_pstate_limits_lock);
 
 	update_turbo_state();
@@ -1114,6 +1153,8 @@ static ssize_t store_no_turbo(struct kob
 
 	intel_pstate_update_policies();
 
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return count;
 }
 
@@ -1127,6 +1168,13 @@ static ssize_t store_max_perf_pct(struct
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!driver_registered) {
+		mutex_unlock(&intel_pstate_driver_lock);
+		return -EAGAIN;
+	}
+
 	mutex_lock(&intel_pstate_limits_lock);
 
 	limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
@@ -1142,6 +1190,8 @@ static ssize_t store_max_perf_pct(struct
 
 	intel_pstate_update_policies();
 
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return count;
 }
 
@@ -1155,6 +1205,13 @@ static ssize_t store_min_perf_pct(struct
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&intel_pstate_driver_lock);
+
+	if (!driver_registered) {
+		mutex_unlock(&intel_pstate_driver_lock);
+		return -EAGAIN;
+	}
+
 	mutex_lock(&intel_pstate_limits_lock);
 
 	limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
@@ -1170,6 +1227,8 @@ static ssize_t store_min_perf_pct(struct
 
 	intel_pstate_update_policies();
 
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	return count;
 }
 
@@ -2489,16 +2548,20 @@ hwp_cpu_matched:
 
 	intel_pstate_request_control_from_smm();
 
+	intel_pstate_sysfs_expose_params();
+
 	rc = cpufreq_register_driver(intel_pstate_driver);
 	if (rc)
 		goto out;
 
+	mutex_lock(&intel_pstate_driver_lock);
+	driver_registered = true;
+	mutex_unlock(&intel_pstate_driver_lock);
+
 	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
 	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
 		intel_pstate_debug_expose_params();
 
-	intel_pstate_sysfs_expose_params();
-
 	if (hwp_active)
 		pr_info("HWP enabled\n");
 

