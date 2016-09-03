From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 2/4]  cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Sat, 03 Sep 2016 03:02:08 +0200
Message-ID: <3156326.nF8LsxcLZH@vostro.rjw.lan>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <doug.smythies@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PID-base P-state selection algorithm used by intel_pstate for
Core processors is based on very weak foundations.  Namely, its
decisions are mostly based on the values of the APERF and MPERF
feedback registers and it only estimates the actual utilization to
check if it is not extremely low (in order to avoid getting stuck
in the highest P-state in that case).

Since it generally causes the CPU P-state to ramp up quickly, it
leads to satisfactory performance, but the metric used by it is only
really valid when the CPU changes P-states by itself (ie. in the turbo
range) and if the P-state value set by the driver is treated by the
CPU as the upper limit on turbo P-states selected by it.

As a result, the only case when P-states are reduced by that
algorithm is when the CPU has just come out of idle, but in that
particular case it would have been better to bump up the P-state
instead.  That causes some benchmarks to behave erratically and
attempts to improve the situation lead to excessive energy
consumption, because they make the CPU stay in very high P-states
almost all the time.

Consequently, the only viable way to fix that is to replace the
erroneous algorithm entirely with a new one.

To that end, notice that setting the P-state proportional to the
actual CPU utilization (measured with the help of MPERF and TSC)
generally leads to reasonable behavior, but it does not reflect
the "performance boosting" nature of the current P-state
selection algorithm.  It may be made more similar to that
algorithm, though, by adding iowait boosting to it.

Specifically, if the P-state is bumped up to the maximum after
receiving the SCHED_CPUFREQ_IOWAIT flag via cpufreq_update_util(),
it will allow tasks that were previously waiting on I/O to get the
full capacity of the CPU when they are ready to process data again
and that should lead to the desired performance increase overall
without sacrificing too much energy.

However, the utilization-based method of target P-state selection
may cause the resultant target P-state to oscillate which generally
leads to excessive consumption of energy, so apply an Infinite
Impulse Response filter on top of it to dampen those osciallations
and make it more energy-efficient (thanks to Doug Smythies for this
idea).

Use the approach as described in intel_pstate for Core processors.

Original-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This includes an IIR filter on top of the load-based P-state selection,
but the filter is applied to the non-boosted case only (otherwise it
defeats the point of the boost) and I used a slightly different raw gain
value.

Thanks,
Rafael

