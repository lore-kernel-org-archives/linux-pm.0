From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH v2 3/3] cpufreq: intel_pstate: Avoid triggering cpu_frequency tracepoint unnecessarily
Date: Fri, 03 Mar 2017 23:51:31 +0100
Message-ID: <2721031.hrvEgV4ixJ@aspire.rjw.lan>
References: <1573986.gdsgdO0VUn@aspire.rjw.lan> <6304036.Ap76kdd4Kf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6304036.Ap76kdd4Kf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the passive mode the cpu_frequency trace event is already
triggered by the cpufreq core or by scaling governors, so
intel_pstate should not trigger it once again for the same
P-state updates.

In addition to that, the frequency returned by
intel_cpufreq_fast_switch() and passed via freqs.new from
intel_cpufreq_target() to cpufreq_freq_transition_end() should
reflect the P-state actually set, so make that happen.

Fixes: 001c76f05b01 (cpufreq: intel_pstate: Generic governors support)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
As mentioned in the changelog, the frequencies propagated to the
caller of intel_cpufreq_fast_switch() and to cpufreq_freq_transition_end()
should reflect the P-state that was set and not the requested
frequency (which may be different due to the global limits, rounding
etc).

---
 drivers/cpufreq/intel_pstate.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1879,13 +1879,11 @@ static int intel_pstate_prepare_request(
 
 	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
 	pstate = clamp_t(int, pstate, min_perf, max_perf);
-	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
 	return pstate;
 }
 
 static void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
 {
-	pstate = intel_pstate_prepare_request(cpu, pstate);
 	if (pstate == cpu->pstate.current_pstate)
 		return;
 
@@ -1905,6 +1903,8 @@ static inline void intel_pstate_adjust_b
 
 	update_turbo_state();
 
+	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
 	intel_pstate_update_pstate(cpu, target_pstate);
 
 	sample = &cpu->sample;
@@ -2365,6 +2365,7 @@ static int intel_cpufreq_target(struct c
 		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
 			      pstate_funcs.get_val(cpu, target_pstate));
 	}
+	freqs.new = target_pstate * cpu->pstate.scaling;
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -2378,8 +2379,9 @@ static unsigned int intel_cpufreq_fast_s
 
 	target_freq = intel_cpufreq_turbo_update(cpu, policy, target_freq);
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	intel_pstate_update_pstate(cpu, target_pstate);
-	return target_freq;
+	return target_pstate * cpu->pstate.scaling;
 }
 
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
