From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v2 2/2] cpufreq: schedutil: Switching frequencies from interrupt context
Date: Wed, 24 Feb 2016 02:28:12 +0100
Message-ID: <1597360.X9ARIiUr5r@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <1810564.h98CMnhalE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50511 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751103AbcBXB1l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 20:27:41 -0500
In-Reply-To: <1810564.h98CMnhalE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
immediately as they will be take into account anyway during the next
update from the scheduler.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This actually is the first version of the $subject patch, but since it belongs
to the schedutil governor combo, I've given it the v2.

Please note that this is a prototype, so it may not be done the way I'll want
to do it finally, although ATM I don't quite see how that might be done in
a significantly different way.  Ideas welcome, however.

It works on my test machine and doesn't break powertop even.

Thanks,
Rafael

---
 drivers/cpufreq/acpi-cpufreq.c      |   63 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c           |   35 ++++++++++++++++++++
 drivers/cpufreq/cpufreq_governor.c  |    8 ----
 drivers/cpufreq/cpufreq_schedutil.c |   20 ++++++++---
 include/linux/cpufreq.h             |    4 ++
 5 files changed, 117 insertions(+), 13 deletions(-)

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
+	struct cpufreq_frequency_table *entry;
+	struct acpi_processor_performance *perf;
+	unsigned int uninitialized_var(next_perf_state);
+	unsigned int uninitialized_var(next_freq);
+	unsigned int best_diff;
+
+	if (!data->cpu_freq_fast_write)
+		return CPUFREQ_ENTRY_INVALID;
+
+	for (entry = data->freq_table, best_diff = UINT_MAX;
+	     entry->frequency != CPUFREQ_TABLE_END; entry++) {
+		unsigned int diff, freq = entry->frequency;
+
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		diff = abs(freq - target_freq);
+		if (diff >= best_diff)
+			continue;
+
+		best_diff = diff;
+		next_perf_state = entry->driver_data;
+		next_freq = freq;
+		if (best_diff == 0)
+			goto found;
+	}
+	if (best_diff == UINT_MAX)
+		return CPUFREQ_ENTRY_INVALID;
+
+ found:
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
 
+	if (acpi_pstate_strict || (policy_is_shared(policy) &&
+	    policy->shared_type != CPUFREQ_SHARED_TYPE_ANY))
+		data->cpu_freq_fast_write = NULL;
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
@@ -271,6 +271,8 @@ struct cpufreq_driver {
 				  unsigned int relation);	/* Deprecated */
 	int		(*target_index)(struct cpufreq_policy *policy,
 					unsigned int index);
+	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
+				       unsigned int target_freq);
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -485,6 +487,8 @@ struct cpufreq_governor {
 };
 
 /* Pass a target to the cpufreq driver */
+bool cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+				unsigned int target_freq);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1814,6 +1814,41 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *                              GOVERNORS                            *
  *********************************************************************/
 
+/**
+ * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
+ * @policy: cpufreq policy to switch the frequency for.
+ * @target_freq: New frequency to set (may be approximate).
+ *
+ * Carry out a fast frequency switch from interrupt context.
+ *
+ * It is guaranteed that this function will never be called twice in parallel
+ * for the same policy and that it will not be called in parallel with either
+ * ->target() or ->target_index() for the same policy.
+ *
+ * If CPUFREQ_ENTRY_INVALID is returned by the driver's ->fast_switch()
+ * callback, the hardware configuration must be preserved.
+ *
+ * Return 'true' on success and 'false' on failures.
+ */
+bool cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+				unsigned int target_freq)
+{
+	if (target_freq == policy->cur)
+		return true;
+
+	if (cpufreq_driver->fast_switch) {
+		unsigned int freq;
+
+		freq = cpufreq_driver->fast_switch(policy, target_freq);
+		if (freq != CPUFREQ_ENTRY_INVALID) {
+			policy->cur = freq;
+			trace_cpu_frequency(freq, smp_processor_id());
+			return true;
+		}
+	}
+	return false;
+}
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)
Index: linux-pm/drivers/cpufreq/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_schedutil.c
+++ linux-pm/drivers/cpufreq/cpufreq_schedutil.c
@@ -83,12 +83,22 @@ static unsigned int sugov_next_freq(stru
 static void sugov_update_commit(struct policy_dbs_info *policy_dbs, u64 time,
 				unsigned int next_freq)
 {
-	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
-
-	sg_policy->next_freq = next_freq;
 	policy_dbs->last_sample_time = time;
-	policy_dbs->work_in_progress = true;
-	irq_work_queue(&policy_dbs->irq_work);
+
+	if (cpufreq_driver_fast_switch(policy_dbs->policy, next_freq)) {
+		/*
+		 * Restore the sample delay in case it has been set to 0
+		 * from sysfs in the meantime.
+		 */
+		gov_update_sample_delay(policy_dbs,
+					policy_dbs->dbs_data->sampling_rate);
+	} else {
+		struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
+
+		sg_policy->next_freq = next_freq;
+		policy_dbs->work_in_progress = true;
+		irq_work_queue(&policy_dbs->irq_work);
+	}
 }
 
 static void sugov_update_shared(struct update_util_data *data, u64 time,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -612,16 +612,8 @@ static int cpufreq_governor_limits(struc
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	mutex_lock(&policy_dbs->timer_mutex);
-
-	if (policy->max < policy->cur)
-		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
-	else if (policy->min > policy->cur)
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
-
 	gov_update_sample_delay(policy_dbs, 0);
-
 	mutex_unlock(&policy_dbs->timer_mutex);
-
 	return 0;
 }
 

