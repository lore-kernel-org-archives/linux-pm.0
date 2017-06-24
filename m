From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] intel_pstate: delete scheduler hook in HWP mode
Date: Fri, 23 Jun 2017 22:11:53 -0700
Message-ID: <43ecf292a796eaa86bf112eebdc066e46db15c39.1498280509.git.len.brown@intel.com>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498281114-3868-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
References: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The cpufreq/scaling_cur_freq sysfs attribute is now provided by
shared x86 cpufreq code on modern x86 systems, including
all systems supported by the intel_pstate driver.

In HWP mode, maintaining that value was the sole purpose of
the scheduler hook, intel_pstate_update_util_hwp(),
so it can now be removed.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b7de5bd..4ec5668 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1732,16 +1732,6 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu, int target_pstate)
 		fp_toint(cpu->iowait_boost * 100));
 }
 
-static void intel_pstate_update_util_hwp(struct update_util_data *data,
-					 u64 time, unsigned int flags)
-{
-	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
-	u64 delta_ns = time - cpu->sample.time;
-
-	if ((s64)delta_ns >= INTEL_PSTATE_HWP_SAMPLING_INTERVAL)
-		intel_pstate_sample(cpu, time);
-}
-
 static void intel_pstate_update_util_pid(struct update_util_data *data,
 					 u64 time, unsigned int flags)
 {
@@ -1933,6 +1923,9 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
+	if (hwp_active)
+		return;
+
 	if (cpu->update_util_set)
 		return;
 
@@ -2557,7 +2550,6 @@ static int __init intel_pstate_init(void)
 		} else {
 			hwp_active++;
 			intel_pstate.attr = hwp_cpufreq_attrs;
-			pstate_funcs.update_util = intel_pstate_update_util_hwp;
 			goto hwp_cpu_matched;
 		}
 	} else {
-- 
2.7.4
