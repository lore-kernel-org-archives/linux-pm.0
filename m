From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 4/7] cpufreq: intel_pstate: Simplify code in intel_pstate_adjust_busy_pstate
Date: Tue, 10 Jun 2014 00:00:45 +0300
Message-ID: <5396207D.7030704@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Simplify the code by removing the inline functions
pstate_increase and pstate_decrease and use directly the
intel_pstate_set_pstate.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/intel_pstate.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3a49269..26a0262 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -588,21 +588,6 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	pstate_funcs.set(cpu, pstate);
 }
 
-static inline void intel_pstate_pstate_increase(struct cpudata *cpu, int steps)
-{
-	int target;
-	target = cpu->pstate.current_pstate + steps;
-
-	intel_pstate_set_pstate(cpu, target);
-}
-
-static inline void intel_pstate_pstate_decrease(struct cpudata *cpu, int steps)
-{
-	int target;
-	target = cpu->pstate.current_pstate - steps;
-	intel_pstate_set_pstate(cpu, target);
-}
-
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
@@ -695,20 +680,15 @@ static inline void intel_pstate_calc_scaled_busy(struct cpudata *cpu)
 static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 {
 	struct _pid *pid;
-	signed int ctl = 0;
-	int steps;
+	signed int ctl;
 
 	pid = &cpu->pid;
 	intel_pstate_calc_scaled_busy(cpu);
 
 	ctl = pid_calc(pid, cpu->sample.busy_scaled);
 
-	steps = abs(ctl);
-
-	if (ctl < 0)
-		intel_pstate_pstate_increase(cpu, steps);
-	else
-		intel_pstate_pstate_decrease(cpu, steps);
+	/* Negative values of ctl increase the pstate and vice versa */
+	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
 }
 
 static void intel_pstate_timer_func(unsigned long __data)
-- 
1.9.3
