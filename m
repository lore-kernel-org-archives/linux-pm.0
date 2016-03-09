From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/10] cpufreq: Reduce cpufreq_update_util() overhead a bit
Date: Wed, 09 Mar 2016 22:35:02 +0100
Message-ID: <5173878.LnSyxxsz2i@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <CAJZ5v0gt3tmJ1ZunvkLKfeUSgZv7yiO9vBDtDmXSuC=tUUpPLg@mail.gmail.com> <20160309152934.GO6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49212 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933119AbcCIVdL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 16:33:11 -0500
In-Reply-To: <20160309152934.GO6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wednesday, March 09, 2016 04:29:34 PM Peter Zijlstra wrote:
> On Wed, Mar 09, 2016 at 03:17:48PM +0100, Rafael J. Wysocki wrote:
> > > That said, how about the below? It avoids a function call.
> > 
> > That is fine by me.
> > 
> > What about taking it a bit further, though, and moving the definition
> > of cpufreq_update_util_data to somewhere under kernel/sched/ (like
> > kernel/sched/cpufreq.c maybe)?
> > 
> > Then, the whole static inline void cpufreq_update_util() definition
> > can go into kernel/sched/sched.h (it doesn't have to be visible
> > anywhere beyond kernel/sched/) and the only thing that needs to be
> > exported to cpufreq will be a helper (or two), to set/clear the
> > cpufreq_update_util_data pointers.
> > 
> > I'll try to cut a patch doing that later today for illustration.
> 
> Right, that's a blend with your second patch. Sure.

OK, patch below.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Move scheduler-related code to the sched directory

Create cpufreq.c under kernel/sched/ and move the cpufreq code
related to the scheduler to that file and to sched.h.

Redefine cpufreq_update_util() as a static inline function to avoid
function calls at its call sites in the scheduler code (as suggested
by Peter Zijlstra).

