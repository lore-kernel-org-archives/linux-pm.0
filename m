From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Mon, 01 Aug 2016 01:38:34 +0200
Message-ID: <1572483.RZjvRFdxPx@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58771 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751092AbcGaXkd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:33 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

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
erroneous algorithm entirely with a better one.

To that end, notice that setting the P-state proportional to the
actual CPU utilization (measured with the help of MPERF and TSC)
generally leads to reasonable behavior, but it does not reflect
the "performance boosting" nature of the current P-state
selection algorithm.  It may be made more similar to that
algorithm, though, by adding iowait boosting to it.

Specifically, if the P-state is bumped up to the maximum after
receiving the UUF_IO flag via cpufreq_update_util(), it will
allow tasks that were previously waiting on I/O to get the full
capacity of the CPU when they are ready to process data again and
that should lead to the desired performance increase overall
without sacrificing too much energy.

For this reason, use the above approach for Core processors in
intel_pstate.

Original-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   43 +++++++++++++++++++++++++++++++++++++++--
 include/linux/sched.h          |    3 ++
 kernel/sched/sched.h           |    3 --
 3 files changed, 44 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -181,6 +181,8 @@ struct _pid {
  * @cpu:		CPU number for this instance data
  * @update_util:	CPUFreq utility callback information
  * @update_util_set:	CPUFreq utility callback is set
+ * @iowait_boost:	iowait-related boost fraction
+ * @last_update:	Time of the last update.
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
  * @pid:		Stores PID parameters for this CPU
@@ -206,6 +208,7 @@ struct cpudata {
 	struct vid_data vid;
 	struct _pid pid;
 
+	u64	last_update;
 	u64	last_sample_time;
 	u64	prev_aperf;
 	u64	prev_mperf;
@@ -216,6 +219,7 @@ struct cpudata {
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
 #endif
+	unsigned int iowait_boost;
 };
 
 static struct cpudata **all_cpu_data;
@@ -229,6 +233,7 @@ static struct cpudata **all_cpu_data;
  * @p_gain_pct:		PID proportional gain
  * @i_gain_pct:		PID integral gain
  * @d_gain_pct:		PID derivative gain
+ * @boost_iowait:	Whether or not to use iowait boosting.
  *
  * Stores per CPU model static PID configuration data.
  */
@@ -240,6 +245,7 @@ struct pstate_adjust_policy {
 	int p_gain_pct;
 	int d_gain_pct;
 	int i_gain_pct;
+	bool boost_iowait;
 };
 
 /**
@@ -277,6 +283,7 @@ struct cpu_defaults {
 	struct pstate_funcs funcs;
 };
 
+static inline int32_t get_target_pstate_default(struct cpudata *cpu);
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 
@@ -1017,6 +1024,7 @@ static struct cpu_defaults core_params =
 		.p_gain_pct = 20,
 		.d_gain_pct = 0,
 		.i_gain_pct = 0,
+		.boost_iowait = true,
 	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
@@ -1025,7 +1033,7 @@ static struct cpu_defaults core_params =
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.get_val = core_get_val,
-		.get_target_pstate = get_target_pstate_use_performance,
+		.get_target_pstate = get_target_pstate_default,
 	},
 };
 
@@ -1290,6 +1298,24 @@ static inline int32_t get_target_pstate_
 	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, perf_scaled);
 }
 
+static inline int32_t get_target_pstate_default(struct cpudata *cpu)
+{
+	struct sample *sample = &cpu->sample;
+	int32_t busy_frac;
+	int pstate;
+
+	busy_frac = div_fp(sample->mperf, sample->tsc);
+	sample->busy_scaled = busy_frac * 100;
+
+	if (busy_frac < cpu->iowait_boost)
+		busy_frac = cpu->iowait_boost;
+
+	cpu->iowait_boost >>= 1;
+
+	pstate = cpu->pstate.turbo_pstate;
+	return fp_toint((pstate + (pstate >> 2)) * busy_frac);
+}
+
 static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
 {
 	int max_perf, min_perf;
@@ -1332,8 +1358,21 @@ static void intel_pstate_update_util(str
 				     unsigned int flags)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
-	u64 delta_ns = time - cpu->sample.time;
+	u64 delta_ns;
+
+	if (pid_params.boost_iowait) {
+		if (flags & UUF_IO) {
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
 

