From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Do not use PID-based P-state selection
Date: Tue, 25 Jul 2017 00:10:59 +0200
Message-ID: <11208019.TpsrN09bfC@aspire.rjw.lan>
References: <6183701.sLtcQDF8CA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64381 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753206AbdGXWUi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 18:20:38 -0400
In-Reply-To: <6183701.sLtcQDF8CA@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All systems with a defined ACPI preferred profile that are not
"servers" have been using the load-based P-state selection algorithm
in intel_pstate since 4.12-rc1 (mobile systems and laptops have been
using it since 4.10-rc1) and no problems with it have been reported
to date.  In particular, no regressions with respect to the PID-based
P-state selection have been reported.  Also testing indicates that
the P-state selection algorithm based on CPU load is generally on par
with the PID-based algorithm performance-wise, and for some workloads
it turns out to be better than the other one, while being more
straightforward and easier to understand at the same time.

Moreover, the PID-based P-state selection algorithm in intel_pstate
is known to be unstable in some situation and generally problematic,
the issues with it are hard to address and it has become a
significant maintenance burden.

For these reasons, make intel_pstate use the "powersave" P-state
selection algorithm based on CPU load in the active mode on all
systems and drop the PID-based P-state selection code along with
all things related to it from the driver.  Also update the
documentation accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |   59 -----
 drivers/cpufreq/intel_pstate.c                |  276 --------------------------
 2 files changed, 9 insertions(+), 326 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -173,28 +173,6 @@ struct vid_data {
 };
 
 /**
- * struct _pid -	Stores PID data
- * @setpoint:		Target set point for busyness or performance
- * @integral:		Storage for accumulated error values
- * @p_gain:		PID proportional gain
- * @i_gain:		PID integral gain
- * @d_gain:		PID derivative gain
- * @deadband:		PID deadband
- * @last_err:		Last error storage for integral part of PID calculation
- *
- * Stores PID coefficients and last error for PID controller.
- */
-struct _pid {
-	int setpoint;
-	int32_t integral;
-	int32_t p_gain;
-	int32_t i_gain;
-	int32_t d_gain;
-	int deadband;
-	int32_t last_err;
-};
-
-/**
  * struct global_params - Global parameters, mostly tunable via sysfs.
  * @no_turbo:		Whether or not to use turbo P-states.
  * @turbo_disabled:	Whethet or not turbo P-states are available at all,
@@ -223,7 +201,6 @@ struct global_params {
  * @last_update:	Time of the last update.
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
- * @pid:		Stores PID parameters for this CPU
  * @last_sample_time:	Last Sample time
  * @aperf_mperf_shift:	Number of clock cycles after aperf, merf is incremented
  *			This shift is a multiplier to mperf delta to
@@ -258,7 +235,6 @@ struct cpudata {
 
 	struct pstate_data pstate;
 	struct vid_data vid;
-	struct _pid pid;
 
 	u64	last_update;
 	u64	last_sample_time;
@@ -284,28 +260,6 @@ struct cpudata {
 static struct cpudata **all_cpu_data;
 
 /**
- * struct pstate_adjust_policy - Stores static PID configuration data
- * @sample_rate_ms:	PID calculation sample rate in ms
- * @sample_rate_ns:	Sample rate calculation in ns
- * @deadband:		PID deadband
- * @setpoint:		PID Setpoint
- * @p_gain_pct:		PID proportional gain
- * @i_gain_pct:		PID integral gain
- * @d_gain_pct:		PID derivative gain
- *
- * Stores per CPU model static PID configuration data.
- */
-struct pstate_adjust_policy {
-	int sample_rate_ms;
-	s64 sample_rate_ns;
-	int deadband;
-	int setpoint;
-	int p_gain_pct;
-	int d_gain_pct;
-	int i_gain_pct;
-};
-
-/**
  * struct pstate_funcs - Per CPU model specific callbacks
  * @get_max:		Callback to get maximum non turbo effective P state
  * @get_max_physical:	Callback to get maximum non turbo physical P state
@@ -333,15 +287,6 @@ struct pstate_funcs {
 };
 
 static struct pstate_funcs pstate_funcs __read_mostly;
-static struct pstate_adjust_policy pid_params __read_mostly = {
-	.sample_rate_ms = 10,
-	.sample_rate_ns = 10 * NSEC_PER_MSEC,
-	.deadband = 0,
-	.setpoint = 97,
-	.p_gain_pct = 20,
-	.d_gain_pct = 0,
-	.i_gain_pct = 0,
-};
 
 static int hwp_active __read_mostly;
 static bool per_cpu_limits __read_mostly;
@@ -509,56 +454,6 @@ static inline void intel_pstate_exit_per
 }
 #endif
 
-static signed int pid_calc(struct _pid *pid, int32_t busy)
-{
-	signed int result;
-	int32_t pterm, dterm, fp_error;
-	int32_t integral_limit;
-
-	fp_error = pid->setpoint - busy;
-
-	if (abs(fp_error) <= pid->deadband)
-		return 0;
-
-	pterm = mul_fp(pid->p_gain, fp_error);
-
-	pid->integral += fp_error;
-
-	/*
-	 * We limit the integral here so that it will never
-	 * get higher than 30.  This prevents it from becoming
-	 * too large an input over long periods of time and allows
-	 * it to get factored out sooner.
-	 *
-	 * The value of 30 was chosen through experimentation.
-	 */
-	integral_limit = int_tofp(30);
-	if (pid->integral > integral_limit)
-		pid->integral = integral_limit;
-	if (pid->integral < -integral_limit)
-		pid->integral = -integral_limit;
-
-	dterm = mul_fp(pid->d_gain, fp_error - pid->last_err);
-	pid->last_err = fp_error;
-
-	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
-	result = result + (1 << (FRAC_BITS-1));
-	return (signed int)fp_toint(result);
-}
-
-static inline void intel_pstate_pid_reset(struct cpudata *cpu)
-{
-	struct _pid *pid = &cpu->pid;
-
-	pid->p_gain = percent_fp(pid_params.p_gain_pct);
-	pid->d_gain = percent_fp(pid_params.d_gain_pct);
-	pid->i_gain = percent_fp(pid_params.i_gain_pct);
-	pid->setpoint = int_tofp(pid_params.setpoint);
-	pid->last_err  = pid->setpoint - int_tofp(100);
-	pid->deadband  = int_tofp(pid_params.deadband);
-	pid->integral  = 0;
-}
-
 static inline void update_turbo_state(void)
 {
 	u64 misc_en;
@@ -911,82 +806,6 @@ static void intel_pstate_update_policies
 		cpufreq_update_policy(cpu);
 }
 
