From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 7/7] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Tue, 08 Mar 2016 03:50:31 +0100
Message-ID: <1855303.8Nyy7L51ju@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4088601.C2vItRYpQn@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new cpufreq scaling governor, called "schedutil", that uses
scheduler-provided CPU utilization information as input for making
its decisions.

Doing that is possible after commit fe7034338ba0 (cpufreq: Add
mechanism for registering utilization update callbacks) that
introduced cpufreq_update_util() called by the scheduler on
utilization changes (from CFS) and RT/DL task status updates.
In particular, CPU frequency scaling decisions may be based on
the the utilization data passed to cpufreq_update_util() by CFS.

The new governor is relatively simple.

The frequency selection formula used by it is

f = 1.1 * max_freq * util / max

where util and max are the utilization and CPU capacity coming from
CFS and max_freq is the nominal maximum frequency of the CPU (as
reported by the cpufreq driver).

All of the computations are carried out in the utilization update
handlers provided by the new governor.  One of those handlers is
used for cpufreq policies shared between multiple CPUs and the other
one is for policies with one CPU only (and therefore it doesn't need
to use any extra synchronization means).

The governor supports fast frequency switching if that is supported
by the cpufreq driver in use and possible for the given policy.
In the fast switching case, all operations of the governor take
place in its utilization update handlers.  If fast switching cannot
be used, the frequency switch operations are carried out with the
help of a work item which only calls __cpufreq_driver_target()
(under a mutex) to trigger a frequency update (to a value already
computed beforehand in one of the utilization update handlers).

Currently, the governor treats all of the RT and DL tasks as
"unknown utilization" and sets the frequency to the allowed
maximum when updated from the RT or DL sched classes.  That
heavy-handed approach should be replaced with something more
subtle and specifically targeted at RT and DL tasks.

The governor shares some tunables management code with the
"ondemand" and "conservative" governors and uses some common
definitions from cpufreq_governor.h, but apart from that it
is stand-alone.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v2:
- The governor goes into drivers/cpufreq/.
- The "next frequency" formula has an additional 1.1 factor to allow
  more util/max values to map onto the top-most frequency in case the
  distance between that and the previous one is unproportionally small.
- sugov_update_commit() traces CPU frequency even if the new one is
  the same as the previous one (otherwise, if the system is 100% loaded
  for long enough, powertop starts to report that all CPUs are 100% idle).

---
 drivers/cpufreq/Kconfig             |   26 +
 drivers/cpufreq/Makefile            |    1 
 drivers/cpufreq/cpufreq_schedutil.c |  509 ++++++++++++++++++++++++++++++++++++
 3 files changed, 536 insertions(+)

Index: linux-pm/drivers/cpufreq/Kconfig
===================================================================
--- linux-pm.orig/drivers/cpufreq/Kconfig
+++ linux-pm/drivers/cpufreq/Kconfig
@@ -107,6 +107,16 @@ config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
 	  Be aware that not all cpufreq drivers support the conservative
 	  governor. If unsure have a look at the help section of the
 	  driver. Fallback governor will be the performance governor.
+
+config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
+	bool "schedutil"
+	select CPU_FREQ_GOV_SCHEDUTIL
+	select CPU_FREQ_GOV_PERFORMANCE
+	help
+	  Use the 'schedutil' CPUFreq governor by default. If unsure,
+	  have a look at the help section of that governor. The fallback
+	  governor will be 'performance'.
+
 endchoice
 
 config CPU_FREQ_GOV_PERFORMANCE
@@ -188,6 +198,22 @@ config CPU_FREQ_GOV_CONSERVATIVE
 
 	  If in doubt, say N.
 
