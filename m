From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v4 2/2] cpufreq: schedutil: Switching frequencies from interrupt context
Date: Thu, 25 Feb 2016 22:20:17 +0100
Message-ID: <5725513.D8MRamvf82@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <1810564.h98CMnhalE@vostro.rjw.lan> <1597360.X9ARIiUr5r@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48103 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750767AbcBYVSn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 16:18:43 -0500
In-Reply-To: <1597360.X9ARIiUr5r@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: schedutil: Switching frequencies from interrupt context

Modify the ACPI cpufreq driver to provide a method for switching
CPU frequencies from interrupt context and update the cpufreq core
and the schedutil governor to use that method if available.

Introduce a new cpufreq driver callback, ->fast_switch, to be
invoked for frequency switching from interrupt context via
new helper function cpufreq_driver_fast_switch().

Modify the schedutil governor to call cpufreq_driver_fast_switch()
from its sugov_update_commit() function and avoid queuing up the
irq_work if that is successful.

Implement the ->fast_switch callback in the ACPI cpufreq driver
(with a limited coverage for the time being).

In addition to the above, cpufreq_governor_limits() is modified so
it doesn't call __cpufreq_driver_target() to enforce the new limits
immediately if the fast_switch_enabled flag is set for the policy,
because in that case the frequency will be updated immediately
using the new limits anyway and the additional invocation of
__cpufreq_driver_target() might be racing with that violating
the cpufreq_driver_fast_switch() requirements.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v3:
- Rebase on the v4 of patch [1/2].
- Change the table lookup algo in acpi_cpufreq_fast_switch() to take the table
  ordering into account and to prefer higher frequencies (if the target falls
  between two of them).

Changes from v2:
- Rework due to the revised handling of policy->min and policy->max changes.

v2 was the first version of this patch.

---
 drivers/cpufreq/acpi-cpufreq.c      |   63 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c           |   31 +++++++++++++++++
 drivers/cpufreq/cpufreq_governor.c  |   13 ++++---
 drivers/cpufreq/cpufreq_governor.h  |    1 
 drivers/cpufreq/cpufreq_schedutil.c |   16 ++++++++-
 include/linux/cpufreq.h             |    5 ++
 6 files changed, 122 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -70,6 +70,7 @@ struct acpi_cpufreq_data {
 	unsigned int cpu_feature;
 	unsigned int acpi_perf_cpu;
 	cpumask_var_t freqdomain_cpus;
+	void (*cpu_freq_fast_write)(u32 val);
 };
 
 /* acpi_perf_data is a pointer to percpu data. */
@@ -243,6 +244,15 @@ static unsigned extract_freq(u32 val, st
 	}
 }
 
+void cpu_freq_fast_write_intel(u32 val)
+{
+	u32 lo, hi;
+
+	rdmsr(MSR_IA32_PERF_CTL, lo, hi);
+	lo = (lo & ~INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);
+	wrmsr(MSR_IA32_PERF_CTL, lo, hi);
+}
+
 struct msr_addr {
 	u32 reg;
 };
@@ -484,6 +494,53 @@ out:
 	return result;
 }
 
+unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+				      unsigned int target_freq)
+{
+	struct acpi_cpufreq_data *data = policy->driver_data;
+	struct acpi_processor_performance *perf;
+	struct cpufreq_frequency_table *entry, *next;
+	unsigned int next_perf_state, next_freq, freq;
+
+	/*
+	 * Find the closest frequency above target_freq or equal to it.
+	 *
+	 * The table is sorted in the reverse order with respect to the
+	 * frequency and all of the entires are valid (see the initialization).
+	 */
+	entry = data->freq_table;
+	do {
+		next = entry;
+		entry++;
+		freq = entry->frequency;
+	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
+
+	next_freq = next->frequency;
+	/*
+	 * The frequency below the target may be more suitable, so check and
+	 * choose it if that's the case.
+	 */
+	if (next_freq != target_freq && freq != CPUFREQ_TABLE_END &&
+	    (freq + ((next_freq - freq) >> 2) > target_freq)) {
+		next_freq = freq;
+		next_perf_state = entry->driver_data;
+	} else {
+		next_perf_state = next->driver_data;
+	}
+
+	perf = to_perf_data(data);
+	if (perf->state == next_perf_state) {
+		if (unlikely(data->resume))
+			data->resume = 0;
+		else
+			return next_freq;
+	}
+
+	data->cpu_freq_fast_write(perf->states[next_perf_state].control);
+	perf->state = next_perf_state;
+	return next_freq;
+}
+
 static unsigned long
 acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int cpu)
 {
@@ -745,6 +802,7 @@ static int acpi_cpufreq_cpu_init(struct
 		pr_debug("HARDWARE addr space\n");
 		if (check_est_cpu(cpu)) {
 			data->cpu_feature = SYSTEM_INTEL_MSR_CAPABLE;
+			data->cpu_freq_fast_write = cpu_freq_fast_write_intel;
 			break;
 		}
 		if (check_amd_hwpstate_cpu(cpu)) {
@@ -760,6 +818,10 @@ static int acpi_cpufreq_cpu_init(struct
 		goto err_unreg;
 	}
 
+	policy->fast_switch_possible = data->cpu_freq_fast_write != NULL &&
+		!acpi_pstate_strict && !(policy_is_shared(policy) &&
+			policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
+
 	data->freq_table = kzalloc(sizeof(*data->freq_table) *
 		    (perf->state_count+1), GFP_KERNEL);
 	if (!data->freq_table) {
@@ -894,6 +956,7 @@ static struct freq_attr *acpi_cpufreq_at
 static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= acpi_cpufreq_target,
+	.fast_switch	= acpi_cpufreq_fast_switch,
 	.bios_limit	= acpi_processor_get_bios_limit,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -82,6 +82,7 @@ struct cpufreq_policy {
 	void			*governor_data;
 	bool			governor_enabled; /* governor start/stop flag */
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
+	bool			fast_switch_possible;
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
@@ -271,6 +272,8 @@ struct cpufreq_driver {
 				  unsigned int relation);	/* Deprecated */
 	int		(*target_index)(struct cpufreq_policy *policy,
 					unsigned int index);
+	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
+				       unsigned int target_freq);
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -485,6 +488,8 @@ struct cpufreq_governor {
 };
 
 /* Pass a target to the cpufreq driver */
+void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+				unsigned int target_freq);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1814,6 +1814,37 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *                              GOVERNORS                            *
  *********************************************************************/
 
+/**
+ * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
+ * @policy: cpufreq policy to switch the frequency for.
+ * @target_freq: New frequency to set (may be approximate).
+ *
+ * Carry out a fast frequency switch from interrupt context.
+ *
+ * This function must not be called if policy->fast_switch_possible is unset.
+ *
+ * Governors calling this function must guarantee that it will never be invoked
+ * twice in parallel for the same policy and that it will never be called in
+ * parallel with either ->target() or ->target_index() for the same policy.
+ *
+ * If CPUFREQ_ENTRY_INVALID is returned by the driver's ->fast_switch()
+ * callback, the hardware configuration must be preserved.
+ */
+void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+				unsigned int target_freq)
+{
+	unsigned int freq;
+
+	if (target_freq == policy->cur)
+		return;
+
+	freq = cpufreq_driver->fast_switch(policy, target_freq);
+	if (freq != CPUFREQ_ENTRY_INVALID) {
+		policy->cur = freq;
+		trace_cpu_frequency(freq, smp_processor_id());
+	}
+}
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -613,15 +613,18 @@ static int cpufreq_governor_limits(struc
 
 	mutex_lock(&policy_dbs->timer_mutex);
 
-	if (policy->max < policy->cur)
-		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
-	else if (policy->min > policy->cur)
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+	if (!policy_dbs->fast_switch_enabled) {
+		if (policy->max < policy->cur)
+			__cpufreq_driver_target(policy, policy->max,
+						CPUFREQ_RELATION_H);
+		else if (policy->min > policy->cur)
+			__cpufreq_driver_target(policy, policy->min,
+						CPUFREQ_RELATION_L);
+	}
 
 	gov_update_sample_delay(policy_dbs, 0);
 
 	mutex_unlock(&policy_dbs->timer_mutex);
-
 	return 0;
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_schedutil.c
+++ linux-pm/drivers/cpufreq/cpufreq_schedutil.c
@@ -86,8 +86,19 @@ static void sugov_update_commit(struct p
 	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
 
 	policy_dbs->last_sample_time = time;
-	if (sg_policy->next_freq != next_freq) {
-		sg_policy->next_freq = next_freq;
+	if (sg_policy->next_freq == next_freq)
+		return;
+
+	sg_policy->next_freq = next_freq;
+	if (policy_dbs->fast_switch_enabled) {
+		cpufreq_driver_fast_switch(policy_dbs->policy, next_freq);
+		/*
+		 * Restore the sample delay in case it has been set to 0 from
+		 * sysfs in the meantime.
+		 */
+		gov_update_sample_delay(policy_dbs,
+					policy_dbs->dbs_data->sampling_rate);
+	} else {
 		policy_dbs->work_in_progress = true;
 		irq_work_queue(&policy_dbs->irq_work);
 	}
@@ -191,6 +202,7 @@ static bool sugov_start(struct cpufreq_p
 
 	gov_update_sample_delay(policy_dbs, policy_dbs->dbs_data->sampling_rate);
 	policy_dbs->last_sample_time = 0;
+	policy_dbs->fast_switch_enabled = policy->fast_switch_possible;
 	sg_policy->next_freq = UINT_MAX;
 
 	for_each_cpu(cpu, policy->cpus) {
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -124,6 +124,7 @@ struct policy_dbs_info {
 	/* Status indicators */
 	bool is_shared;		/* This object is used by multiple CPUs */
 	bool work_in_progress;	/* Work is being queued up or in progress */
+	bool fast_switch_enabled;	/* Switch frequencies from interrup context */
 };
 
 static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,

