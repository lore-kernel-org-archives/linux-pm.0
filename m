From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/3] cpufreq: intel_pstate: Fix global settings in active mode
Date: Wed, 01 Mar 2017 00:07:36 +0100
Message-ID: <2483232.iIe76OATof@aspire.rjw.lan>
References: <2694426.SgxlQuL17D@aspire.rjw.lan> <2326598.n0dkg1GrdM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2326598.n0dkg1GrdM@aspire.rjw.lan>
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

-> v2:
Save and restore the limits value in intel_pstate_update_policies() under
intel_pstate_limits_lock or otherwise (a) it may change in the middle of an
update from a concurrent thread and (b) it may not point to the set of
limits that has just been updated any more when read outside of the lock.

---
 drivers/cpufreq/intel_pstate.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -973,11 +973,20 @@ static int intel_pstate_resume(struct cp
 }
 
 static void intel_pstate_update_policies(void)
+	__releases(&intel_pstate_limits_lock)
+	__acquires(&intel_pstate_limits_lock)
 {
+	struct perf_limits *saved_limits = limits;
 	int cpu;
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	for_each_possible_cpu(cpu)
 		cpufreq_update_policy(cpu);
+
+	mutex_lock(&intel_pstate_limits_lock);
+
+	limits = saved_limits;
 }
 
 /************************** debugfs begin ************************/
@@ -1185,10 +1194,10 @@ static ssize_t store_no_turbo(struct kob
 
 	limits->no_turbo = clamp_t(int, input, 0, 1);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	intel_pstate_update_policies();
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1222,10 +1231,10 @@ static ssize_t store_max_perf_pct(struct
 				   limits->max_perf_pct);
 	limits->max_perf = div_ext_fp(limits->max_perf_pct, 100);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	intel_pstate_update_policies();
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1259,10 +1268,10 @@ static ssize_t store_min_perf_pct(struct
 				   limits->min_perf_pct);
 	limits->min_perf = div_ext_fp(limits->min_perf_pct, 100);
 
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	intel_pstate_update_policies();
 
+	mutex_unlock(&intel_pstate_limits_lock);
+
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
