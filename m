From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: Avoid a couple of races related to cpufreq_cpu_get()
Date: Wed, 16 Nov 2016 03:38:40 +0100
Message-ID: <7191200.L2L3Fy8tSf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58299 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752411AbcKPCbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 21:31:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpumask_test_cpu() check in cpufreq_cpu_get_raw() is sort of
pointless, because it may be racy with respect to CPU online/offline
which sets/clears the policy->cpus mask.

Some of the races resulting from that are benign (worst case, stale
values may be returned from some sysfs attribute for a relatively
short period), but some of them may lead to invocations of low-level
cpufreq driver callbacks for offline CPUs which is not guaranteed to
work in general.

For this reason, move the cpumask_test_cpu() check away from
cpufreq_cpu_get_raw() and reserve it for the ondemand governor,
which calls it for online CPUs only and with CPU online/offline
locked anyway, and make the other callers of it use the per-CPU
variable whose value is returned by it directly.

With that, add the cpumask_test_cpu() check to cpufreq_generic_get()
to preserve its current behavior for offline CPUs and to the callers
of cpufreq_cpu_get().  There, in the cases when the races might
lead to invocations of driver callbacks for offline CPUs, put it
under policy->rwsem.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
 * Modify the changelog to make it better explain what's going on.
 * Add the missing cpumask_test_cpu() check to cpufreq_offline().

---
 drivers/cpufreq/cpufreq.c |   52 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -65,6 +65,12 @@ static struct cpufreq_driver *cpufreq_dr
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+{
+	return per_cpu(cpufreq_cpu_data, cpu);
+}
+EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
+
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -192,19 +198,12 @@ int cpufreq_generic_init(struct cpufreq_
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
-struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
-
-	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
-}
-EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
-
 unsigned int cpufreq_generic_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
-	if (!policy || IS_ERR(policy->clk)) {
+	if (!policy || !cpumask_test_cpu(cpu, policy->cpus) ||
+	    IS_ERR(policy->clk)) {
 		pr_err("%s: No %s associated to cpu: %d\n",
 		       __func__, policy ? "clk" : "policy", cpu);
 		return 0;
@@ -240,7 +239,7 @@ struct cpufreq_policy *cpufreq_cpu_get(u
 
 	if (cpufreq_driver) {
 		/* get the CPU */
-		policy = cpufreq_cpu_get_raw(cpu);
+		policy = per_cpu(cpufreq_cpu_data, cpu);
 		if (policy)
 			kobject_get(&policy->kobj);
 	}
@@ -1328,13 +1327,19 @@ static int cpufreq_offline(unsigned int
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
 
-	policy = cpufreq_cpu_get_raw(cpu);
+	policy = per_cpu(cpufreq_cpu_data, cpu);
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
 		return 0;
 	}
 
 	down_write(&policy->rwsem);
+
+	if (!cpumask_test_cpu(cpu, policy->cpus)) {
+		pr_debug("%s: CPU %u is offline\n", __func__, cpu);
+		goto unlock;
+	}
+
 	if (has_target())
 		cpufreq_stop_governor(policy);
 
@@ -1455,7 +1460,9 @@ unsigned int cpufreq_quick_get(unsigned
 
 	policy = cpufreq_cpu_get(cpu);
 	if (policy) {
-		ret_freq = policy->cur;
+		if (cpumask_test_cpu(cpu, policy->cpus))
+			ret_freq = policy->cur;
+
 		cpufreq_cpu_put(policy);
 	}
 
@@ -1475,7 +1482,9 @@ unsigned int cpufreq_quick_get_max(unsig
 	unsigned int ret_freq = 0;
 
 	if (policy) {
-		ret_freq = policy->max;
+		if (cpumask_test_cpu(cpu, policy->cpus))
+			ret_freq = policy->max;
+
 		cpufreq_cpu_put(policy);
 	}
 
@@ -1526,7 +1535,10 @@ unsigned int cpufreq_get(unsigned int cp
 
 	if (policy) {
 		down_read(&policy->rwsem);
-		ret_freq = __cpufreq_get(policy);
+
+		if (cpumask_test_cpu(cpu, policy->cpus))
+			ret_freq = __cpufreq_get(policy);
+
 		up_read(&policy->rwsem);
 
 		cpufreq_cpu_put(policy);
@@ -2142,6 +2154,11 @@ int cpufreq_get_policy(struct cpufreq_po
 	if (!cpu_policy)
 		return -EINVAL;
 
+	if (!cpumask_test_cpu(cpu, policy->cpus)) {
+		cpufreq_cpu_put(cpu_policy);
+		return -EINVAL;
+	}
+
 	memcpy(policy, cpu_policy, sizeof(*policy));
 
 	cpufreq_cpu_put(cpu_policy);
@@ -2265,6 +2282,11 @@ int cpufreq_update_policy(unsigned int c
 
 	down_write(&policy->rwsem);
 
+	if (!cpumask_test_cpu(cpu, policy->cpus)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
 	new_policy.min = policy->user_policy.min;

