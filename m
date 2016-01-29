From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: intel_pstate: Replace timers with utilization update callbacks
Date: Fri, 29 Jan 2016 23:56:39 +0100
Message-ID: <3694727.XWdGyiGaMJ@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3071836.JbNxX8hU6x@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using a per-CPU deferrable timer for utilization sampling
and P-states adjustments, register a utilization update callback that
will be invoked from the scheduler on utilization changes.

The sampling rate is still the same as what was used for the deferrable
timers, so the functional impact of this patch should be negligible.

Based on an earlier patch from Srinivas Pandruvada.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  103 +++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 64 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -71,7 +71,7 @@ struct sample {
 	u64 mperf;
 	u64 tsc;
 	int freq;
-	ktime_t time;
+	u64 time;
 };
 
 struct pstate_data {
@@ -103,13 +103,13 @@ struct _pid {
 struct cpudata {
 	int cpu;
 
-	struct timer_list timer;
+	struct update_util_data update_util;
 
 	struct pstate_data pstate;
 	struct vid_data vid;
 	struct _pid pid;
 
-	ktime_t last_sample_time;
+	u64	last_sample_time;
 	u64	prev_aperf;
 	u64	prev_mperf;
 	u64	prev_tsc;
@@ -120,6 +120,7 @@ struct cpudata {
 static struct cpudata **all_cpu_data;
 struct pstate_adjust_policy {
 	int sample_rate_ms;
+	s64 sample_rate_ns;
 	int deadband;
 	int setpoint;
 	int p_gain_pct;
@@ -712,7 +713,7 @@ static void core_set_pstate(struct cpuda
 	if (limits->no_turbo && !limits->turbo_disabled)
 		val |= (u64)1 << 32;
 
-	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
+	wrmsrl(MSR_IA32_PERF_CTL, val);
 }
 
 static int knl_get_turbo_pstate(void)
@@ -883,7 +884,7 @@ static inline void intel_pstate_calc_bus
 	sample->core_pct_busy = (int32_t)core_pct;
 }
 
-static inline void intel_pstate_sample(struct cpudata *cpu)
+static inline void intel_pstate_sample(struct cpudata *cpu, u64 time)
 {
 	u64 aperf, mperf;
 	unsigned long flags;
@@ -900,7 +901,7 @@ static inline void intel_pstate_sample(s
 	local_irq_restore(flags);
 
 	cpu->last_sample_time = cpu->sample.time;
-	cpu->sample.time = ktime_get();
+	cpu->sample.time = time;
 	cpu->sample.aperf = aperf;
 	cpu->sample.mperf = mperf;
 	cpu->sample.tsc =  tsc;
@@ -915,22 +916,6 @@ static inline void intel_pstate_sample(s
 	cpu->prev_tsc = tsc;
 }
 
-static inline void intel_hwp_set_sample_time(struct cpudata *cpu)
-{
-	int delay;
-
-	delay = msecs_to_jiffies(50);
-	mod_timer_pinned(&cpu->timer, jiffies + delay);
-}
-
-static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
-{
-	int delay;
-
-	delay = msecs_to_jiffies(pid_params.sample_rate_ms);
-	mod_timer_pinned(&cpu->timer, jiffies + delay);
-}
-
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
@@ -970,8 +955,7 @@ static inline int32_t get_target_pstate_
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 {
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
-	s64 duration_us;
-	u32 sample_time;
+	u64 duration_ns;
 
 	/*
 	 * core_busy is the ratio of actual performance to max
@@ -990,18 +974,16 @@ static inline int32_t get_target_pstate_
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 
 	/*
-	 * Since we have a deferred timer, it will not fire unless
-	 * we are in C0.  So, determine if the actual elapsed time
-	 * is significantly greater (3x) than our sample interval.  If it
-	 * is, then we were idle for a long enough period of time
-	 * to adjust our busyness.
+	 * Since our utilization update callback will not run unless we are
+	 * in C0, check if the actual elapsed time is significantly greater (3x)
+	 * than our sample interval.  If it is, then we were idle for a long
+	 * enough period of time to adjust our busyness.
 	 */
-	sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
-	duration_us = ktime_us_delta(cpu->sample.time,
-				     cpu->last_sample_time);
-	if (duration_us > sample_time * 3) {
-		sample_ratio = div_fp(int_tofp(sample_time),
-				      int_tofp(duration_us));
+	duration_ns = cpu->sample.time - cpu->last_sample_time;
+	if ((s64)duration_ns > pid_params.sample_rate_ns * 3
+	    && cpu->last_sample_time > 0) {
+		sample_ratio = div_fp(int_tofp(pid_params.sample_rate_ns),
+				      int_tofp(duration_ns));
 		core_busy = mul_fp(core_busy, sample_ratio);
 	}
 
@@ -1031,23 +1013,17 @@ static inline void intel_pstate_adjust_b
 		sample->freq);
 }
 
-static void intel_hwp_timer_func(unsigned long __data)
-{
-	struct cpudata *cpu = (struct cpudata *) __data;
-
-	intel_pstate_sample(cpu);
-	intel_hwp_set_sample_time(cpu);
-}
-
-static void intel_pstate_timer_func(unsigned long __data)
+static void intel_pstate_update_util(struct update_util_data *data, u64 time,
+				     unsigned long util, unsigned long max)
 {
-	struct cpudata *cpu = (struct cpudata *) __data;
-
-	intel_pstate_sample(cpu);
+	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+	u64 delta_ns = time - cpu->sample.time;
 
-	intel_pstate_adjust_busy_pstate(cpu);
-
-	intel_pstate_set_sample_time(cpu);
+	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
+		intel_pstate_sample(cpu, time);
+		if (!hwp_active)
+			intel_pstate_adjust_busy_pstate(cpu);
+	}
 }
 
 #define ICPU(model, policy) \
@@ -1095,24 +1071,19 @@ static int intel_pstate_init_cpu(unsigne
 
 	cpu->cpu = cpunum;
 
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_hwp_enable(cpu);
+		pid_params.sample_rate_ms = 50;
+		pid_params.sample_rate_ns = 50 * NSEC_PER_MSEC;
+	}
 
 	intel_pstate_get_cpu_pstates(cpu);
 
-	init_timer_deferrable(&cpu->timer);
-	cpu->timer.data = (unsigned long)cpu;
-	cpu->timer.expires = jiffies + HZ/100;
-
-	if (!hwp_active)
-		cpu->timer.function = intel_pstate_timer_func;
-	else
-		cpu->timer.function = intel_hwp_timer_func;
-
 	intel_pstate_busy_pid_reset(cpu);
-	intel_pstate_sample(cpu);
+	intel_pstate_sample(cpu, 0);
 
-	add_timer_on(&cpu->timer, cpunum);
+	cpu->update_util.func = intel_pstate_update_util;
+	cpufreq_set_update_util_data(cpunum, &cpu->update_util);
 
 	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
 
@@ -1196,7 +1167,9 @@ static void intel_pstate_stop_cpu(struct
 
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
-	del_timer_sync(&all_cpu_data[cpu_num]->timer);
+	cpufreq_set_update_util_data(cpu_num, NULL);
+	synchronize_rcu();
+
 	if (hwp_active)
 		return;
 
@@ -1260,6 +1233,7 @@ static int intel_pstate_msrs_not_valid(v
 static void copy_pid_params(struct pstate_adjust_policy *policy)
 {
 	pid_params.sample_rate_ms = policy->sample_rate_ms;
+	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
 	pid_params.p_gain_pct = policy->p_gain_pct;
 	pid_params.i_gain_pct = policy->i_gain_pct;
 	pid_params.d_gain_pct = policy->d_gain_pct;
@@ -1451,7 +1425,8 @@ out:
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
-			del_timer_sync(&all_cpu_data[cpu]->timer);
+			cpufreq_set_update_util_data(cpu, NULL);
+			synchronize_rcu();
 			kfree(all_cpu_data[cpu]);
 		}
 	}
