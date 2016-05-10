From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] intel_pstate: Clarify average performance computation
Date: Tue, 10 May 2016 22:57:09 +0200
Message-ID: <1703361.r4IIOaCPTn@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan> <CAJZ5v0h3Z9Dr72KdXzCiv-5Yb6kjv-Bpt0weacQ2jO0gU96hEQ@mail.gmail.com> <1462910284.28729.116.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60839 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751069AbcEJUxv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2016 16:53:51 -0400
In-Reply-To: <1462910284.28729.116.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tuesday, May 10, 2016 12:58:04 PM Srinivas Pandruvada wrote:
> On Tue, 2016-05-10 at 21:21 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 10, 2016 at 3:18 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > On Sat, 2016-05-07 at 01:44 +0200, Rafael J. Wysocki wrote:
> > > > 
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > The core_pct_busy field of struct sample actually contains the
> > > > average performace during the last sampling period (in percent)
> > > > and not the utilization of the core as suggested by its name
> > > > which is confusing.
> > > > 
> > > > For this reason, change the name of that field to core_avg_perf
> > > > and rename the function that computes its value accordingly.
> > > > 
> > > Makes perfect sense.
> > > 
> > > > 
> > > > Also notice that it would be more useful if it was a "raw"
> > > > fraction
> > > > rather than percentage, so change its meaning too and update the
> > > > code using it accordingly (it is better to change the name of
> > > > the field along with its meaning in one go than to make those
> > > > two changes separately, as that would likely lead to more
> > > > confusion).
> > > Due to the calculation the results from old and new method will be
> > > similar but not same. For example in one scenario the
> > > get_avg_frequency difference is 4.3KHz (printed side by side using
> > > both
> > > old style using pct and new using fraction)
> > > Frequency with old calc: 2996093 Hz
> > I guess the above is the new one?
> > 
> > > 
> > > Frequency with old calc: 3000460 Hz
> > So the relative difference is of the order of 0.1% and that number is
> > not what is used in PID computations.  That's what is printed, but
> > I'm
> > not sure if that's really that important. :-)
> 
> This difference will appear in cpufreq sysfs as their granularity in
> KHz for current frequency. But the difference is very small. So I guess
> no one will notice.

:-)

> > Here, the sample.aperf bits lost because the 100 was moved away from
> > intel_pstate_calc_busy() would be multiplied by a relatively large
> > number to produce the difference that looks significant, but the
> > numbers actually used in computations are a few orders of magnitude
> > smaller.
> > 
> > > 
> > > How much do you think the performance gain changing fraction vs
> > > pct?
> > I'm more concerned about latency than about performance.  On HWP, for
> > example, the costly multiplication removed by this from the hot path
> > is of the order of the half of the work done.
> > 
> > That said, I can do something to retain the bits in question for as
> > long as possible, although the patch will be slightly more
> > complicated
> > then. :-)

The patch below should do the trick.  I haven't tested it yet, but it is simple
enough IMO (of course, the [2-3/3] will need to be rebased on top of this one).

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] intel_pstate: Clarify average performance computation

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
 drivers/cpufreq/intel_pstate.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

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
@@ -72,10 +75,10 @@ static inline int ceiling_fp(int32_t x)
 
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
@@ -90,8 +93,8 @@ static inline int ceiling_fp(int32_t x)
  * data for choosing next P State.
  */
 struct sample {
-	int32_t core_pct_busy;
 	int32_t busy_scaled;
+	u64 core_avg_perf;
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
@@ -1147,15 +1150,12 @@ static void intel_pstate_get_cpu_pstates
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
+	sample->core_avg_perf = div64_u64(sample->aperf << EXT_FRAC_BITS,
+					  sample->mperf);
 }
 
 static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
@@ -1198,9 +1198,8 @@ static inline bool intel_pstate_sample(s
 
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
 {
-	return fp_toint(mul_fp(cpu->sample.core_pct_busy,
-			       int_tofp(cpu->pstate.max_pstate_physical *
-						cpu->pstate.scaling / 100)));
+	return (cpu->sample.core_avg_perf * cpu->pstate.max_pstate_physical *
+			cpu->pstate.scaling) >> EXT_FRAC_BITS;
 }
 
 static inline int32_t get_avg_pstate(struct cpudata *cpu)
@@ -1260,10 +1259,10 @@ static inline int32_t get_target_pstate_
 	 * period. The result will be a percentage of busy at a
 	 * specified pstate.
 	 */
-	core_busy = cpu->sample.core_pct_busy;
 	max_pstate = cpu->pstate.max_pstate_physical;
 	current_pstate = cpu->pstate.current_pstate;
-	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
+	core_busy = (100 * cpu->sample.core_avg_perf *
+			div_fp(max_pstate, current_pstate)) >> EXT_FRAC_BITS;
 
 	/*
 	 * Since our utilization update callback will not run unless we are
@@ -1312,7 +1311,7 @@ static inline void intel_pstate_adjust_b
 	intel_pstate_update_pstate(cpu, target_pstate);
 
 	sample = &cpu->sample;
-	trace_pstate_sample(fp_toint(sample->core_pct_busy),
+	trace_pstate_sample((100 * sample->core_avg_perf) >> EXT_FRAC_BITS,
 		fp_toint(sample->busy_scaled),
 		from,
 		cpu->pstate.current_pstate,
@@ -1332,7 +1331,7 @@ static void intel_pstate_update_util(str
 		bool sample_taken = intel_pstate_sample(cpu, time);
 
 		if (sample_taken) {
-			intel_pstate_calc_busy(cpu);
+			intel_pstate_calc_avg_perf(cpu);
 			if (!hwp_active)
 				intel_pstate_adjust_busy_pstate(cpu);
 		}

