From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH v7 6/7] cpufreq: Support for fast frequency switching
Date: Wed, 30 Mar 2016 03:47:49 +0200
Message-ID: <16969991.55r1UouI6A@vostro.rjw.lan>
References: <7262976.zPkLj56ATU@vostro.rjw.lan> <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42648 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752944AbcC3Bpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 21:45:30 -0400
In-Reply-To: <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the ACPI cpufreq driver to provide a method for switching
CPU frequencies from interrupt context and update the cpufreq core
to support that method if available.

Introduce a new cpufreq driver callback, ->fast_switch, to be
invoked for frequency switching from interrupt context by (future)
governors supporting that feature via (new) helper function
cpufreq_driver_fast_switch().

Add two new policy flags, fast_switch_possible, to be set by the
cpufreq driver if fast frequency switching can be used for the
given policy and fast_switch_enabled, to be set by the governor
if it is going to use fast frequency switching for the given
policy.  Also add a helper for setting the latter.

Since fast frequency switching is inherently incompatible with
cpufreq transition notifiers, make it possible to set the
fast_switch_enabled only if there are no transition notifiers
already registered and make the registration of new transition
notifiers fail if fast_switch_enabled is set for at least one
policy.

Implement the ->fast_switch callback in the ACPI cpufreq driver
and make it set fast_switch_possible during policy initialization
as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v6:
- Added cpufreq_exit_governor() that disables fast frequency switching
  before calling cpufreq_governor(_EXIT) and updated the callers of the
  latter to use the new function instead.
- Modified cpufreq_driver_fast_switch() to apply the limits to target_freq.
- Modified the changelog of cpufreq_driver_fast_switch() to mention the
  RCU-sched read-side critical sections requirement for ->fast_switch.
- Added a comment describing fast_switch_possible and fast_switch_enabled.
- Modified acpi-cpufreq to clear policy->fast_switch_possible when
  policy->driver_data is cleared.

Changes from v5:
- cpufreq_enable_fast_switch() fixed to avoid printing a confusing message
  if fast_switch_possible is not set for the policy.
- Fixed a typo in that message.
- Removed the WARN_ON() from the (cpufreq_fast_switch_count > 0) check in
  cpufreq_register_notifier(), because it triggered false-positive warnings
  from the cpufreq_stats module (cpufreq_stats don't work with the fast
  switching, because it is based on notifiers).

Changes from v4:
- If cpufreq_enable_fast_switch() is about to fail, it will print the list
  of currently registered transition notifiers.
- Added lock_assert_held(&policy->rwsem) to cpufreq_enable_fast_switch().
- Added WARN_ON() to the (cpufreq_fast_switch_count > 0) check in
  cpufreq_register_notifier().
- Modified the kerneldoc comment of cpufreq_driver_fast_switch() to
  mention the RELATION_L expectation regarding the ->fast_switch callback.

Changes from v3:
- New fast_switch_enabled field in struct cpufreq_policy to help
  avoid affecting existing setups by setting the fast_switch_possible
  flag in the driver.
- __cpufreq_get() skips the policy->cur check if fast_switch_enabled is set.

Changes from v2:
- The driver ->fast_switch callback and cpufreq_driver_fast_switch()
  don't need the relation argument as they will always do RELATION_L now.
- New mechanism to make fast switch and cpufreq notifiers mutually
  exclusive.
- cpufreq_driver_fast_switch() doesn't do anything in addition to
  invoking the driver callback and returns its return value.

