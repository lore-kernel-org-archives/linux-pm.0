From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] intel_pstate: delete scheduler hook in HWP mode
Date: Wed,  7 Jun 2017 19:39:16 -0700
Message-ID: <8554c677900ad6bcb308f4afe1099aead3cfebd3.1496889051.git.len.brown@intel.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33596 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdFHCj2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 22:39:28 -0400
In-Reply-To: <1496889556-17923-1-git-send-email-lenb@kernel.org>
In-Reply-To: <f9250362b5eb66bc34402c1fd175f9db7a841532.1496889051.git.len.brown@intel.com>
References: <f9250362b5eb66bc34402c1fd175f9db7a841532.1496889051.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, srinivas.pandruvada@linux.intel.com, hpa@linux.intel.com, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The cpufreqa/scaling_cur_freq sysfs attribute is now provided by
the x86 cpufreq core on all modern x86 systems, including
all systems supported by the intel_pstate driver.

In HWP mode, maintaining that value was the sole purpose of
the scheduler hook, intel_pstate_update_util_hwp(),
so it can now be removed.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0ff3a4b..718732b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1726,16 +1726,6 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu, int target_pstate)
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
@@ -1920,6 +1910,9 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
+	if (hwp_active)
+		return;
+
 	if (cpu->update_util_set)
 		return;
 
@@ -2543,7 +2536,6 @@ static int __init intel_pstate_init(void)
 		} else {
 			hwp_active++;
 			intel_pstate.attr = hwp_cpufreq_attrs;
-			pstate_funcs.update_util = intel_pstate_update_util_hwp;
 			goto hwp_cpu_matched;
 		}
 	} else {
-- 
2.7.4
