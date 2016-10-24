From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: intel_pstate: Always set max P-state in performance mode
Date: Mon, 24 Oct 2016 23:13:21 +0200
Message-ID: <4054311.5ikcasqymj@vostro.rjw.lan>
References: <1490845.P5jEmYeGuo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490845.P5jEmYeGuo@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only times at which intel_pstate checks the policy set for
a given CPU is the initialization of that CPU and updates of its
policy settings from cpufreq when intel_pstate_set_policy() is
invoked.

That is insufficient, however, because intel_pstate uses the same
P-state selection function for all CPUs regardless of the policy
setting for each of them and the P-state limits are shared between
them.  Thus if the policy is set to "performance" for a particular
CPU, it may not behave as expected if the cpufreq settings are
changed subsequently for another CPU.

That can be easily demonstrated by writing "performance" to
scaling_governor for all CPUs and then switching it to "powersave"
for one of them in which case all of the CPUs will behave as though
their scaling_governor were all "powersave" (even though the policy
still appears to be "performance" for the remaining CPUs).

Fix this problem by modifying intel_pstate_adjust_busy_pstate() to
always set the P-state to the maximum allowed by the current limits
for all CPUs whose policy is set to "performance".

Note that it still is recommended to always change the policy setting
in the same way for all CPUs even with this fix applied to avoid
confusion.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Changelog update.

---
 drivers/cpufreq/intel_pstate.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -179,6 +179,7 @@ struct _pid {
 /**
  * struct cpudata -	Per CPU instance data storage
  * @cpu:		CPU number for this instance data
+ * @policy:		CPUFreq policy value
  * @update_util:	CPUFreq utility callback information
  * @update_util_set:	CPUFreq utility callback is set
  * @iowait_boost:	iowait-related boost fraction
@@ -201,6 +202,7 @@ struct _pid {
 struct cpudata {
 	int cpu;
 
+	unsigned int policy;
 	struct update_util_data update_util;
 	bool   update_util_set;
 
@@ -1331,7 +1333,8 @@ static inline void intel_pstate_adjust_b
 
 	from = cpu->pstate.current_pstate;
 
-	target_pstate = pstate_funcs.get_target_pstate(cpu);
+	target_pstate = cpu->policy == CPUFREQ_POLICY_PERFORMANCE ?
+		cpu->pstate.turbo_pstate : pstate_funcs.get_target_pstate(cpu);
 
 	intel_pstate_update_pstate(cpu, target_pstate);
 
@@ -1498,6 +1501,8 @@ static int intel_pstate_set_policy(struc
 		 policy->cpuinfo.max_freq, policy->max);
 
 	cpu = all_cpu_data[policy->cpu];
+	cpu->policy = policy->policy;
+
 	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
 	    policy->max < policy->cpuinfo.max_freq &&
 	    policy->max > cpu->pstate.max_pstate * cpu->pstate.scaling) {
@@ -1505,7 +1510,7 @@ static int intel_pstate_set_policy(struc
 		policy->max = policy->cpuinfo.max_freq;
 	}
 
-	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		limits = &performance_limits;
 		if (policy->max >= policy->cpuinfo.max_freq) {
 			pr_debug("set performance\n");
@@ -1541,7 +1546,7 @@ static int intel_pstate_set_policy(struc
 	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
 
  out:
-	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		/*
 		 * NOHZ_FULL CPUs need this as the governor callback may not
 		 * be invoked on them.
