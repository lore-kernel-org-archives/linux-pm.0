From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 5/7] cpufreq: Support for fast frequency switching
Date: Tue, 08 Mar 2016 03:38:42 +0100
Message-ID: <6776225.vx7vHGyDRA@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48556 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753635AbcCHCw6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 21:52:58 -0500
In-Reply-To: <4088601.C2vItRYpQn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Support for fast frequency switching

Modify the ACPI cpufreq driver to provide a method for switching
CPU frequencies from interrupt context and update the cpufreq core
to support that method if available.

Introduce a new cpufreq driver callback, ->fast_switch, to be
invoked for frequency switching from interrupt context by (future)
governors supporting that feature via (new) helper function
Add a new policy flag,
fast_switch_possible, to be set if fast frequency switching can
be used for the given policy and add a helper for setting that
flag.

Since fast frequency switching is inherently incompatible with
cpufreq transition notifiers, make it possible to set the
fast_switch_possible only if there are no transition notifiers
already registered and make the registration of new transition
notifiers fail if the fast_switch_possible flag is set for at
least one policy.

Implement the ->fast_switch callback in the ACPI cpufreq driver
and make it set fast_switch_possible during policy initialization
as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v2:
- The driver ->fast_switch callback and cpufreq_driver_fast_switch()
  don't need the relation argument as they will always do RELATION_L now.
- New mechanism to make fast switch and cpufreq notifiers mutually
  exclusive.
- cpufreq_driver_fast_switch() doesn't do anything in addition to
  invoking the driver callback and returns its return value.

---
 drivers/cpufreq/acpi-cpufreq.c |   42 ++++++++++++++++++++
 drivers/cpufreq/cpufreq.c      |   85 ++++++++++++++++++++++++++++++++++++++---
 include/linux/cpufreq.h        |    6 ++
 3 files changed, 127 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -458,6 +458,43 @@ static int acpi_cpufreq_target(struct cp
 	return result;
 }
 
+unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+				      unsigned int target_freq)
+{
+	struct acpi_cpufreq_data *data = policy->driver_data;
+	struct acpi_processor_performance *perf;
+	struct cpufreq_frequency_table *entry;
+	unsigned int next_perf_state, next_freq, freq;
+
+	/*
+	 * Find the closest frequency above target_freq.
+	 *
+	 * The table is sorted in the reverse order with respect to the
+	 * frequency and all of the entries are valid (see the initialization).
+	 */
+	entry = data->freq_table;
+	do {
+		entry++;
+		freq = entry->frequency;
+	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
+	entry--;
+	next_freq = entry->frequency;
+	next_perf_state = entry->driver_data;
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
@@ -740,6 +777,10 @@ static int acpi_cpufreq_cpu_init(struct
 		goto err_unreg;
 	}
 
+	if (!acpi_pstate_strict && !(policy_is_shared(policy)
+	    && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY))
+		cpufreq_enable_fast_switch(policy);
+
 	data->freq_table = kzalloc(sizeof(*data->freq_table) *
 		    (perf->state_count+1), GFP_KERNEL);
 	if (!data->freq_table) {
@@ -874,6 +915,7 @@ static struct freq_attr *acpi_cpufreq_at
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
@@ -81,6 +81,7 @@ struct cpufreq_policy {
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
+	bool			fast_switch_possible;
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
@@ -156,6 +157,7 @@ int cpufreq_get_policy(struct cpufreq_po
 int cpufreq_update_policy(unsigned int cpu);
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
+void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
@@ -236,6 +238,8 @@ struct cpufreq_driver {
 				  unsigned int relation);	/* Deprecated */
 	int		(*target_index)(struct cpufreq_policy *policy,
 					unsigned int index);
+	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
+				       unsigned int target_freq);
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -450,6 +454,8 @@ struct cpufreq_governor {
 };
 
 /* Pass a target to the cpufreq driver */
+unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+					unsigned int target_freq);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -428,6 +428,26 @@ void cpufreq_freq_transition_end(struct
 }
 EXPORT_SYMBOL_GPL(cpufreq_freq_transition_end);
 
+/*
+ * Fast frequency switching status count.  Positive means "enabled", negative
+ * means "disabled" and 0 means "don't care".
+ */
+static int cpufreq_fast_switch_count;
+static DEFINE_MUTEX(cpufreq_fast_switch_lock);
+
+void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
+{
+	mutex_lock(&cpufreq_fast_switch_lock);
+	if (cpufreq_fast_switch_count >= 0) {
+		cpufreq_fast_switch_count++;
+		policy->fast_switch_possible = true;
+	} else {
+		pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",
+			policy->cpu);
+	}
+	mutex_unlock(&cpufreq_fast_switch_lock);
+}
+EXPORT_SYMBOL_GPL(cpufreq_enable_fast_switch);
 
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
@@ -1074,6 +1094,23 @@ static void cpufreq_policy_free(struct c
 	kfree(policy);
 }
 
+static void cpufreq_driver_exit_policy(struct cpufreq_policy *policy)
+{
+	if (policy->fast_switch_possible) {
+		mutex_lock(&cpufreq_fast_switch_lock);
+
+		if (!WARN_ON(cpufreq_fast_switch_count <= 0))
+			cpufreq_fast_switch_count--;
+
+		mutex_unlock(&cpufreq_fast_switch_lock);
+	}
+
+	if (cpufreq_driver->exit) {
+		cpufreq_driver->exit(policy);
+		policy->freq_table = NULL;
+	}
+}
+
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -1237,8 +1274,7 @@ static int cpufreq_online(unsigned int c
 out_exit_policy:
 	up_write(&policy->rwsem);
 
-	if (cpufreq_driver->exit)
-		cpufreq_driver->exit(policy);
+	cpufreq_driver_exit_policy(policy);
 out_free_policy:
 	cpufreq_policy_free(policy, !new_policy);
 	return ret;
@@ -1335,10 +1371,7 @@ static void cpufreq_offline(unsigned int
 	 * since this is a core component, and is essential for the
 	 * subsequent light-weight ->init() to succeed.
 	 */
-	if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
-	}
+	cpufreq_driver_exit_policy(policy);
 
 unlock:
 	up_write(&policy->rwsem);
@@ -1665,8 +1698,18 @@ int cpufreq_register_notifier(struct not
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
+		mutex_lock(&cpufreq_fast_switch_lock);
+
+		if (cpufreq_fast_switch_count > 0) {
+			mutex_unlock(&cpufreq_fast_switch_lock);
+			return -EPERM;
+		}
 		ret = srcu_notifier_chain_register(
 				&cpufreq_transition_notifier_list, nb);
+		if (!ret)
+			cpufreq_fast_switch_count--;
+
+		mutex_unlock(&cpufreq_fast_switch_lock);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
 		ret = blocking_notifier_chain_register(
@@ -1699,8 +1742,14 @@ int cpufreq_unregister_notifier(struct n
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
+		mutex_lock(&cpufreq_fast_switch_lock);
+
 		ret = srcu_notifier_chain_unregister(
 				&cpufreq_transition_notifier_list, nb);
+		if (!ret && !WARN_ON(cpufreq_fast_switch_count >= 0))
+			cpufreq_fast_switch_count++;
+
+		mutex_unlock(&cpufreq_fast_switch_lock);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
 		ret = blocking_notifier_chain_unregister(
@@ -1719,6 +1768,30 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
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
+ * callback to indicate an error condition, the hardware configuration must be
+ * preserved.
+ */
+unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
+					unsigned int target_freq)
+{
+	return cpufreq_driver->fast_switch(policy, target_freq);
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)