-/************************** debugfs begin ************************/
-static int pid_param_set(void *data, u64 val)
-{
-	unsigned int cpu;
-
-	*(u32 *)data = val;
-	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
-	for_each_possible_cpu(cpu)
-		if (all_cpu_data[cpu])
-			intel_pstate_pid_reset(all_cpu_data[cpu]);
-
-	return 0;
-}
-
-static int pid_param_get(void *data, u64 *val)
-{
-	*val = *(u32 *)data;
-	return 0;
-}
-DEFINE_SIMPLE_ATTRIBUTE(fops_pid_param, pid_param_get, pid_param_set, "%llu\n");
-
-static struct dentry *debugfs_parent;
-
-struct pid_param {
-	char *name;
-	void *value;
-	struct dentry *dentry;
-};
-
-static struct pid_param pid_files[] = {
-	{"sample_rate_ms", &pid_params.sample_rate_ms, },
-	{"d_gain_pct", &pid_params.d_gain_pct, },
-	{"i_gain_pct", &pid_params.i_gain_pct, },
-	{"deadband", &pid_params.deadband, },
-	{"setpoint", &pid_params.setpoint, },
-	{"p_gain_pct", &pid_params.p_gain_pct, },
-	{NULL, NULL, }
-};
-
-static void intel_pstate_debug_expose_params(void)
-{
-	int i;
-
-	debugfs_parent = debugfs_create_dir("pstate_snb", NULL);
-	if (IS_ERR_OR_NULL(debugfs_parent))
-		return;
-
-	for (i = 0; pid_files[i].name; i++) {
-		struct dentry *dentry;
-
-		dentry = debugfs_create_file(pid_files[i].name, 0660,
-					     debugfs_parent, pid_files[i].value,
-					     &fops_pid_param);
-		if (!IS_ERR(dentry))
-			pid_files[i].dentry = dentry;
-	}
-}
-
-static void intel_pstate_debug_hide_params(void)
-{
-	int i;
-
-	if (IS_ERR_OR_NULL(debugfs_parent))
-		return;
-
-	for (i = 0; pid_files[i].name; i++) {
-		debugfs_remove(pid_files[i].dentry);
-		pid_files[i].dentry = NULL;
-	}
-
-	debugfs_remove(debugfs_parent);
-	debugfs_parent = NULL;
-}
-
-/************************** debugfs end ************************/
-
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
@@ -1661,44 +1480,6 @@ static inline int32_t get_target_pstate_
 	return target;
 }
 
