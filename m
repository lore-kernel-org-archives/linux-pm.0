From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/10] cpufreq: Reduce cpufreq_update_util() overhead a bit
Date: Fri, 04 Mar 2016 03:58:22 +0100
Message-ID: <1988425.XTpZIAJINa@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46026 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755662AbcCDDfD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 22:35:03 -0500
In-Reply-To: <2409306.qzzMXcm4dm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use the observation that cpufreq_update_util() is only called
by the scheduler with rq->lock held, so the callers of
cpufreq_set_update_util_data() can use synchronize_sched()
instead of synchronize_rcu() to wait for cpufreq_update_util()
to complete.  Moreover, if they are updated to do that,
rcu_read_(un)lock() calls in cpufreq_update_util() might be
replaced with rcu_read_(un)lock_sched(), respectively, but
those aren't really necessary, because the scheduler calls
that function from RCU-sched read-side critical sections
already.

In addition to that, if cpufreq_set_update_util_data() checks
the func field in the struct update_util_data before setting
the per-CPU pointer to it, the data->func check may be dropped
from cpufreq_update_util() as well.

Make the above changes to reduce the overhead from
cpufreq_update_util() in the scheduler paths invoking it
and to make the cleanup after removing its callbacks less
heavy-weight somewhat.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Changes from the previous version:
- Use rcu_dereference_sched() in cpufreq_update_util().

---
 drivers/cpufreq/cpufreq.c          |   25 +++++++++++++++++--------
 drivers/cpufreq/cpufreq_governor.c |    2 +-
 drivers/cpufreq/intel_pstate.c     |    4 ++--
 3 files changed, 20 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -77,12 +77,15 @@ static DEFINE_PER_CPU(struct update_util
  * to call from cpufreq_update_util().  That function will be called from an RCU
  * read-side critical section, so it must not sleep.
  *
- * Callers must use RCU callbacks to free any memory that might be accessed
- * via the old update_util_data pointer or invoke synchronize_rcu() right after
- * this function to avoid use-after-free.
+ * Callers must use RCU-sched callbacks to free any memory that might be
+ * accessed via the old update_util_data pointer or invoke synchronize_sched()
+ * right after this function to avoid use-after-free.
  */
 void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
 {
+	if (WARN_ON(data && !data->func))
+		return;
+
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
@@ -95,18 +98,24 @@ EXPORT_SYMBOL_GPL(cpufreq_set_update_uti
  *
  * This function is called by the scheduler on every invocation of
  * update_load_avg() on the CPU whose utilization is being updated.
+ *
+ * It can only be called from RCU-sched read-side critical sections.
  */
 void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
 {
 	struct update_util_data *data;
 
-	rcu_read_lock();
+#ifdef CONFIG_LOCKDEP
+	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
+#endif
 
-	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
-	if (data && data->func)
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	/*
+	 * If this isn't inside of an RCU-sched read-side critical section, data
+	 * may become NULL after the check below.
+	 */
+	if (data)
 		data->func(data, time, util, max);
-
-	rcu_read_unlock();
 }
 
 /* Flag to suspend/resume CPUFreq governors */
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -280,7 +280,7 @@ static inline void gov_clear_update_util
 	for_each_cpu(i, policy->cpus)
 		cpufreq_set_update_util_data(i, NULL);
 
-	synchronize_rcu();
+	synchronize_sched();
 }
 
 static void gov_cancel_work(struct cpufreq_policy *policy)
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1174,7 +1174,7 @@ static void intel_pstate_stop_cpu(struct
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
 	cpufreq_set_update_util_data(cpu_num, NULL);
-	synchronize_rcu();
+	synchronize_sched();
 
 	if (hwp_active)
 		return;
@@ -1442,7 +1442,7 @@ out:
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
 			cpufreq_set_update_util_data(cpu, NULL);
-			synchronize_rcu();
+			synchronize_sched();
 			kfree(all_cpu_data[cpu]);
 		}
 	}

