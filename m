From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH 3/3] cpufreq: intel_pstate: Use IOWAIT flag in Atom algorithm
Date: Wed, 14 Sep 2016 01:59:01 +0200
Message-ID: <1818746.EeBqHM9Bma@vostro.rjw.lan>
References: <21371892.ALJNnHKoBY@vostro.rjw.lan> <29486595.JUjvqvQbIp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44760 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932943AbcIMXwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 19:52:55 -0400
In-Reply-To: <29486595.JUjvqvQbIp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Doug Smythies <doug.smythies@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the P-state selection algorithm for Atom processors to use
the new SCHED_CPUFREQ_IOWAIT flag instead of the questionable
get_cpu_iowait_time_us() function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The PID uses percents not fractions, so pass sample->busy_scaled instead of
busy_frac to it in get_target_pstate_use_cpu_load().

---
 drivers/cpufreq/intel_pstate.c |   58 +++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

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
@@ -1037,6 +1043,7 @@ static struct cpu_defaults silvermont_pa
 		.p_gain_pct = 14,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
+		.boost_iowait = true,
 	},
 	.funcs = {
 		.get_max = atom_get_max_pstate,
@@ -1058,6 +1065,7 @@ static struct cpu_defaults airmont_param
 		.p_gain_pct = 14,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
+		.boost_iowait = true,
 	},
 	.funcs = {
 		.get_max = atom_get_max_pstate,
@@ -1099,6 +1107,7 @@ static struct cpu_defaults bxt_params =
 		.p_gain_pct = 14,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
+		.boost_iowait = true,
 	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
@@ -1222,36 +1231,18 @@ static inline int32_t get_avg_pstate(str
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
-	u64 cummulative_iowait, delta_iowait_us;
-	u64 delta_iowait_mperf;
-	u64 mperf, now;
-	int32_t cpu_load;
+	int32_t busy_frac, boost;
 
-	cummulative_iowait = get_cpu_iowait_time_us(cpu->cpu, &now);
+	busy_frac = div_fp(sample->mperf, sample->tsc);
 
-	/*
-	 * Convert iowait time into number of IO cycles spent at max_freq.
-	 * IO is considered as busy only for the cpu_load algorithm. For
-	 * performance this is not needed since we always try to reach the
-	 * maximum P-State, so we are already boosting the IOs.
-	 */
-	delta_iowait_us = cummulative_iowait - cpu->prev_cummulative_iowait;
-	delta_iowait_mperf = div64_u64(delta_iowait_us * cpu->pstate.scaling *
-		cpu->pstate.max_pstate, MSEC_PER_SEC);
+	boost = cpu->iowait_boost;
+	cpu->iowait_boost >>= 1;
 
-	mperf = cpu->sample.mperf + delta_iowait_mperf;
-	cpu->prev_cummulative_iowait = cummulative_iowait;
-
-	/*
-	 * The load can be estimated as the ratio of the mperf counter
-	 * running at a constant frequency during active periods
-	 * (C0) and the time stamp counter running at the same frequency
-	 * also during C-states.
-	 */
-	cpu_load = div64_u64(int_tofp(100) * mperf, sample->tsc);
-	cpu->sample.busy_scaled = cpu_load;
+	if (busy_frac < boost)
+		busy_frac = boost;
 
-	return get_avg_pstate(cpu) - pid_calc(&cpu->pid, cpu_load);
+	sample->busy_scaled = busy_frac * 100;
+	return get_avg_pstate(cpu) - pid_calc(&cpu->pid, sample->busy_scaled);
 }
 
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
@@ -1332,8 +1323,21 @@ static void intel_pstate_update_util(str
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
 