-static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
-{
-	int32_t perf_scaled, max_pstate, current_pstate, sample_ratio;
-	u64 duration_ns;
-
-	/*
-	 * perf_scaled is the ratio of the average P-state during the last
-	 * sampling period to the P-state requested last time (in percent).
-	 *
-	 * That measures the system's response to the previous P-state
-	 * selection.
-	 */
-	max_pstate = cpu->pstate.max_pstate_physical;
-	current_pstate = cpu->pstate.current_pstate;
-	perf_scaled = mul_ext_fp(cpu->sample.core_avg_perf,
-			       div_fp(100 * max_pstate, current_pstate));
-
-	/*
-	 * Since our utilization update callback will not run unless we are
-	 * in C0, check if the actual elapsed time is significantly greater (3x)
-	 * than our sample interval.  If it is, then we were idle for a long
-	 * enough period of time to adjust our performance metric.
-	 */
-	duration_ns = cpu->sample.time - cpu->last_sample_time;
-	if ((s64)duration_ns > pid_params.sample_rate_ns * 3) {
-		sample_ratio = div_fp(pid_params.sample_rate_ns, duration_ns);
-		perf_scaled = mul_fp(perf_scaled, sample_ratio);
-	} else {
-		sample_ratio = div_fp(100 * (cpu->sample.mperf << cpu->aperf_mperf_shift),
-				      cpu->sample.tsc);
-		if (sample_ratio < int_tofp(1))
-			perf_scaled = 0;
-	}
-
-	cpu->sample.busy_scaled = perf_scaled;
-	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, perf_scaled);
-}
-
 static int intel_pstate_prepare_request(struct cpudata *cpu, int pstate)
 {
 	int max_pstate = intel_pstate_get_base_pstate(cpu);
@@ -1741,23 +1522,6 @@ static void intel_pstate_adjust_pstate(s
 		fp_toint(cpu->iowait_boost * 100));
 }
 
-static void intel_pstate_update_util_pid(struct update_util_data *data,
-					 u64 time, unsigned int flags)
-{
-	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
-	u64 delta_ns = time - cpu->sample.time;
-
-	if ((s64)delta_ns < pid_params.sample_rate_ns)
-		return;
-
-	if (intel_pstate_sample(cpu, time)) {
-		int target_pstate;
-
-		target_pstate = get_target_pstate_use_performance(cpu);
-		intel_pstate_adjust_pstate(cpu, target_pstate);
-	}
-}
-
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 				     unsigned int flags)
 {
@@ -1792,7 +1556,7 @@ static struct pstate_funcs core_funcs =
 	.get_turbo = core_get_turbo_pstate,
 	.get_scaling = core_get_scaling,
 	.get_val = core_get_val,
-	.update_util = intel_pstate_update_util_pid,
+	.update_util = intel_pstate_update_util,
 };
 
 static const struct pstate_funcs silvermont_funcs = {
@@ -1825,7 +1589,7 @@ static const struct pstate_funcs knl_fun
 	.get_aperf_mperf_shift = knl_get_aperf_mperf_shift,
 	.get_scaling = core_get_scaling,
 	.get_val = core_get_val,
-	.update_util = intel_pstate_update_util_pid,
+	.update_util = intel_pstate_update_util,
 };
 
 static const struct pstate_funcs bxt_funcs = {
@@ -1879,8 +1643,6 @@ static const struct x86_cpu_id intel_pst
 	{}
 };
 
