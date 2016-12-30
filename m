From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] cpufreq: intel_pstate: Always keep all limits settings in sync
Date: Fri, 30 Dec 2016 15:58:21 +0100
Message-ID: <2349114.gCZGRj0iOf@aspire.rjw.lan>
References: <5344750.TOCWYON8QY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52910 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753902AbcL3PCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 10:02:53 -0500
In-Reply-To: <5344750.TOCWYON8QY@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_pstate update per-logical-CPU limits when the global
settings are changed to ensure that they are always in sync and
users will not see confusing values in per-logical-CPU sysfs
attributes.

This also fixes the problem that setting the "no_turbo" global
attribute to 1 in the "passive" mode (ie. when intel_pstate acts
as a regular cpufreq driver) when scaling_governor is set to
"performance" has no effect.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -857,13 +857,13 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
-static void intel_pstate_hwp_set(const struct cpumask *cpumask)
+static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
 	struct perf_limits *perf_limits = limits;
 	u64 value, cap;
 
-	for_each_cpu(cpu, cpumask) {
+	for_each_cpu(cpu, policy->cpus) {
 		int max_perf_pct, min_perf_pct;
 		struct cpudata *cpu_data = all_cpu_data[cpu];
 		s16 epp;
@@ -949,7 +949,7 @@ skip_epp:
 static int intel_pstate_hwp_set_policy(struct cpufreq_policy *policy)
 {
 	if (hwp_active)
-		intel_pstate_hwp_set(policy->cpus);
+		intel_pstate_hwp_set(policy);
 
 	return 0;
 }
@@ -984,11 +984,12 @@ static int intel_pstate_resume(struct cp
 	return ret;
 }
 
-static void intel_pstate_hwp_set_online_cpus(void)
+static void intel_pstate_update_policies(void)
 {
-	get_online_cpus();
-	intel_pstate_hwp_set(cpu_online_mask);
-	put_online_cpus();
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpufreq_update_policy(cpu);
 }
 
 /************************** debugfs begin ************************/
@@ -1109,11 +1110,10 @@ static ssize_t store_no_turbo(struct kob
 
 	limits->no_turbo = clamp_t(int, input, 0, 1);
 
-	if (hwp_active)
-		intel_pstate_hwp_set_online_cpus();
-
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	return count;
 }
 
@@ -1138,11 +1138,10 @@ static ssize_t store_max_perf_pct(struct
 				   limits->max_perf_pct);
 	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
 
-	if (hwp_active)
-		intel_pstate_hwp_set_online_cpus();
-
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	return count;
 }
 
@@ -1167,11 +1166,10 @@ static ssize_t store_min_perf_pct(struct
 				   limits->min_perf_pct);
 	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
 
-	if (hwp_active)
-		intel_pstate_hwp_set_online_cpus();
-
 	mutex_unlock(&intel_pstate_limits_lock);
 
+	intel_pstate_update_policies();
+
 	return count;
 }
 