---
 drivers/cpufreq/acpi-cpufreq.c |   42 +++++++++++++
 drivers/cpufreq/cpufreq.c      |  130 +++++++++++++++++++++++++++++++++++++++--
 include/linux/cpufreq.h        |   16 +++++
 3 files changed, 183 insertions(+), 5 deletions(-)

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
@@ -821,6 +858,9 @@ static int acpi_cpufreq_cpu_init(struct
 	 */
 	data->resume = 1;
 
+	policy->fast_switch_possible = !acpi_pstate_strict &&
+		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
+
 	return result;
 
 err_freqfree:
@@ -843,6 +883,7 @@ static int acpi_cpufreq_cpu_exit(struct
 	pr_debug("acpi_cpufreq_cpu_exit\n");
 
 	if (data) {
+		policy->fast_switch_possible = false;
 		policy->driver_data = NULL;
 		acpi_processor_unregister_performance(data->acpi_perf_cpu);
 		free_cpumask_var(data->freqdomain_cpus);
@@ -876,6 +917,7 @@ static struct freq_attr *acpi_cpufreq_at
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
@@ -102,6 +102,17 @@ struct cpufreq_policy {
 	 */
 	struct rw_semaphore	rwsem;
 
+	/*
+	 * Fast switch flags:
+	 * - fast_switch_possible should be set by the driver if it can
+	 *   guarantee that frequency can be changed on any CPU sharing the
+	 *   policy and that the change will affect all of the policy CPUs then.
+	 * - fast_switch_enabled is to be set by governors that support fast
+	 *   freqnency switching with the help of cpufreq_enable_fast_switch().
+	 */
+	bool			fast_switch_possible;
+	bool			fast_switch_enabled;
+
 	/* Synchronization for frequency transitions */
 	bool			transition_ongoing; /* Tracks transition status */
 	spinlock_t		transition_lock;
@@ -156,6 +167,7 @@ int cpufreq_get_policy(struct cpufreq_po
 int cpufreq_update_policy(unsigned int cpu);
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
+void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
@@ -236,6 +248,8 @@ struct cpufreq_driver {
 				  unsigned int relation);	/* Deprecated */
 	int		(*target_index)(struct cpufreq_policy *policy,
 					unsigned int index);
+	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
+				       unsigned int target_freq);
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -464,6 +478,8 @@ struct cpufreq_governor {
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
@@ -77,6 +77,7 @@ static inline bool has_target(void)
 static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static int cpufreq_start_governor(struct cpufreq_policy *policy);
+static int cpufreq_exit_governor(struct cpufreq_policy *policy);
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -429,6 +430,68 @@ void cpufreq_freq_transition_end(struct
 }
 EXPORT_SYMBOL_GPL(cpufreq_freq_transition_end);
 
+/*
+ * Fast frequency switching status count.  Positive means "enabled", negative
+ * means "disabled" and 0 means "not decided yet".
+ */
+static int cpufreq_fast_switch_count;
+static DEFINE_MUTEX(cpufreq_fast_switch_lock);
+
+static void cpufreq_list_transition_notifiers(void)
+{
+	struct notifier_block *nb;
+
+	pr_info("Registered transition notifiers:\n");
+
+	mutex_lock(&cpufreq_transition_notifier_list.mutex);
+
+	for (nb = cpufreq_transition_notifier_list.head; nb; nb = nb->next)
+		pr_info("%pF\n", nb->notifier_call);
+
+	mutex_unlock(&cpufreq_transition_notifier_list.mutex);
+}
+
+/**
+ * cpufreq_enable_fast_switch - Enable fast frequency switching for policy.
+ * @policy: cpufreq policy to enable fast frequency switching for.
+ *
+ * Try to enable fast frequency switching for @policy.
+ *
+ * The attempt will fail if there is at least one transition notifier registered
+ * at this point, as fast frequency switching is quite fundamentally at odds
+ * with transition notifiers.  Thus if successful, it will make registration of
+ * transition notifiers fail going forward.
+ */
+void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
+{
+	lockdep_assert_held(&policy->rwsem);
+
+	if (!policy->fast_switch_possible)
+		return;
+
+	mutex_lock(&cpufreq_fast_switch_lock);
+	if (cpufreq_fast_switch_count >= 0) {
+		cpufreq_fast_switch_count++;
+		policy->fast_switch_enabled = true;
+	} else {
+		pr_warn("CPU%u: Fast frequency switching not enabled\n",
+			policy->cpu);
+		cpufreq_list_transition_notifiers();
+	}
+	mutex_unlock(&cpufreq_fast_switch_lock);
+}
+EXPORT_SYMBOL_GPL(cpufreq_enable_fast_switch);
+
+static void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
+{
+	mutex_lock(&cpufreq_fast_switch_lock);
+	if (policy->fast_switch_enabled) {
+		policy->fast_switch_enabled = false;
+		if (!WARN_ON(cpufreq_fast_switch_count <= 0))
+			cpufreq_fast_switch_count--;
+	}
+	mutex_unlock(&cpufreq_fast_switch_lock);
+}
 
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
@@ -1319,7 +1382,7 @@ static void cpufreq_offline(unsigned int
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		ret = cpufreq_exit_governor(policy);
 		if (ret)
 			pr_err("%s: Failed to exit governor\n", __func__);
 	}
@@ -1447,8 +1510,12 @@ static unsigned int __cpufreq_get(struct
 
 	ret_freq = cpufreq_driver->get(policy->cpu);
 
-	/* Updating inactive policies is invalid, so avoid doing that. */
-	if (unlikely(policy_is_inactive(policy)))
+	/*
+	 * Updating inactive policies is invalid, so avoid doing that.  Also
+	 * if fast frequency switching is used with the given policy, the check
+	 * against policy->cur is pointless, so skip it in that case too.
+	 */
+	if (unlikely(policy_is_inactive(policy)) || policy->fast_switch_enabled)
 		return ret_freq;
 
 	if (ret_freq && policy->cur &&
@@ -1672,8 +1739,18 @@ int cpufreq_register_notifier(struct not
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
+		mutex_lock(&cpufreq_fast_switch_lock);
+
+		if (cpufreq_fast_switch_count > 0) {
+			mutex_unlock(&cpufreq_fast_switch_lock);
+			return -EBUSY;
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
@@ -1706,8 +1783,14 @@ int cpufreq_unregister_notifier(struct n
 
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
@@ -1726,6 +1809,37 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *                              GOVERNORS                            *
  *********************************************************************/
 
+/**
+ * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
+ * @policy: cpufreq policy to switch the frequency for.
+ * @target_freq: New frequency to set (may be approximate).
+ *
+ * Carry out a fast frequency switch without sleeping.
+ *
+ * The driver's ->fast_switch() callback invoked by this function must be
+ * suitable for being called from within RCU-sched read-side critical sections
+ * and it is expected to select the minimum available frequency greater than or
+ * equal to @target_freq (CPUFREQ_RELATION_L).
+ *
+ * This function must not be called if policy->fast_switch_enabled is unset.
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
+	clamp_val(target_freq, policy->min, policy->max);
+
+	return cpufreq_driver->fast_switch(policy, target_freq);
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)
@@ -1946,6 +2060,12 @@ static int cpufreq_start_governor(struct
 	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 }
 
+static int cpufreq_exit_governor(struct cpufreq_policy *policy)
+{
+	cpufreq_disable_fast_switch(policy);
+	return cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+}
+
 int cpufreq_register_governor(struct cpufreq_governor *governor)
 {
 	int err;
@@ -2101,7 +2221,7 @@ static int cpufreq_set_policy(struct cpu
 			return ret;
 		}
 
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		ret = cpufreq_exit_governor(policy);
 		if (ret) {
 			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
 			       __func__, old_gov->name, ret);
@@ -2118,7 +2238,7 @@ static int cpufreq_set_policy(struct cpu
 			pr_debug("cpufreq: governor change\n");
 			return 0;
 		}
-		cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		cpufreq_exit_governor(policy);
 	}
 
 	/* new governor failed, so re-start old one */