-static bool pid_in_use(void);
-
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
@@ -1911,8 +1673,6 @@ static int intel_pstate_init_cpu(unsigne
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
-	} else if (pid_in_use()) {
-		intel_pstate_pid_reset(cpu);
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
@@ -2270,12 +2030,6 @@ static struct cpufreq_driver intel_cpufr
 
 static struct cpufreq_driver *default_driver = &intel_pstate;
 
-static bool pid_in_use(void)
-{
-	return intel_pstate_driver == &intel_pstate &&
-		pstate_funcs.update_util == intel_pstate_update_util_pid;
-}
-
 static void intel_pstate_driver_cleanup(void)
 {
 	unsigned int cpu;
@@ -2310,9 +2064,6 @@ static int intel_pstate_register_driver(
 
 	global.min_perf_pct = min_perf_pct_min();
 
-	if (pid_in_use())
-		intel_pstate_debug_expose_params();
-
 	return 0;
 }
 
@@ -2321,9 +2072,6 @@ static int intel_pstate_unregister_drive
 	if (hwp_active)
 		return -EBUSY;
 
-	if (pid_in_use())
-		intel_pstate_debug_hide_params();
-
 	cpufreq_unregister_driver(intel_pstate_driver);
 	intel_pstate_driver_cleanup();
 
@@ -2391,24 +2139,6 @@ static int __init intel_pstate_msrs_not_
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static void intel_pstate_use_acpi_profile(void)
-{
-	switch (acpi_gbl_FADT.preferred_profile) {
-	case PM_MOBILE:
-	case PM_TABLET:
-	case PM_APPLIANCE_PC:
-	case PM_DESKTOP:
-	case PM_WORKSTATION:
-		pstate_funcs.update_util = intel_pstate_update_util;
-	}
-}
-#else
-static void intel_pstate_use_acpi_profile(void)
-{
-}
-#endif
-
 static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 {
 	pstate_funcs.get_max   = funcs->get_max;
@@ -2420,8 +2150,6 @@ static void __init copy_cpu_funcs(struct
 	pstate_funcs.get_vid   = funcs->get_vid;
 	pstate_funcs.update_util = funcs->update_util;
 	pstate_funcs.get_aperf_mperf_shift = funcs->get_aperf_mperf_shift;
-
-	intel_pstate_use_acpi_profile();
 }
 
 #ifdef CONFIG_ACPI
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -167,35 +167,17 @@ is set.
 ``powersave``
 .............
 
-Without HWP, this P-state selection algorithm generally depends on the
-processor model and/or the system profile setting in the ACPI tables and there
-are two variants of it.
-
-One of them is used with processors from the Atom line and (regardless of the
-processor model) on platforms with the system profile in the ACPI tables set to
-"mobile" (laptops mostly), "tablet", "appliance PC", "desktop", or
-"workstation".  It is also used with processors supporting the HWP feature if
-that feature has not been enabled (that is, with the ``intel_pstate=no_hwp``
-argument in the kernel command line).  It is similar to the algorithm
+Without HWP, this P-state selection algorithm is similar to the algorithm
 implemented by the generic ``schedutil`` scaling governor except that the
 utilization metric used by it is based on numbers coming from feedback
 registers of the CPU.  It generally selects P-states proportional to the
-current CPU utilization, so it is referred to as the "proportional" algorithm.
+current CPU utilization.
 
-The second variant of the ``powersave`` P-state selection algorithm, used in all
-of the other cases (generally, on processors from the Core line, so it is
-referred to as the "Core" algorithm), is based on the values read from the APERF
-and MPERF feedback registers and the previously requested target P-state.
-It does not really take CPU utilization into account explicitly, but as a rule
-it causes the CPU P-state to ramp up very quickly in response to increased
-utilization which is generally desirable in server environments.
-
-Regardless of the variant, this algorithm is run by the driver's utilization
-update callback for the given CPU when it is invoked by the CPU scheduler, but
-not more often than every 10 ms (that can be tweaked via ``debugfs`` in `this
-particular case <Tuning Interface in debugfs_>`_).  Like in the ``performance``
-case, the hardware configuration is not touched if the new P-state turns out to
-be the same as the current one.
+This algorithm is run by the driver's utilization update callback for the
+given CPU when it is invoked by the CPU scheduler, but not more often than
+every 10 ms.  Like in the ``performance`` case, the hardware configuration
+is not touched if the new P-state turns out to be the same as the current
+one.
 
 This is the default P-state selection algorithm if the
 :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
@@ -720,34 +702,7 @@ P-state is called, the ``ftrace`` filter
       gnome-shell-3409  [001] ..s.  2537.650850: intel_pstate_set_pstate <-intel_pstate_timer_func
            <idle>-0     [000] ..s.  2537.654843: intel_pstate_set_pstate <-intel_pstate_timer_func
 
-Tuning Interface in ``debugfs``
--------------------------------
-
-The ``powersave`` algorithm provided by ``intel_pstate`` for `the Core line of
-processors in the active mode <powersave_>`_ is based on a `PID controller`_
-whose parameters were chosen to address a number of different use cases at the
-same time.  However, it still is possible to fine-tune it to a specific workload
-and the ``debugfs`` interface under ``/sys/kernel/debug/pstate_snb/`` is
-provided for this purpose.  [Note that the ``pstate_snb`` directory will be
-present only if the specific P-state selection algorithm matching the interface
-in it actually is in use.]
-
-The following files present in that directory can be used to modify the PID
-controller parameters at run time:
-
-| ``deadband``
-| ``d_gain_pct``
-| ``i_gain_pct``
-| ``p_gain_pct``
-| ``sample_rate_ms``
-| ``setpoint``
-
-Note, however, that achieving desirable results this way generally requires
-expert-level understanding of the power vs performance tradeoff, so extra care
-is recommended when attempting to do that.
-
 
 .. _LCEU2015: http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
 .. _SDM: http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
 .. _ACPI specification: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf
-.. _PID controller: https://en.wikipedia.org/wiki/PID_controller
