From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Shorten a couple of long names
Date: Fri, 04 Aug 2017 15:04:27 +0200
Message-ID: <1888936.gKHfBDW9jH@aspire.rjw.lan>
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

The names of the INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL symbol and
the get_target_pstate_use_cpu_load() function don't need to be so
long any more, so make them shorter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -37,7 +37,7 @@
 #include <asm/cpufeature.h>
 #include <asm/intel-family.h>
 
-#define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
+#define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
 #define INTEL_CPUFREQ_TRANSITION_DELAY		500
@@ -1438,7 +1438,7 @@ static inline int32_t get_avg_pstate(str
 			  cpu->sample.core_avg_perf);
 }
 
-static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
+static inline int32_t get_target_pstate(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
 	int32_t busy_frac, boost;
@@ -1503,7 +1503,7 @@ static void intel_pstate_adjust_pstate(s
 
 	update_turbo_state();
 
-	target_pstate = get_target_pstate_use_cpu_load(cpu);
+	target_pstate = get_target_pstate(cpu);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
 	intel_pstate_update_pstate(cpu, target_pstate);
@@ -1540,7 +1540,7 @@ static void intel_pstate_update_util(str
 	}
 	cpu->last_update = time;
 	delta_ns = time - cpu->sample.time;
-	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
+	if ((s64)delta_ns < INTEL_PSTATE_SAMPLING_INTERVAL)
 		return;
 
 	if (intel_pstate_sample(cpu, time))
