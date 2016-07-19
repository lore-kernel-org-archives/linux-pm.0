From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Update cpu_frequency tracepoint every time
Date: Tue, 19 Jul 2016 15:10:37 +0200
Message-ID: <3678564.0E838ntcHL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, intel_pstate only updates the cpu_frequency tracepoint
if the new P-state to set is different from the current one, but
that causes powertop to report 100% idle on an 100% loaded system
sometimes.

Prevent that from happening by updating the cpu_frequency tracepoint
every time intel_pstate_update_pstate() is called.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1134,17 +1134,12 @@ static void intel_pstate_get_min_max(str
 	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
 }
 
-static inline void intel_pstate_record_pstate(struct cpudata *cpu, int pstate)
-{
-	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
-	cpu->pstate.current_pstate = pstate;
-}
-
 static void intel_pstate_set_min_pstate(struct cpudata *cpu)
 {
 	int pstate = cpu->pstate.min_pstate;
 
-	intel_pstate_record_pstate(cpu, pstate);
+	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
+	cpu->pstate.current_pstate = pstate;
 	/*
 	 * Generally, there is no guarantee that this code will always run on
 	 * the CPU being updated, so force the register update to run on the
@@ -1304,10 +1299,11 @@ static inline void intel_pstate_update_p
 
 	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
 	pstate = clamp_t(int, pstate, min_perf, max_perf);
+	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
 	if (pstate == cpu->pstate.current_pstate)
 		return;
 
-	intel_pstate_record_pstate(cpu, pstate);
+	cpu->pstate.current_pstate = pstate;
 	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
 }
 
