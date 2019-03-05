From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/3] cpufreq: intel_pstate: Driver-specific handling of _PPC updates
Date: Tue, 05 Mar 2019 11:30:57 +0100
Message-ID: <53533228.eJvB7ELXLG@aspire.rjw.lan>
References: <1755407.S0oJirvq9V@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1755407.S0oJirvq9V@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Driver-specific handling of _PPC updates

In some cases, the platform firmware disables or enables turbo
frequencies for all CPUs globally before triggering a _PPC change
notification for one of them.  Obviously, that global change affects
all CPUs, not just the notified one, and it needs to be acted upon by
cpufreq.

The intel_pstate driver is able to detect such global changes of
the settings, but it also needs to update policy limits for all
CPUs if that happens, in particular if turbo frequencies are
enabled globally - to allow them to be used.

For this reason, introduce a new cpufreq driver callback to be
invoked on _PPC notifications, if present, instead of simply
calling cpufreq_update_policy() for the notified CPU and make
intel_pstate use it to trigger policy updates for all CPUs
in the system if global settings change.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  * Rename a struct field (the new name is temporary as it is changed by
    patch [3/3] anyway).
  * Use EXPORT_SYMBOL_GPL() for cpufreq_update_limits().

---
 drivers/acpi/processor_perflib.c |    2 +-
 drivers/cpufreq/cpufreq.c        |   16 ++++++++++++++++
 drivers/cpufreq/intel_pstate.c   |   24 ++++++++++++++++++++++++
 include/linux/cpufreq.h          |    4 ++++
 4 files changed, 45 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -181,7 +181,7 @@ void acpi_processor_ppc_has_changed(stru
 			acpi_processor_ppc_ost(pr->handle, 0);
 	}
 	if (ret >= 0)
-		cpufreq_update_policy(pr->id);
+		cpufreq_update_limits(pr->id);
 }
 
 int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2376,6 +2376,22 @@ unlock:
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
+/**
+ * cpufreq_update_limits - Update policy limits for a given CPU.
+ * @cpu: CPU to update the policy limits for.
+ *
+ * Invoke the driver's ->update_limits callback if present or call
+ * cpufreq_update_policy() for @cpu.
+ */
+void cpufreq_update_limits(unsigned int cpu)
+{
+	if (cpufreq_driver->update_limits)
+		cpufreq_driver->update_limits(cpu);
+	else
+		cpufreq_update_policy(cpu);
+}
+EXPORT_SYMBOL_GPL(cpufreq_update_limits);
+
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -179,6 +179,7 @@ struct vid_data {
  *			based on the MSR_IA32_MISC_ENABLE value and whether or
  *			not the maximum reported turbo P-state is different from
  *			the maximum reported non-turbo one.
+ * @turbo_disabled_s:	Saved @turbo_disabled value.
  * @min_perf_pct:	Minimum capacity limit in percent of the maximum turbo
  *			P-state capacity.
  * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
@@ -187,6 +188,7 @@ struct vid_data {
 struct global_params {
 	bool no_turbo;
 	bool turbo_disabled;
+	bool turbo_disabled_s;
 	int max_perf_pct;
 	int min_perf_pct;
 };
@@ -894,6 +896,25 @@ static void intel_pstate_update_policies
 		cpufreq_update_policy(cpu);
 }
 
+static void intel_pstate_update_limits(unsigned int cpu)
+{
+	mutex_lock(&intel_pstate_driver_lock);
+
+	update_turbo_state();
+	/*
+	 * If turbo has been turned on or off globally, policy limits for
+	 * all CPUs need to be updated to reflect that.
+	 */
+	if (global.turbo_disabled_s != global.turbo_disabled) {
+		global.turbo_disabled_s = global.turbo_disabled;
+		intel_pstate_update_policies();
+	} else {
+		cpufreq_update_policy(cpu);
+	}
+
+	mutex_unlock(&intel_pstate_driver_lock);
+}
+
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
@@ -2135,6 +2156,7 @@ static int __intel_pstate_cpu_init(struc
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
+	global.turbo_disabled_s = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
@@ -2179,6 +2201,7 @@ static struct cpufreq_driver intel_pstat
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
+	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",
 };
 
@@ -2313,6 +2336,7 @@ static struct cpufreq_driver intel_cpufr
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
 };
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -195,6 +195,7 @@ void disable_cpufreq(void);
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void cpufreq_update_policy(unsigned int cpu);
+void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
@@ -322,6 +323,9 @@ struct cpufreq_driver {
 	/* should be defined, if possible */
 	unsigned int	(*get)(unsigned int cpu);
 
+	/* Called to update policy limits on firmware notifications. */
+	void		(*update_limits)(unsigned int cpu);
+
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
