From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Simplify intel_pstate_adjust_pstate()
Date: Fri, 04 Aug 2017 15:02:26 +0200
Message-ID: <2178001.LRlMC5TT3K@aspire.rjw.lan>
References: <1540190.Qr1f2614Kx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540190.Qr1f2614Kx@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since there is only one P-state selection routine in intel_pstate
now, make intel_pstate_adjust_pstate() call it directly and drop
the target_pstate argument from that function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1495,13 +1495,15 @@ static void intel_pstate_update_pstate(s
 	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
 }
 
-static void intel_pstate_adjust_pstate(struct cpudata *cpu, int target_pstate)
+static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 {
 	int from = cpu->pstate.current_pstate;
 	struct sample *sample;
+	int target_pstate;
 
 	update_turbo_state();
 
+	target_pstate = get_target_pstate_use_cpu_load(cpu);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
 	intel_pstate_update_pstate(cpu, target_pstate);
@@ -1541,12 +1543,8 @@ static void intel_pstate_update_util(str
 	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
 		return;
 
-	if (intel_pstate_sample(cpu, time)) {
-		int target_pstate;
-
-		target_pstate = get_target_pstate_use_cpu_load(cpu);
-		intel_pstate_adjust_pstate(cpu, target_pstate);
-	}
+	if (intel_pstate_sample(cpu, time))
+		intel_pstate_adjust_pstate(cpu);
 }
 
 static struct pstate_funcs core_funcs = {
