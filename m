From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH v2] cpufreq: intel_pstate: Change the calculation of next
 pstate
Date: Fri, 02 May 2014 00:00:37 +0300
Message-ID: <5362B5F5.1020706@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, dirk.brandewie@gmail.com
List-Id: linux-pm@vger.kernel.org

Currently the driver calculates the next pstate proportional to
core_busy factor, scaled by the ratio max_pstate / current_pstate.

Using the scaled load (core_busy) to calculate the next pstate
is not always correct, because there are cases that the load is 
independent from current pstate. For example, a tight 'for' loop
through many sampling intervals will cause a load of 100% in
every pstate.

So, change the above method and calculate the next pstate with
the assumption that the next pstate should not depend on the
current pstate. The next pstate should only be directly
proportional to measured load. 

Tested on Intel i7-3770 CPU @ 3.40GHz.
Phoronix benchmark of Linux Kernel Compilation 3.1 test shows an
increase ~1.5% in performance. Below the test results using turbostat
(5 iterations):

Without patch:

Ph. avg Time	Total time	PkgWatt		Total Energy
	79.63	266.416		57.74		15382.85984
	79.63	265.609		57.87		15370.79283
	79.57	266.994		57.54		15362.83476
	79.53	265.304		57.83		15342.53032
	79.71	265.977		57.76		15362.83152
avg	79.61	266.06		57.74		15364.36985

With patch:

Ph. avg Time	Total time	PkgWatt		Total Energy
	78.23	258.826		59.14		15306.96964
	78.41	259.110		59.15		15326.35650
	78.40	258.530		59.26		15320.48780
	78.46	258.673		59.20		15313.44160
	78.19	259.075		59.16		15326.87700
avg	78.34	258.842		59.18		15318.82650

The total test time reduced by ~2.6%, while the total energy
consumption during a test iteration reduced by ~0.35%

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---

Changes v1 -> v2
	- Enhance change log as Rafael and Viresh suggested
 

 drivers/cpufreq/intel_pstate.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0999673..8e309db 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -608,28 +608,27 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
-static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
+static inline int32_t intel_pstate_get_busy(struct cpudata *cpu)
 {
-	int32_t core_busy, max_pstate, current_pstate;
+	int32_t core_busy, max_pstate;
 
 	core_busy = cpu->sample.core_pct_busy;
 	max_pstate = int_tofp(cpu->pstate.max_pstate);
-	current_pstate = int_tofp(cpu->pstate.current_pstate);
-	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
+	core_busy = mul_fp(core_busy, max_pstate);
 	return FP_ROUNDUP(core_busy);
 }
 
 static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 {
-	int32_t busy_scaled;
+	int32_t busy;
 	struct _pid *pid;
 	signed int ctl = 0;
 	int steps;
 
 	pid = &cpu->pid;
-	busy_scaled = intel_pstate_get_scaled_busy(cpu);
+	busy = intel_pstate_get_busy(cpu);
 
-	ctl = pid_calc(pid, busy_scaled);
+	ctl = pid_calc(pid, busy);
 
 	steps = abs(ctl);
 
@@ -651,7 +650,7 @@ static void intel_pstate_timer_func(unsigned long __data)
 	intel_pstate_adjust_busy_pstate(cpu);
 
 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
-			fp_toint(intel_pstate_get_scaled_busy(cpu)),
+			fp_toint(intel_pstate_get_busy(cpu)),
 			cpu->pstate.current_pstate,
 			sample->mperf,
 			sample->aperf,
-- 
1.9.0
