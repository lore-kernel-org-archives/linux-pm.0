From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Fri, 04 Mar 2016 04:07:04 +0100
Message-ID: <15684081.T4iOMUSHCY@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2409306.qzzMXcm4dm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the ACPI cpufreq driver to provide a method for switching
CPU frequencies from interrupt context and update the cpufreq core
to support that method if available.

Introduce a new cpufreq driver callback, ->fast_switch, to be
invoked for frequency switching from interrupt context via a
new helper function, cpufreq_driver_fast_switch().  Add a new
policy flag, fast_switch_possible, to be set if fast frequency
switching can be used for the given policy.

Implement the ->fast_switch callback in the ACPI cpufreq driver
and make it set fast_switch_possible during policy initialization
as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from the previous version:
- Drop a bogus check from cpufreq_driver_fast_switch().

---
 drivers/cpufreq/acpi-cpufreq.c |   53 +++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c      |   30 +++++++++++++++++++++++
 include/linux/cpufreq.h        |    6 ++++
 3 files changed, 89 insertions(+)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -458,6 +458,55 @@ static int acpi_cpufreq_target(struct cp
 	return result;
 }
 
+unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+				      unsigned int target_freq,
+				      unsigned int relation)
+{
+	struct acpi_cpufreq_data *data = policy->driver_data;
+	struct acpi_processor_performance *perf;
+	struct cpufreq_frequency_table *entry, *found;
+	unsigned int next_perf_state, next_freq, freq;
+
+	/*
+	 * Find the closest frequency above target_freq or equal to it.
+	 *
+	 * The table is sorted in the reverse order with respect to the
+	 * frequency and all of the entries are valid (see the initialization).
+	 */
+	entry = data->freq_table;
+	do {
+		entry++;
+		freq = entry->frequency;
+	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
+	found = entry - 1;
+	/*
+	 * Use the one found or the previous one, depending on the relation.
+	 * CPUFREQ_RELATION_H is not taken into account here, but it is not
+	 * expected to be passed to this function anyway.
+	 */
+	next_freq = found->frequency;
+	if (freq == CPUFREQ_TABLE_END || relation != CPUFREQ_RELATION_C ||
+	    target_freq - freq >= next_freq - target_freq) {
+		next_perf_state = found->driver_data;
+	} else {
+		next_freq = freq;
+		next_perf_state = entry->driver_data;
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
+	data->cpu_freq_write(&perf->control_register,
+			     perf->states[next_perf_state].control);
+	perf->state = next_perf_state;
+	return next_freq;
+}
+
 static unsigned long
 acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int cpu)
 {
@@ -740,6 +789,9 @@ static int acpi_cpufreq_cpu_init(struct
 		goto err_unreg;
 	}
 
+	policy->fast_switch_possible = !acpi_pstate_strict &&
+		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
+
 	data->freq_table = kzalloc(sizeof(*data->freq_table) *
 		    (perf->state_count+1), GFP_KERNEL);
 	if (!data->freq_table) {
@@ -874,6 +926,7 @@ static struct freq_attr *acpi_cpufreq_at
 static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= acpi_cpufreq_target,
+	.fast_switch	= acpi_cpufreq_fast_switch,
 	.bios_limit	= acpi_processor_get_bios_limit,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1719,6 +1719,36 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *                              GOVERNORS                            *
  *********************************************************************/
 
+/**
+ * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
+ * @policy: cpufreq policy to switch the frequency for.
+ * @target_freq: New frequency to set (may be approximate).
+ * @relation: Relation to use for frequency selection.
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
+				unsigned int target_freq, unsigned int relation)
+{
+	unsigned int freq;
+
+	freq = cpufreq_driver->fast_switch(policy, target_freq, relation);
+	if (freq != CPUFREQ_ENTRY_INVALID) {
+		policy->cur = freq;
+		trace_cpu_frequency(freq, smp_processor_id());
+	}
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -81,6 +81,7 @@ struct cpufreq_policy {
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
+	bool			fast_switch_possible;
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
@@ -236,6 +237,9 @@ struct cpufreq_driver {
 				  unsigned int relation);	/* Deprecated */
 	int		(*target_index)(struct cpufreq_policy *policy,
 					unsigned int index);
+	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
+				       unsigned int target_freq,
+				       unsigned int relation);
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -450,6 +454,8 @@ struct cpufreq_governor {
 };
 
 /* Pass a target to the cpufreq driver */
+void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+				unsigned int target_freq, unsigned int relation);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
