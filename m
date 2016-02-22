From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] intel-pstate: Update frequencies of policy->cpus only from ->set_policy()
Date: Mon, 22 Feb 2016 10:27:46 +0530
Message-ID: <c94ae8c4f0c9cf30d916aa29a339b793db30aa3a.1456117057.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35808 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbcBVE6M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 23:58:12 -0500
Received: by mail-pa0-f53.google.com with SMTP id ho8so86849509pac.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2016 20:58:12 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, linux-kernel@vger.kernel.org

The intel-pstate driver is using intel_pstate_hwp_set() from two
separate paths, i.e. ->set_policy() callback and sysfs update path for
the files present in /sys/devices/system/cpu/intel_pstate/ directory.

While an update to the sysfs path applies to all the CPUs being managed
by the driver (which essentially means all the online CPUs), the update
via the ->set_policy() callback applies to a smaller group of CPUs
managed by the policy for which ->set_policy() is called.

And so, intel_pstate_hwp_set() should update frequencies of only the
CPUs that are part of policy->cpus mask, while it is called from
->set_policy() callback.

In order to do that, add a parameter (cpumask) to intel_pstate_hwp_set()
and apply the frequency changes only to the concerned CPUs.

For ->set_policy() path, we are only concerned about policy->cpus, and
so policy->rwsem lock taken by the core prior to calling ->set_policy()
is enough to take care of any races. The larger lock acquired by
get_online_cpus() is required only for the updates to sysfs files.

Add another routine, intel_pstate_hwp_set_online_cpus(), and call it
from the sysfs update paths.

This also fixes a lockdep reported recently, where policy->rwsem and
get_online_cpus() could have been acquired in any order causing an ABBA
deadlock. The sequence of events leading to that was:

intel_pstate_init(...)
	...cpufreq_online(...)
		down_write(&policy->rwsem); // Locks policy->rwsem
		...
		cpufreq_init_policy(policy);
			...intel_pstate_hwp_set();
				get_online_cpus(); // Temporarily locks cpu_hotplug.lock
		...
		up_write(&policy->rwsem);

pm_suspend(...)
	...disable_nonboot_cpus()
		_cpu_down()
			cpu_hotplug_begin(); // Locks cpu_hotplug.lock
			__cpu_notify(CPU_DOWN_PREPARE, ...);
				...cpufreq_offline_prepare();
					down_write(&policy->rwsem); // Locks policy->rwsem

Reported-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f4d85c2ae7b1..2e7058a2479d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -287,7 +287,7 @@ static inline void update_turbo_state(void)
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
 
-static void intel_pstate_hwp_set(void)
+static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
 	u64 value, cap;
@@ -297,9 +297,7 @@ static void intel_pstate_hwp_set(void)
 	hw_max = HWP_HIGHEST_PERF(cap);
 	range = hw_max - hw_min;
 
-	get_online_cpus();
-
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, cpumask) {
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 		adj_range = limits->min_perf_pct * range / 100;
 		min = hw_min + adj_range;
@@ -318,7 +316,12 @@ static void intel_pstate_hwp_set(void)
 		value |= HWP_MAX_PERF(max);
 		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 	}
+}
 
+static void intel_pstate_hwp_set_online_cpus(void)
+{
+	get_online_cpus();
+	intel_pstate_hwp_set(cpu_online_mask);
 	put_online_cpus();
 }
 
@@ -440,7 +443,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	limits->no_turbo = clamp_t(int, input, 0, 1);
 
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set_online_cpus();
 
 	return count;
 }
@@ -466,7 +469,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 				  int_tofp(100));
 
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set_online_cpus();
 	return count;
 }
 
@@ -491,7 +494,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 				  int_tofp(100));
 
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set_online_cpus();
 	return count;
 }
 
@@ -1112,7 +1115,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		pr_debug("intel_pstate: set performance\n");
 		limits = &performance_limits;
 		if (hwp_active)
-			intel_pstate_hwp_set();
+			intel_pstate_hwp_set(policy->cpus);
 		return 0;
 	}
 
@@ -1144,7 +1147,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 				  int_tofp(100));
 
 	if (hwp_active)
-		intel_pstate_hwp_set();
+		intel_pstate_hwp_set(policy->cpus);
 
 	return 0;
 }
-- 
2.7.1.410.g6faf27b

