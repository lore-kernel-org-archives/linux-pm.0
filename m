From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2, 1/3] intel_pstate: Clarify average performance computation
Date: Wed, 11 May 2016 19:09:12 +0200
Message-ID: <1487208.l3NOUntOYs@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan> <4400018.TlI4RAhtYU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4400018.TlI4RAhtYU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The core_pct_busy field of struct sample actually contains the
average performace during the last sampling period (in percent)
and not the utilization of the core as suggested by its name
which is confusing.

For this reason, change the name of that field to core_avg_perf
and rename the function that computes its value accordingly.

Also notice that storing this value as percentage requires a costly
integer multiplication to be carried out in a hot path, so instead
store it as an "extended fixed point" value with more fraction bits
and update the code using it accordingly (it is better to change the
name of the field along with its meaning in one go than to make those
two changes separately, as that would likely lead to more
confusion).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Preserve more APERF bits from APERF/MPERF to increase precision

---
 drivers/cpufreq/intel_pstate.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -49,6 +49,9 @@
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
 
+#define EXT_BITS 6
+#define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
+
 static inline int32_t mul_fp(int32_t x, int32_t y)
 {
 	return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
@@ -70,12 +73,22 @@ static inline int ceiling_fp(int32_t x)
 	return ret;
 }
 
+static inline u64 mul_ext_fp(u64 x, u64 y)
+{
+	return (x * y) >> EXT_FRAC_BITS;
+}
+
+static inline u64 div_ext_fp(u64 x, u64 y)
+{
+	return div64_u64(x << EXT_FRAC_BITS, y);
+}
+
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
@@ -90,7 +103,7 @@ static inline int ceiling_fp(int32_t x)
  * data for choosing next P State.
  */
 struct sample {
-	int32_t core_pct_busy;
+	int32_t core_avg_perf;
 	int32_t busy_scaled;
 	u64 aperf;
 	u64 mperf;
@@ -1147,15 +1160,11 @@ static void intel_pstate_get_cpu_pstates
 	intel_pstate_set_min_pstate(cpu);
 }
 
-static inline void intel_pstate_calc_busy(struct cpudata *cpu)
+static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
-	int64_t core_pct;
-
-	core_pct = sample->aperf * int_tofp(100);
-	core_pct = div64_u64(core_pct, sample->mperf);
 
-	sample->core_pct_busy = (int32_t)core_pct;
+	sample->core_avg_perf = div_ext_fp(sample->aperf, sample->mperf);
 }
 
 static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
@@ -1198,9 +1207,8 @@ static inline bool intel_pstate_sample(s
 
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
 {
-	return fp_toint(mul_fp(cpu->sample.core_pct_busy,
-			       int_tofp(cpu->pstate.max_pstate_physical *
-						cpu->pstate.scaling / 100)));
+	return mul_ext_fp(cpu->sample.core_avg_perf,
+			  cpu->pstate.max_pstate_physical * cpu->pstate.scaling);
 }
 
 static inline int32_t get_avg_pstate(struct cpudata *cpu)
@@ -1260,10 +1268,10 @@ static inline int32_t get_target_pstate_
 	 * period. The result will be a percentage of busy at a
 	 * specified pstate.
 	 */
-	core_busy = cpu->sample.core_pct_busy;
 	max_pstate = cpu->pstate.max_pstate_physical;
 	current_pstate = cpu->pstate.current_pstate;
-	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
+	core_busy = mul_ext_fp(cpu->sample.core_avg_perf,
+			       div_fp(100 * max_pstate, current_pstate));
 
 	/*
 	 * Since our utilization update callback will not run unless we are
@@ -1312,7 +1320,7 @@ static inline void intel_pstate_adjust_b
 	intel_pstate_update_pstate(cpu, target_pstate);
 
 	sample = &cpu->sample;
-	trace_pstate_sample(fp_toint(sample->core_pct_busy),
+	trace_pstate_sample(mul_ext_fp(100, sample->core_avg_perf),
 		fp_toint(sample->busy_scaled),
 		from,
 		cpu->pstate.current_pstate,
@@ -1332,7 +1340,7 @@ static void intel_pstate_update_util(str
 		bool sample_taken = intel_pstate_sample(cpu, time);
 
 		if (sample_taken) {
-			intel_pstate_calc_busy(cpu);
+			intel_pstate_calc_avg_perf(cpu);
 			if (!hwp_active)
 				intel_pstate_adjust_busy_pstate(cpu);
 		}