---
 drivers/cpufreq/intel_pstate.c |   81 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -98,6 +98,7 @@ static inline u64 div_ext_fp(u64 x, u64
  * @tsc:		Difference of time stamp counter between last and
  *			current sample
  * @time:		Current time from scheduler
+ * @target:		Target P-state
  *
  * This structure is used in the cpudata structure to store performance sample
  * data for choosing next P State.
@@ -109,6 +110,7 @@ struct sample {
 	u64 mperf;
 	u64 tsc;
 	u64 time;
+	int target;
 };
 
 /**
@@ -181,6 +183,8 @@ struct _pid {
  * @cpu:		CPU number for this instance data
  * @update_util:	CPUFreq utility callback information
  * @update_util_set:	CPUFreq utility callback is set
+ * @iowait_boost:	iowait-related boost fraction
+ * @last_update:	Time of the last update.
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
  * @pid:		Stores PID parameters for this CPU
@@ -206,6 +210,7 @@ struct cpudata {
 	struct vid_data vid;
 	struct _pid pid;
 
+	u64	last_update;
 	u64	last_sample_time;
 	u64	prev_aperf;
 	u64	prev_mperf;
@@ -216,6 +221,7 @@ struct cpudata {
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
 #endif
+	unsigned int iowait_boost;
 };
 
 static struct cpudata **all_cpu_data;
@@ -229,6 +235,7 @@ static struct cpudata **all_cpu_data;
  * @p_gain_pct:		PID proportional gain
  * @i_gain_pct:		PID integral gain
  * @d_gain_pct:		PID derivative gain
+ * @boost_iowait:	Whether or not to use iowait boosting.
  *
  * Stores per CPU model static PID configuration data.
  */
@@ -240,6 +247,7 @@ struct pstate_adjust_policy {
 	int p_gain_pct;
 	int d_gain_pct;
 	int i_gain_pct;
+	bool boost_iowait;
 };
 
 /**
@@ -277,6 +285,7 @@ struct cpu_defaults {
 	struct pstate_funcs funcs;
 };
 
+static inline int32_t get_target_pstate_default(struct cpudata *cpu);
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 
@@ -1017,6 +1026,7 @@ static struct cpu_defaults core_params =
 		.p_gain_pct = 20,
 		.d_gain_pct = 0,
 		.i_gain_pct = 0,
+		.boost_iowait = true,
 	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
@@ -1025,7 +1035,7 @@ static struct cpu_defaults core_params =
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.get_val = core_get_val,
-		.get_target_pstate = get_target_pstate_use_performance,
+		.get_target_pstate = get_target_pstate_default,
 	},
 };
 
@@ -1139,6 +1149,7 @@ static void intel_pstate_set_min_pstate(
 
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
 	cpu->pstate.current_pstate = pstate;
+	cpu->sample.target = pstate;
 	/*
 	 * Generally, there is no guarantee that this code will always run on
 	 * the CPU being updated, so force the register update to run on the
@@ -1290,6 +1301,59 @@ static inline int32_t get_target_pstate_
 	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, perf_scaled);
 }
 
+static inline int32_t get_target_pstate_default(struct cpudata *cpu)
+{
+	struct sample *sample = &cpu->sample;
+	int32_t busy_frac, boost;
+	int pstate, max_perf, min_perf;
+	int64_t target;
+
+	pstate = limits->no_turbo || limits->turbo_disabled ?
+			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
+	pstate += pstate >> 2;
+
+	busy_frac = div_fp(sample->mperf, sample->tsc);
+	sample->busy_scaled = busy_frac * 100;
+
+	boost = cpu->iowait_boost;
+	cpu->iowait_boost >>= 1;
+
+	if (busy_frac < boost) {
+		target = pstate * boost;
+	} else {
+		int32_t iir_gain;
+
+		target = pstate * busy_frac;
+		/*
+		 * Use an Infinite Impulse Response (IIR) filter:
+		 *
+		 *	new_output = old_output * (1 - gain) + input * gain
+		 *
+		 * where pstate * busy_frac is the input.
+		 *
+		 * The purpose of this is to dampen output oscillations that are
+		 * otherwise possible and lead to increased energy consumption.
+		 *
+		 * Compute the filter gain as a function of the time since the
+		 * last pass (delta_t) so as to reduce, or even eliminate, the
+		 * influence of what might be a very stale old_output value.
+		 *
+		 * Take the raw gain as 1/8 and compute the effective gain as
+		 *
+		 *	iir_gain = 1/8 * delta_t / sampling_interval
+		 */
+		iir_gain = div_fp(sample->time - cpu->last_sample_time,
+				  pid_params.sample_rate_ns << 3);
+		if (iir_gain < int_tofp(1))
+			target = sample->target * (int_tofp(1) - iir_gain) +
+					mul_fp(target, iir_gain);
+	}
+	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
+	target = clamp_val(target, int_tofp(min_perf), int_tofp(max_perf));
+	sample->target = fp_toint(target + (1 << (FRAC_BITS-1)));
+	return sample->target;
+}
+
 static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
 {
 	int max_perf, min_perf;
@@ -1332,8 +1396,21 @@ static void intel_pstate_update_util(str
 				     unsigned int flags)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
-	u64 delta_ns = time - cpu->sample.time;
+	u64 delta_ns;
+
+	if (pid_params.boost_iowait) {
+		if (flags & SCHED_CPUFREQ_IOWAIT) {
+			cpu->iowait_boost = int_tofp(1);
+		} else if (cpu->iowait_boost) {
+			/* Clear iowait_boost if the CPU may have been idle. */
+			delta_ns = time - cpu->last_update;
+			if (delta_ns > TICK_NSEC)
+				cpu->iowait_boost = 0;
+		}
+		cpu->last_update = time;
+	}
 
+	delta_ns = time - cpu->sample.time;
 	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
 		bool sample_taken = intel_pstate_sample(cpu, time);
 
