From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 15/16] cpufreq: intel_pstate: Do not walk policy->cpus
Date: Tue, 28 Mar 2017 00:22:16 +0200
Message-ID: <4947613.9Zkl8EZ6XE@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59890 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752545AbdC0WjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:39:08 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

intel_pstate_hwp_set() is the only function walking policy->cpus
in intel_pstate.  The rest of the code simply assumes one CPU per
policy, including the initialization code.

Therefore it doesn't make sense for intel_pstate_hwp_set() to
walk policy->cpus as it is guaranteed to have only one bit set
for policy->cpu.

For this reason, rearrange intel_pstate_hwp_set() to take the CPU
number as the argument and drop the loop over policy->cpus from it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  132 +++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 68 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -792,84 +792,80 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
-static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
+static void intel_pstate_hwp_set(unsigned int cpu)
 {
-	int min, hw_min, max, hw_max, cpu;
+	struct cpudata *cpu_data = all_cpu_data[cpu];
+	int min, hw_min, max, hw_max;
 	u64 value, cap;
+	s16 epp;
 
-	for_each_cpu(cpu, policy->cpus) {
-		struct cpudata *cpu_data = all_cpu_data[cpu];
-		s16 epp;
-
-		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
-		hw_min = HWP_LOWEST_PERF(cap);
-		if (global.no_turbo)
-			hw_max = HWP_GUARANTEED_PERF(cap);
-		else
-			hw_max = HWP_HIGHEST_PERF(cap);
-
-		max = fp_ext_toint(hw_max * cpu_data->max_perf);
-		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
-			min = max;
-		else
-			min = fp_ext_toint(hw_max * cpu_data->min_perf);
-
-		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
+	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
+	hw_min = HWP_LOWEST_PERF(cap);
+	if (global.no_turbo)
+		hw_max = HWP_GUARANTEED_PERF(cap);
+	else
+		hw_max = HWP_HIGHEST_PERF(cap);
 
-		value &= ~HWP_MIN_PERF(~0L);
-		value |= HWP_MIN_PERF(min);
+	max = fp_ext_toint(hw_max * cpu_data->max_perf);
+	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
+		min = max;
+	else
+		min = fp_ext_toint(hw_max * cpu_data->min_perf);
 
-		value &= ~HWP_MAX_PERF(~0L);
-		value |= HWP_MAX_PERF(max);
+	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 
-		if (cpu_data->epp_policy == cpu_data->policy)
-			goto skip_epp;
+	value &= ~HWP_MIN_PERF(~0L);
+	value |= HWP_MIN_PERF(min);
 
-		cpu_data->epp_policy = cpu_data->policy;
+	value &= ~HWP_MAX_PERF(~0L);
+	value |= HWP_MAX_PERF(max);
 
-		if (cpu_data->epp_saved >= 0) {
-			epp = cpu_data->epp_saved;
-			cpu_data->epp_saved = -EINVAL;
-			goto update_epp;
-		}
+	if (cpu_data->epp_policy == cpu_data->policy)
+		goto skip_epp;
 
-		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
-			epp = intel_pstate_get_epp(cpu_data, value);
-			cpu_data->epp_powersave = epp;
-			/* If EPP read was failed, then don't try to write */
-			if (epp < 0)
-				goto skip_epp;
-
-
-			epp = 0;
-		} else {
-			/* skip setting EPP, when saved value is invalid */
-			if (cpu_data->epp_powersave < 0)
-				goto skip_epp;
-
-			/*
-			 * No need to restore EPP when it is not zero. This
-			 * means:
-			 *  - Policy is not changed
-			 *  - user has manually changed
-			 *  - Error reading EPB
-			 */
-			epp = intel_pstate_get_epp(cpu_data, value);
-			if (epp)
-				goto skip_epp;
+	cpu_data->epp_policy = cpu_data->policy;
 
-			epp = cpu_data->epp_powersave;
-		}
+	if (cpu_data->epp_saved >= 0) {
+		epp = cpu_data->epp_saved;
+		cpu_data->epp_saved = -EINVAL;
+		goto update_epp;
+	}
+
+	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		epp = intel_pstate_get_epp(cpu_data, value);
+		cpu_data->epp_powersave = epp;
+		/* If EPP read was failed, then don't try to write */
+		if (epp < 0)
+			goto skip_epp;
+
+		epp = 0;
+	} else {
+		/* skip setting EPP, when saved value is invalid */
+		if (cpu_data->epp_powersave < 0)
+			goto skip_epp;
+
+		/*
+		 * No need to restore EPP when it is not zero. This
+		 * means:
+		 *  - Policy is not changed
+		 *  - user has manually changed
+		 *  - Error reading EPB
+		 */
+		epp = intel_pstate_get_epp(cpu_data, value);
+		if (epp)
+			goto skip_epp;
+
+		epp = cpu_data->epp_powersave;
+	}
 update_epp:
-		if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
-			value &= ~GENMASK_ULL(31, 24);
-			value |= (u64)epp << 24;
-		} else {
-			intel_pstate_set_epb(cpu, epp);
-		}
-skip_epp:
-		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
+	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+	} else {
+		intel_pstate_set_epb(cpu, epp);
 	}
+skip_epp:
+	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
 static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
@@ -892,7 +888,7 @@ static int intel_pstate_resume(struct cp
 	mutex_lock(&intel_pstate_limits_lock);
 
 	all_cpu_data[policy->cpu]->epp_policy = 0;
-	intel_pstate_hwp_set(policy);
+	intel_pstate_hwp_set(policy->cpu);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
@@ -2057,7 +2053,7 @@ static int intel_pstate_set_policy(struc
 	intel_pstate_set_update_util_hook(policy->cpu);
 
 	if (hwp_active)
-		intel_pstate_hwp_set(policy);
+		intel_pstate_hwp_set(policy->cpu);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
