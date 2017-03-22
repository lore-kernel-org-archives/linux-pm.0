From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] cpufreq: intel_pstate: Avoid transient updates of cpuinfo.max_freq
Date: Thu, 23 Mar 2017 00:00:47 +0100
Message-ID: <49685796.Sn2bycvJLn@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50255 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751414AbdCVXov (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 19:44:51 -0400
In-Reply-To: <2025489.DxMTzKos7o@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both intel_pstate_verify_policy() and intel_cpufreq_verify_policy()
set policy->cpuinfo.max_freq depending on the turbo status, but the
updates made by them are discarded by the core, because the policy
object passed to them by the core is temporary and cpuinfo.max_freq
from that object is not copied to the final policy object in
cpufreq_set_policy().

However, cpufreq_set_policy() passes the temporary policy object
to the ->setpolicy callback of the driver, so intel_pstate_set_policy()
actually sees the policy->cpuinfo.max_freq value updated by
intel_pstate_verify_policy() and not the final one.  It also
updates policy->max sometimes which basically has no effect after
it returns, because the core discards that update.

To avoid confusion, eliminate policy->cpuinfo.max_freq updates from
intel_pstate_verify_policy() and intel_cpufreq_verify_policy()
entirely and check the maximum frequency explicitly in
intel_pstate_update_perf_limits() instead of relying on the
transiently updated policy->cpuinfo.max_freq value.

Moreover, move the max->policy adjustment carried out in
intel_pstate_set_policy() to a separate function and call that
function from the ->verify driver callbacks to ensure that it will
actually be effective.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   47 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2021,19 +2021,25 @@ static void intel_pstate_clear_update_ut
 	synchronize_sched();
 }
 
+static int intel_pstate_get_max_freq(struct cpudata *cpu)
+{
+	return global.turbo_disabled || global.no_turbo ?
+			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+}
+
 static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
 					    struct cpudata *cpu)
 {
 	struct perf_limits *limits = &cpu->perf_limits;
+	int max_freq = intel_pstate_get_max_freq(cpu);
 	int32_t max_policy_perf, min_policy_perf;
 
-	max_policy_perf = div_ext_fp(policy->max, policy->cpuinfo.max_freq);
+	max_policy_perf = div_ext_fp(policy->max, max_freq);
 	max_policy_perf = clamp_t(int32_t, max_policy_perf, 0, int_ext_tofp(1));
 	if (policy->max == policy->min) {
 		min_policy_perf = max_policy_perf;
 	} else {
-		min_policy_perf = div_ext_fp(policy->min,
-					     policy->cpuinfo.max_freq);
+		min_policy_perf = div_ext_fp(policy->min, max_freq);
 		min_policy_perf = clamp_t(int32_t, min_policy_perf,
 					  0, max_policy_perf);
 	}
@@ -2048,7 +2054,7 @@ static void intel_pstate_update_perf_lim
 		/* Global limits are in percent of the maximum turbo P-state. */
 		global_max = percent_ext_fp(global.max_perf_pct);
 		global_min = percent_ext_fp(global.min_perf_pct);
-		if (policy->cpuinfo.max_freq != cpu->pstate.turbo_freq) {
+		if (max_freq != cpu->pstate.turbo_freq) {
 			int32_t turbo_factor;
 
 			turbo_factor = div_ext_fp(cpu->pstate.turbo_pstate,
@@ -2088,13 +2094,6 @@ static int intel_pstate_set_policy(struc
 	cpu = all_cpu_data[policy->cpu];
 	cpu->policy = policy->policy;
 
-	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
-	    policy->max < policy->cpuinfo.max_freq &&
-	    policy->max > cpu->pstate.max_pstate * cpu->pstate.scaling) {
-		pr_debug("policy->max > max non turbo frequency\n");
-		policy->max = policy->cpuinfo.max_freq;
-	}
-
 	mutex_lock(&intel_pstate_limits_lock);
 
 	intel_pstate_update_perf_limits(policy, cpu);
@@ -2118,21 +2117,31 @@ static int intel_pstate_set_policy(struc
 	return 0;
 }
 
+static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
+					 struct cpudata *cpu)
+{
+	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
+	    policy->max < policy->cpuinfo.max_freq &&
+	    policy->max > cpu->pstate.max_freq) {
+		pr_debug("policy->max > max non turbo frequency\n");
+		policy->max = policy->cpuinfo.max_freq;
+	}
+}
+
 static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
-	policy->cpuinfo.max_freq = global.turbo_disabled || global.no_turbo ?
-					cpu->pstate.max_freq :
-					cpu->pstate.turbo_freq;
-
-	cpufreq_verify_within_cpu_limits(policy);
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     intel_pstate_get_max_freq(cpu));
 
 	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
+	intel_pstate_adjust_policy_max(policy, cpu);
+
 	return 0;
 }
 
@@ -2227,10 +2236,10 @@ static int intel_cpufreq_verify_policy(s
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
-	policy->cpuinfo.max_freq = global.no_turbo || global.turbo_disabled ?
-			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     intel_pstate_get_max_freq(cpu));
 
-	cpufreq_verify_within_cpu_limits(policy);
+	intel_pstate_adjust_policy_max(policy, cpu);
 
 	intel_pstate_update_perf_limits(policy, cpu);
 
