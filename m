From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Fix global settings in active mode
Date: Tue, 28 Feb 2017 14:14:32 +0100
Message-ID: <15204258.A1E69B1e9T@aspire.rjw.lan>
References: <2694426.SgxlQuL17D@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2694426.SgxlQuL17D@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 111b8b3fe4fa (cpufreq: intel_pstate: Always keep all
limits settings in sync) changed intel_pstate to invoke
cpufreq_update_policy() for every registered CPU on global sysfs
attributes updates, but that led to undesirable effects in the
active mode if the "performance" P-state selection algorithm is
configufred for one CPU and the "powersave" one is chosen for
all of the other CPUs.

Namely, in that case, the following is possible:

 # cd /sys/devices/system/cpu/
 # cat intel_pstate/max_perf_pct
 100
 # cat intel_pstate/min_perf_pct
 26
 # echo performance > cpufreq/policy0/scaling_governor
 # cat intel_pstate/max_perf_pct
 100
 # cat intel_pstate/min_perf_pct
 100
 # echo 94 > intel_pstate/min_perf_pct
 # cat intel_pstate/min_perf_pct
 26

The reason why this happens is because intel_pstate attempts to
maintain two sets of global limits in the active mode, one for
the "performance" P-state selection algorithm and one for the
"powersave"  P-state selection algorithm, but the P-state selection
algorithms are set per policy, so the global limits cannot reflect
all of them at the same time if they are different for different
policies.

In the particular situation above, the attempt to change
min_perf_pct to 94 caused cpufreq_update_policy() to be run
for a CPU with the "powersave"  P-state selection algorithm
and intel_pstate_set_policy() called by it silently switched the
global limits to the "powersave" set which finally was reflected
by the sysfs interface.

To prevent that from happening, modify intel_pstate_update_policies()
to always switch back to the set of limits that was used right before
it has been invoked.

Fixes: 111b8b3fe4fa (cpufreq: intel_pstate: Always keep all limits settings in sync)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -974,10 +974,13 @@ static int intel_pstate_resume(struct cp
 
 static void intel_pstate_update_policies(void)
 {
+	struct perf_limits *last_limits = limits;
 	int cpu;
 
 	for_each_possible_cpu(cpu)
 		cpufreq_update_policy(cpu);
+
+	limits = last_limits;
 }
 
 /************************** debugfs begin ************************/
