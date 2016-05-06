From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] intel_pstate: Clarify average performance computation
Date: Sat, 07 May 2016 01:44:32 +0200
Message-ID: <1880504.e9G30eDLBM@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The core_pct_busy field of struct sample actually contains the
average performace during the last sampling period (in percent)
and not the utilization of the core as suggested by its name
which is confusing.

For this reason, change the name of that field to core_avg_perf
and rename the function that computes its value accordingly.

Also notice that it would be more useful if it was a "raw" fraction
rather than percentage, so change its meaning too and update the
code using it accordingly (it is better to change the name of
the field along with its meaning in one go than to make those
two changes separately, as that would likely lead to more
confusion).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -72,10 +72,10 @@ static inline int ceiling_fp(int32_t x)
 
 /**
  * struct sample -	Store performance sample
- * @core_pct_busy:	Ratio of APERF/MPERF in percent, which is actual
+ * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
  *			performance during last sample period
  * @busy_scaled:	Scaled busy value which is used to calculate next
- *			P state. This can be different than core_pct_busy
+ *			P state. This can be different than core_avg_perf
  *			to account for cpu idle period
  * @aperf:		Difference of actual performance frequency clock count
  *			read from APERF MSR between last and current sample
@@ -90,7 +90,7 @@ static inline int ceiling_fp(int32_t x)
  * data for choosing next P State.
  */
 struct sample {
-	int32_t core_pct_busy;
+	int32_t core_avg_perf;
 	int32_t busy_scaled;
 	u64 aperf;
 	u64 mperf;
@@ -1147,15 +1147,11 @@ static void intel_pstate_get_cpu_pstates
 	intel_pstate_set_min_pstate(cpu);
 }
 
-static inline void intel_pstate_calc_busy(struct cpudata *cpu)
+static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
-	int64_t core_pct;
 
-	core_pct = sample->aperf * int_tofp(100);
-	core_pct = div64_u64(core_pct, sample->mperf);
-
-	sample->core_pct_busy = (int32_t)core_pct;
+	sample->core_avg_perf = div_fp(sample->aperf, sample->mperf);
 }
 
 static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
@@ -1198,9 +1194,9 @@ static inline bool intel_pstate_sample(s
 
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
 {
-	return fp_toint(mul_fp(cpu->sample.core_pct_busy,
+	return fp_toint(mul_fp(cpu->sample.core_avg_perf,
 			       int_tofp(cpu->pstate.max_pstate_physical *
-						cpu->pstate.scaling / 100)));
+						cpu->pstate.scaling)));
 }
 
 static inline int32_t get_avg_pstate(struct cpudata *cpu)
@@ -1260,7 +1256,7 @@ static inline int32_t get_target_pstate_
 	 * period. The result will be a percentage of busy at a
 	 * specified pstate.
 	 */
-	core_busy = cpu->sample.core_pct_busy;
+	core_busy = 100 * cpu->sample.core_avg_perf;
 	max_pstate = cpu->pstate.max_pstate_physical;
 	current_pstate = cpu->pstate.current_pstate;
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
@@ -1312,7 +1308,7 @@ static inline void intel_pstate_adjust_b
 	intel_pstate_update_pstate(cpu, target_pstate);
 
 	sample = &cpu->sample;
-	trace_pstate_sample(fp_toint(sample->core_pct_busy),
+	trace_pstate_sample(fp_toint(100 * sample->core_avg_perf),
 		fp_toint(sample->busy_scaled),
 		from,
 		cpu->pstate.current_pstate,
@@ -1332,7 +1328,7 @@ static void intel_pstate_update_util(str
 		bool sample_taken = intel_pstate_sample(cpu, time);
 
 		if (sample_taken) {
-			intel_pstate_calc_busy(cpu);
+			intel_pstate_calc_avg_perf(cpu);
 			if (!hwp_active)
 				intel_pstate_adjust_busy_pstate(cpu);
 		}