+config CPU_FREQ_GOV_SCHEDUTIL
+	tristate "'schedutil' cpufreq policy governor"
+	depends on CPU_FREQ
+	select CPU_FREQ_GOV_ATTR_SET
+	select IRQ_WORK
+	help
+	  The frequency selection formula used by this governor is analogous
+	  to the one used by 'ondemand', but instead of computing CPU load
+	  as the "non-idle CPU time" to "total CPU time" ratio, it uses CPU
+	  utilization data provided by the scheduler as input.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cpufreq_schedutil.
+
+	  If in doubt, say N.
+
 comment "CPU frequency scaling drivers"
 
 config CPUFREQ_DT
Index: linux-pm/drivers/cpufreq/cpufreq_schedutil.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/cpufreq/cpufreq_schedutil.c
@@ -0,0 +1,509 @@
+/*
+ * CPUFreq governor based on scheduler-provided CPU utilization data.
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <trace/events/power.h>
+
+#include "cpufreq_governor.h"
+
+struct sugov_tunables {
+	struct gov_attr_set attr_set;
+	unsigned int rate_limit_us;
+};
+
+struct sugov_policy {
+	struct cpufreq_policy *policy;
+
+	struct sugov_tunables *tunables;
+	struct list_head tunables_hook;
+
+	raw_spinlock_t update_lock;  /* For shared policies */
+	u64 last_freq_update_time;
+	s64 freq_update_delay_ns;
+	unsigned int next_freq;
+	unsigned int driver_freq;
+	unsigned int max_freq;
+
+	/* The next fields are only needed if fast switch cannot be used. */
+	struct irq_work irq_work;
+	struct work_struct work;
+	struct mutex work_lock;
+	bool work_in_progress;
+
+	bool need_freq_update;
+};
+
+struct sugov_cpu {
+	struct freq_update_hook update_hook;
+	struct sugov_policy *sg_policy;
+
+	/* The fields below are only needed when sharing a policy. */
+	unsigned long util;
+	unsigned long max;
+	u64 last_update;
+};
+
+static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
+
+/************************ Governor internals ***********************/
+
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+{
+	u64 delta_ns;
+
+	if (sg_policy->work_in_progress)
+		return false;
+
+	if (unlikely(sg_policy->need_freq_update)) {
+		sg_policy->need_freq_update = false;
+		return true;
+	}
+
+	delta_ns = time - sg_policy->last_freq_update_time;
+	return (s64)delta_ns >= sg_policy->freq_update_delay_ns;
+}
+
+static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
+				unsigned int next_freq)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+	unsigned int freq;
+
+	if (next_freq > policy->max)
+		next_freq = policy->max;
+	else if (next_freq < policy->min)
+		next_freq = policy->min;
+
+	sg_policy->last_freq_update_time = time;
+	if (sg_policy->next_freq == next_freq) {
+		if (!policy->fast_switch_possible)
+			return;
+
+		freq = sg_policy->driver_freq;
+	} else {
+		sg_policy->next_freq = next_freq;
+		if (!policy->fast_switch_possible) {
+			sg_policy->work_in_progress = true;
+			irq_work_queue(&sg_policy->irq_work);
+			return;
+		}
+		freq = cpufreq_driver_fast_switch(policy, next_freq);
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			return;
+
+		sg_policy->driver_freq = freq;
+	}
+	policy->cur = freq;
+	trace_cpu_frequency(freq, smp_processor_id());
+}
+
+static void sugov_update_single(struct freq_update_hook *hook, u64 time,
+				unsigned long util, unsigned long max)
+{
+	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_hook);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	unsigned int max_f, next_f;
+
+	if (!sugov_should_update_freq(sg_policy, time))
+		return;
+
+	max_f = sg_policy->max_freq;
+	next_f = util > max ? max_f : util * max_f / max;
+	sugov_update_commit(sg_policy, time, next_f);
+}
+
+static unsigned int sugov_next_freq(struct sugov_policy *sg_policy,
+				    unsigned long util, unsigned long max)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+	unsigned int max_f = sg_policy->max_freq;
+	u64 last_freq_update_time = sg_policy->last_freq_update_time;
+	unsigned int j;
+
+	if (util > max)
+		return max_f;
+
+	for_each_cpu(j, policy->cpus) {
+		struct sugov_cpu *j_sg_cpu;
+		unsigned long j_util, j_max;
+		u64 delta_ns;
+
+		if (j == smp_processor_id())
+			continue;
+
+		j_sg_cpu = &per_cpu(sugov_cpu, j);
+		/*
+		 * If the CPU utilization was last updated before the previous
+		 * frequency update and the time elapsed between the last update
+		 * of the CPU utilization and the last frequency update is long
+		 * enough, don't take the CPU into account as it probably is
+		 * idle now.
+		 */
+		delta_ns = last_freq_update_time - j_sg_cpu->last_update;
+		if ((s64)delta_ns > NSEC_PER_SEC / HZ)
+			continue;
+
+		j_util = j_sg_cpu->util;
+		j_max = j_sg_cpu->max;
+		if (j_util > j_max)
+			return max_f;
+
+		if (j_util * max > j_max * util) {
+			util = j_util;
+			max = j_max;
+		}
+	}
+
+	return  util * max_f / max;
+}
+
+static void sugov_update_shared(struct freq_update_hook *hook, u64 time,
+				unsigned long util, unsigned long max)
+{
+	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_hook);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	unsigned int next_f;
+
+	raw_spin_lock(&sg_policy->update_lock);
+
+	sg_cpu->util = util;
+	sg_cpu->max = max;
+	sg_cpu->last_update = time;
+
+	if (sugov_should_update_freq(sg_policy, time)) {
+		next_f = sugov_next_freq(sg_policy, util, max);
+		sugov_update_commit(sg_policy, time, next_f);
+	}
+
+	raw_spin_unlock(&sg_policy->update_lock);
+}
+
+static void sugov_work(struct work_struct *work)
+{
+	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
+
+	mutex_lock(&sg_policy->work_lock);
+	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
+				CPUFREQ_RELATION_L);
+	mutex_unlock(&sg_policy->work_lock);
+
+	sg_policy->work_in_progress = false;
+}
+
+static void sugov_irq_work(struct irq_work *irq_work)
+{
+	struct sugov_policy *sg_policy;
+
+	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
+	schedule_work(&sg_policy->work);
+}
+
+/************************** sysfs interface ************************/
+
+static struct sugov_tunables *global_tunables;
+static DEFINE_MUTEX(global_tunables_lock);
+
+static inline struct sugov_tunables *to_sugov_tunables(struct gov_attr_set *attr_set)
+{
+	return container_of(attr_set, struct sugov_tunables, attr_set);
+}
+
+static ssize_t rate_limit_us_show(struct gov_attr_set *attr_set, char *buf)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+
+	return sprintf(buf, "%u\n", tunables->rate_limit_us);
+}
+
+static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf,
+				   size_t count)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+	struct sugov_policy *sg_policy;
+	unsigned int rate_limit_us;
+	int ret;
+
+	ret = sscanf(buf, "%u", &rate_limit_us);
+	if (ret != 1)
+		return -EINVAL;
+
+	tunables->rate_limit_us = rate_limit_us;
+
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
+		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
+
+	return count;
+}
+
+static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
+
+static struct attribute *sugov_attributes[] = {
+	&rate_limit_us.attr,
+	NULL
+};
+
+static struct kobj_type sugov_tunables_ktype = {
+	.default_attrs = sugov_attributes,
+	.sysfs_ops = &governor_sysfs_ops,
+};
+
+/********************** cpufreq governor interface *********************/
+
+static struct cpufreq_governor schedutil_gov;
+
+static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
+{
+	unsigned int max_f = policy->cpuinfo.max_freq;
+	struct sugov_policy *sg_policy;
+
+	sg_policy = kzalloc(sizeof(*sg_policy), GFP_KERNEL);
+	if (!sg_policy)
+		return NULL;
+
+	sg_policy->policy = policy;
+	/*
+	 * Take the proportionality coefficient between util/max and frequency
+	 * to be 1.1 times the nominal maximum frequency to boost performance
+	 * slightly on systems with a narrow top-most frequency bin.
+	 */
+	sg_policy->max_freq = max_f + max_f / 10;
+	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	INIT_WORK(&sg_policy->work, sugov_work);
+	mutex_init(&sg_policy->work_lock);
+	raw_spin_lock_init(&sg_policy->update_lock);
+	return sg_policy;
+}
+
+static void sugov_policy_free(struct sugov_policy *sg_policy)
+{
+	mutex_destroy(&sg_policy->work_lock);
+	kfree(sg_policy);
+}
+
+static struct sugov_tunables *sugov_tunables_alloc(struct sugov_policy *sg_policy)
+{
+	struct sugov_tunables *tunables;
+
+	tunables = kzalloc(sizeof(*tunables), GFP_KERNEL);
+	if (tunables)
+		gov_attr_set_init(&tunables->attr_set, &sg_policy->tunables_hook);
+
+	return tunables;
+}
+
+static void sugov_tunables_free(struct sugov_tunables *tunables)
+{
+	if (!have_governor_per_policy())
+		global_tunables = NULL;
+
+	kfree(tunables);
+}
+
+static int sugov_init(struct cpufreq_policy *policy)
+{
+	struct sugov_policy *sg_policy;
+	struct sugov_tunables *tunables;
+	unsigned int lat;
+	int ret = 0;
+
+	/* State should be equivalent to EXIT */
+	if (policy->governor_data)
+		return -EBUSY;
+
+	sg_policy = sugov_policy_alloc(policy);
+	if (!sg_policy)
+		return -ENOMEM;
+
+	mutex_lock(&global_tunables_lock);
+
+	if (global_tunables) {
+		if (WARN_ON(have_governor_per_policy())) {
+			ret = -EINVAL;
+			goto free_sg_policy;
+		}
+		policy->governor_data = sg_policy;
+		sg_policy->tunables = global_tunables;
+
+		gov_attr_set_get(&global_tunables->attr_set, &sg_policy->tunables_hook);
+		goto out;
+	}
+
+	tunables = sugov_tunables_alloc(sg_policy);
+	if (!tunables) {
+		ret = -ENOMEM;
+		goto free_sg_policy;
+	}
+
+	tunables->rate_limit_us = LATENCY_MULTIPLIER;
+	lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
+	if (lat)
+		tunables->rate_limit_us *= lat;
+
+	if (!have_governor_per_policy())
+		global_tunables = tunables;
+
+	policy->governor_data = sg_policy;
+	sg_policy->tunables = tunables;
+
+	ret = kobject_init_and_add(&tunables->attr_set.kobj, &sugov_tunables_ktype,
+				   get_governor_parent_kobj(policy), "%s",
+				   schedutil_gov.name);
+	if (!ret)
+		goto out;
+
+	/* Failure, so roll back. */
+	policy->governor_data = NULL;
+	sugov_tunables_free(tunables);
+
+ free_sg_policy:
+	pr_err("cpufreq: schedutil governor initialization failed (error %d)\n", ret);
+	sugov_policy_free(sg_policy);
+
+ out:
+	mutex_unlock(&global_tunables_lock);
+	return ret;
+}
+
+static int sugov_exit(struct cpufreq_policy *policy)
+{
+	struct sugov_policy *sg_policy = policy->governor_data;
+	struct sugov_tunables *tunables = sg_policy->tunables;
+	unsigned int count;
+
+	mutex_lock(&global_tunables_lock);
+
+	count = gov_attr_set_put(&tunables->attr_set, &sg_policy->tunables_hook);
+	policy->governor_data = NULL;
+	if (!count)
+		sugov_tunables_free(tunables);
+
+	mutex_unlock(&global_tunables_lock);
+
+	sugov_policy_free(sg_policy);
+	return 0;
+}
+
+static int sugov_start(struct cpufreq_policy *policy)
+{
+	struct sugov_policy *sg_policy = policy->governor_data;
+	unsigned int cpu;
+
+	sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sg_policy->last_freq_update_time = 0;
+	sg_policy->next_freq = UINT_MAX;
+	sg_policy->work_in_progress = false;
+	sg_policy->need_freq_update = false;
+
+	for_each_cpu(cpu, policy->cpus) {
+		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
+
+		sg_cpu->sg_policy = sg_policy;
+		if (policy_is_shared(policy)) {
+			sg_cpu->util = ULONG_MAX;
+			sg_cpu->max = 0;
+			sg_cpu->last_update = 0;
+			cpufreq_set_freq_update_hook(cpu, &sg_cpu->update_hook,
+						     sugov_update_shared);
+		} else {
+			cpufreq_set_freq_update_hook(cpu, &sg_cpu->update_hook,
+						     sugov_update_single);
+		}
+	}
+	return 0;
+}
+
+static int sugov_stop(struct cpufreq_policy *policy)
+{
+	struct sugov_policy *sg_policy = policy->governor_data;
+	unsigned int cpu;
+
+	for_each_cpu(cpu, policy->cpus)
+		cpufreq_clear_freq_update_hook(cpu);
+
+	synchronize_sched();
+
+	irq_work_sync(&sg_policy->irq_work);
+	cancel_work_sync(&sg_policy->work);
+	return 0;
+}
+
+static int sugov_limits(struct cpufreq_policy *policy)
+{
+	struct sugov_policy *sg_policy = policy->governor_data;
+
+	if (!policy->fast_switch_possible) {
+		mutex_lock(&sg_policy->work_lock);
+
+		if (policy->max < policy->cur)
+			__cpufreq_driver_target(policy, policy->max,
+						CPUFREQ_RELATION_H);
+		else if (policy->min > policy->cur)
+			__cpufreq_driver_target(policy, policy->min,
+						CPUFREQ_RELATION_L);
+
+		mutex_unlock(&sg_policy->work_lock);
+	}
+
+	sg_policy->need_freq_update = true;
+	return 0;
+}
+
+int sugov_governor(struct cpufreq_policy *policy, unsigned int event)
+{
+	if (event == CPUFREQ_GOV_POLICY_INIT) {
+		return sugov_init(policy);
+	} else if (policy->governor_data) {
+		switch (event) {
+		case CPUFREQ_GOV_POLICY_EXIT:
+			return sugov_exit(policy);
+		case CPUFREQ_GOV_START:
+			return sugov_start(policy);
+		case CPUFREQ_GOV_STOP:
+			return sugov_stop(policy);
+		case CPUFREQ_GOV_LIMITS:
+			return sugov_limits(policy);
+		}
+	}
+	return -EINVAL;
+}
+
+static struct cpufreq_governor schedutil_gov = {
+	.name = "schedutil",
+	.governor = sugov_governor,
+	.owner = THIS_MODULE,
+};
+
+static int __init sugov_module_init(void)
+{
+	return cpufreq_register_governor(&schedutil_gov);
+}
+
+static void __exit sugov_module_exit(void)
+{
+	cpufreq_unregister_governor(&schedutil_gov);
+}
+
+MODULE_AUTHOR("Rafael J. Wysocki <rafael.j.wysocki@intel.com>");
+MODULE_DESCRIPTION("Utilization-based CPU frequency selection");
+MODULE_LICENSE("GPL");
+
+#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return &schedutil_gov;
+}
+
+fs_initcall(sugov_module_init);
+#else
+module_init(sugov_module_init);
+#endif
+module_exit(sugov_module_exit);
Index: linux-pm/drivers/cpufreq/Makefile
===================================================================
--- linux-pm.orig/drivers/cpufreq/Makefile
+++ linux-pm/drivers/cpufreq/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= c
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
+obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)	+= cpufreq_schedutil.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 