Also move the definition of struct update_util_data and declaration
of cpufreq_set_update_util_data() from include/linux/cpufreq.h to
include/linux/sched.h.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c          |   53 -------------------------------------
 drivers/cpufreq/cpufreq_governor.c |    1 
 include/linux/cpufreq.h            |   34 -----------------------
 include/linux/sched.h              |    9 ++++++
 kernel/sched/Makefile              |    1 
 kernel/sched/cpufreq.c             |   37 +++++++++++++++++++++++++
 kernel/sched/sched.h               |   49 +++++++++++++++++++++++++++++++++-
 7 files changed, 96 insertions(+), 88 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -65,59 +65,6 @@ static struct cpufreq_driver *cpufreq_dr
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
-static DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
-
-/**
- * cpufreq_set_update_util_data - Populate the CPU's update_util_data pointer.
- * @cpu: The CPU to set the pointer for.
- * @data: New pointer value.
- *
- * Set and publish the update_util_data pointer for the given CPU.  That pointer
- * points to a struct update_util_data object containing a callback function
- * to call from cpufreq_update_util().  That function will be called from an RCU
- * read-side critical section, so it must not sleep.
- *
- * Callers must use RCU-sched callbacks to free any memory that might be
- * accessed via the old update_util_data pointer or invoke synchronize_sched()
- * right after this function to avoid use-after-free.
- */
-void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
-{
-	if (WARN_ON(data && !data->func))
-		return;
-
-	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
-}
-EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
-
-/**
- * cpufreq_update_util - Take a note about CPU utilization changes.
- * @time: Current time.
- * @util: Current utilization.
- * @max: Utilization ceiling.
- *
- * This function is called by the scheduler on every invocation of
- * update_load_avg() on the CPU whose utilization is being updated.
- *
- * It can only be called from RCU-sched read-side critical sections.
- */
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
-{
-	struct update_util_data *data;
-
-#ifdef CONFIG_LOCKDEP
-	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
-#endif
-
-	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
-	/*
-	 * If this isn't inside of an RCU-sched read-side critical section, data
-	 * may become NULL after the check below.
-	 */
-	if (data)
-		data->func(data, time, util, max);
-}
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -146,36 +146,6 @@ static inline bool policy_is_shared(stru
 extern struct kobject *cpufreq_global_kobject;
 
 #ifdef CONFIG_CPU_FREQ
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
-
-/**
- * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
- * @time: Current time.
- *
- * The way cpufreq is currently arranged requires it to evaluate the CPU
- * performance state (frequency/voltage) on a regular basis to prevent it from
- * being stuck in a completely inadequate performance level for too long.
- * That is not guaranteed to happen if the updates are only triggered from CFS,
- * though, because they may not be coming in if RT or deadline tasks are active
- * all the time (or there are RT and DL tasks only).
- *
- * As a workaround for that issue, this function is called by the RT and DL
- * sched classes to trigger extra cpufreq updates to prevent it from stalling,
- * but that really is a band-aid.  Going forward it should be replaced with
- * solutions targeted more specifically at RT and DL tasks.
- */
-static inline void cpufreq_trigger_update(u64 time)
-{
-	cpufreq_update_util(time, ULONG_MAX, 0);
-}
-
-struct update_util_data {
-	void (*func)(struct update_util_data *data,
-		     u64 time, unsigned long util, unsigned long max);
-};
-
-void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
-
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
@@ -187,10 +157,6 @@ int cpufreq_update_policy(unsigned int c
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util,
-				       unsigned long max) {}
-static inline void cpufreq_trigger_update(u64 time) {}
-
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
 	return 0;
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- /dev/null
+++ linux-pm/kernel/sched/cpufreq.c
@@ -0,0 +1,37 @@
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
+#include "sched.h"
+
+DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+
+/**
+ * cpufreq_set_update_util_data - Populate the CPU's update_util_data pointer.
+ * @cpu: The CPU to set the pointer for.
+ * @data: New pointer value.
+ *
+ * Set and publish the update_util_data pointer for the given CPU.  That pointer
+ * points to a struct update_util_data object containing a callback function
+ * to call from cpufreq_update_util().  That function will be called from an RCU
+ * read-side critical section, so it must not sleep.
+ *
+ * Callers must use RCU-sched callbacks to free any memory that might be
+ * accessed via the old update_util_data pointer or invoke synchronize_sched()
+ * right after this function to avoid use-after-free.
+ */
+void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
+{
+	if (WARN_ON(data && !data->func))
+		return;
+
+	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
+}
+EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
Index: linux-pm/kernel/sched/sched.h
===================================================================
--- linux-pm.orig/kernel/sched/sched.h
+++ linux-pm/kernel/sched/sched.h
@@ -9,7 +9,6 @@
 #include <linux/irq_work.h>
 #include <linux/tick.h>
 #include <linux/slab.h>
-#include <linux/cpufreq.h>
 
 #include "cpupri.h"
 #include "cpudeadline.h"
@@ -1739,3 +1738,51 @@ static inline u64 irq_time_read(int cpu)
 }
 #endif /* CONFIG_64BIT */
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
+
+#ifdef CONFIG_CPU_FREQ
+DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+
+/**
+ * cpufreq_update_util - Take a note about CPU utilization changes.
+ * @time: Current time.
+ * @util: Current utilization.
+ * @max: Utilization ceiling.
+ *
+ * This function is called by the scheduler on every invocation of
+ * update_load_avg() on the CPU whose utilization is being updated.
+ *
+ * It can only be called from RCU-sched read-side critical sections.
+ */
+static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+{
+       struct update_util_data *data;
+
+       data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+       if (data)
+               data->func(data, time, util, max);
+}
+
+/**
+ * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
+ * @time: Current time.
+ *
+ * The way cpufreq is currently arranged requires it to evaluate the CPU
+ * performance state (frequency/voltage) on a regular basis to prevent it from
+ * being stuck in a completely inadequate performance level for too long.
+ * That is not guaranteed to happen if the updates are only triggered from CFS,
+ * though, because they may not be coming in if RT or deadline tasks are active
+ * all the time (or there are RT and DL tasks only).
+ *
+ * As a workaround for that issue, this function is called by the RT and DL
+ * sched classes to trigger extra cpufreq updates to prevent it from stalling,
+ * but that really is a band-aid.  Going forward it should be replaced with
+ * solutions targeted more specifically at RT and DL tasks.
+ */
+static inline void cpufreq_trigger_update(u64 time)
+{
+	cpufreq_update_util(time, ULONG_MAX, 0);
+}
+#else
+static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max) {}
+static inline void cpufreq_trigger_update(u64 time) {}
+#endif /* CONFIG_CPU_FREQ */
Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -3207,4 +3207,13 @@ static inline unsigned long rlimit_max(u
 	return task_rlimit_max(current, limit);
 }
 
+#ifdef CONFIG_CPU_FREQ
+struct update_util_data {
+	void (*func)(struct update_util_data *data,
+		     u64 time, unsigned long util, unsigned long max);
+};
+
+void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
+#endif /* CONFIG_CPU_FREQ */
+
 #endif
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
Index: linux-pm/kernel/sched/Makefile
===================================================================
--- linux-pm.orig/kernel/sched/Makefile
+++ linux-pm/kernel/sched/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_gr
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
 obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
+obj-$(CONFIG_CPU_FREQ) += cpufreq.o

