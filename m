From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 2/7][Resend] cpufreq: Move scheduler-related code to the sched directory
Date: Tue, 08 Mar 2016 03:26:16 +0100
Message-ID: <1558261.iWFRT0Bv7l@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48857 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753715AbcCHCxA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 21:53:00 -0500
In-Reply-To: <4088601.C2vItRYpQn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Create cpufreq.c under kernel/sched/ and move the cpufreq code
related to the scheduler to that file.  Also move the headers
related to that code from cpufreq.h to sched.h.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from v2.

---
 drivers/cpufreq/cpufreq.c          |   61 ------------------------------
 drivers/cpufreq/cpufreq_governor.c |    1 
 drivers/cpufreq/intel_pstate.c     |    1 
 include/linux/cpufreq.h            |   10 -----
 include/linux/sched.h              |   12 ++++++
 kernel/sched/Makefile              |    1 
 kernel/sched/cpufreq.c             |   73 +++++++++++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 71 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -65,67 +65,6 @@ static struct cpufreq_driver *cpufreq_dr
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
-static DEFINE_PER_CPU(struct freq_update_hook *, cpufreq_freq_update_hook);
-
-/**
- * cpufreq_set_freq_update_hook - Populate the CPU's freq_update_hook pointer.
- * @cpu: The CPU to set the pointer for.
- * @hook: New pointer value.
- *
- * Set and publish the freq_update_hook pointer for the given CPU.  That pointer
- * points to a struct freq_update_hook object containing a callback function
- * to call from cpufreq_trigger_update().  That function will be called from
- * an RCU read-side critical section, so it must not sleep.
- *
- * Callers must use RCU-sched callbacks to free any memory that might be
- * accessed via the old update_util_data pointer or invoke synchronize_sched()
- * right after this function to avoid use-after-free.
- */
-void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook)
-{
-	if (WARN_ON(hook && !hook->func))
-		return;
-
-	rcu_assign_pointer(per_cpu(cpufreq_freq_update_hook, cpu), hook);
-}
-EXPORT_SYMBOL_GPL(cpufreq_set_freq_update_hook);
-
-/**
- * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
- * @time: Current time.
- *
- * The way cpufreq is currently arranged requires it to evaluate the CPU
- * performance state (frequency/voltage) on a regular basis.  To facilitate
- * that, this function is called by update_load_avg() in CFS when executed for
- * the current CPU's runqueue.
- *
- * However, this isn't sufficient to prevent the CPU from being stuck in a
- * completely inadequate performance level for too long, because the calls
- * from CFS will not be made if RT or deadline tasks are active all the time
- * (or there are RT and DL tasks only).
- *
- * As a workaround for that issue, this function is called by the RT and DL
- * sched classes to trigger extra cpufreq updates to prevent it from stalling,
- * but that really is a band-aid.  Going forward it should be replaced with
- * solutions targeted more specifically at RT and DL tasks.
- */
-void cpufreq_trigger_update(u64 time)
-{
-	struct freq_update_hook *hook;
-
-#ifdef CONFIG_LOCKDEP
-	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
-#endif
-
-	hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
-	/*
-	 * If this isn't inside of an RCU-sched read-side critical section, data
-	 * may become NULL after the check below.
-	 */
-	if (hook)
-		hook->func(hook, time);
-}
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -18,6 +18,7 @@
 
 #include <linux/export.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 
 #include "cpufreq_governor.h"
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/sched.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/fs.h>
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -146,14 +146,6 @@ static inline bool policy_is_shared(stru
 extern struct kobject *cpufreq_global_kobject;
 
 #ifdef CONFIG_CPU_FREQ
-void cpufreq_trigger_update(u64 time);
-
-struct freq_update_hook {
-	void (*func)(struct freq_update_hook *hook, u64 time);
-};
-
-void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook);
-
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
@@ -165,8 +157,6 @@ int cpufreq_update_policy(unsigned int c
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 #else
-static inline void cpufreq_trigger_update(u64 time) {}
-
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
 	return 0;
Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -2362,6 +2362,18 @@ extern u64 scheduler_tick_max_deferment(
 static inline bool sched_can_stop_tick(void) { return false; }
 #endif
 
+#ifdef CONFIG_CPU_FREQ
+void cpufreq_trigger_update(u64 time);
+
+struct freq_update_hook {
+	void (*func)(struct freq_update_hook *hook, u64 time);
+};
+
+void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook);
+#else
+static inline void cpufreq_trigger_update(u64 time) {}
+#endif
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 extern void sched_autogroup_create_attach(struct task_struct *p);
 extern void sched_autogroup_detach(struct task_struct *p);
Index: linux-pm/kernel/sched/Makefile
===================================================================
--- linux-pm.orig/kernel/sched/Makefile
+++ linux-pm/kernel/sched/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_gr
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
 obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
+obj-$(CONFIG_CPU_FREQ) += cpufreq.o
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- /dev/null
+++ linux-pm/kernel/sched/cpufreq.c
@@ -0,0 +1,73 @@
+/*
+ * Scheduler code and data structures related to cpufreq.
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/sched.h>
+
+static DEFINE_PER_CPU(struct freq_update_hook *, cpufreq_freq_update_hook);
+
+/**
+ * cpufreq_set_freq_update_hook - Populate the CPU's freq_update_hook pointer.
+ * @cpu: The CPU to set the pointer for.
+ * @hook: New pointer value.
+ *
+ * Set and publish the freq_update_hook pointer for the given CPU.  That pointer
+ * points to a struct freq_update_hook object containing a callback function
+ * to call from cpufreq_trigger_update().  That function will be called from
+ * an RCU read-side critical section, so it must not sleep.
+ *
+ * Callers must use RCU-sched callbacks to free any memory that might be
+ * accessed via the old update_util_data pointer or invoke synchronize_sched()
+ * right after this function to avoid use-after-free.
+ */
+void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook)
+{
+	if (WARN_ON(hook && !hook->func))
+		return;
+
+	rcu_assign_pointer(per_cpu(cpufreq_freq_update_hook, cpu), hook);
+}
+EXPORT_SYMBOL_GPL(cpufreq_set_freq_update_hook);
+
+/**
+ * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
+ * @time: Current time.
+ *
+ * The way cpufreq is currently arranged requires it to evaluate the CPU
+ * performance state (frequency/voltage) on a regular basis.  To facilitate
+ * that, this function is called by update_load_avg() in CFS when executed for
+ * the current CPU's runqueue.
+ *
+ * However, this isn't sufficient to prevent the CPU from being stuck in a
+ * completely inadequate performance level for too long, because the calls
+ * from CFS will not be made if RT or deadline tasks are active all the time
+ * (or there are RT and DL tasks only).
+ *
+ * As a workaround for that issue, this function is called by the RT and DL
+ * sched classes to trigger extra cpufreq updates to prevent it from stalling,
+ * but that really is a band-aid.  Going forward it should be replaced with
+ * solutions targeted more specifically at RT and DL tasks.
+ */
+void cpufreq_trigger_update(u64 time)
+{
+	struct freq_update_hook *hook;
+
+#ifdef CONFIG_LOCKDEP
+	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
+#endif
+
+	hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
+	/*
+	 * If this isn't inside of an RCU-sched read-side critical section, hook
+	 * may become NULL after the check below.
+	 */
+	if (hook)
+		hook->func(hook, time);
+}

