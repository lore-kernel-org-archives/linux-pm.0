From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix unsafe HWP MSR access
Date: Sat,  8 Oct 2016 12:42:38 -0700
Message-ID: <1475955758-109131-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28315 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbcJHTmp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Oct 2016 15:42:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, stable@vger.kernel.org#v4.3+

This is a requirement that MSR MSR_PM_ENABLE must be set to 0x01 before
reading MSR_HWP_CAPABILITIES on a given CPU. If cpufreq init() is
scheduled on a CPU which is not same as policy->cpu or migrates to a
different CPU before calling msr read for MSR_HWP_CAPABILITIES, it
is possible that MSR_PM_ENABLE was not to set to 0x01 on that CPU.
This will cause GP fault. So like other places in this path
rdmsrl_on_cpu should be used instead of rdmsrl.

Moreover the scope of MSR_HWP_CAPABILITIES is on per thread basis, so it
should be read from the same CPU, for which MSR MSR_HWP_REQUEST is
getting set.

dmesg dump or warning:

[   22.014488] WARNING: CPU: 139 PID: 1 at arch/x86/mm/extable.c:50 ex_handler_rdmsr_unsafe+0x68/0x70
[   22.014492] unchecked MSR access error: RDMSR from 0x771
[   22.014493] Modules linked in:
[   22.014507] CPU: 139 PID: 1 Comm: swapper/0 Not tainted 4.7.5+ #1
...
...
[   22.014516] Call Trace:
[   22.014542]  [<ffffffff813d7dd1>] dump_stack+0x63/0x82
[   22.014558]  [<ffffffff8107bc8b>] __warn+0xcb/0xf0
[   22.014561]  [<ffffffff8107bcff>] warn_slowpath_fmt+0x4f/0x60
[   22.014563]  [<ffffffff810676f8>] ex_handler_rdmsr_unsafe+0x68/0x70
[   22.014564]  [<ffffffff810677d9>] fixup_exception+0x39/0x50
[   22.014604]  [<ffffffff8102e400>] do_general_protection+0x80/0x150
[   22.014610]  [<ffffffff817f9ec8>] general_protection+0x28/0x30
[   22.014635]  [<ffffffff81687940>] ? get_target_pstate_use_performance+0xb0/0xb0
[   22.014642]  [<ffffffff810600c7>] ? native_read_msr+0x7/0x40
[   22.014657]  [<ffffffff81688123>] intel_pstate_hwp_set+0x23/0x130
[   22.014660]  [<ffffffff81688406>] intel_pstate_set_policy+0x1b6/0x340
[   22.014662]  [<ffffffff816829bb>] cpufreq_set_policy+0xeb/0x2c0
[   22.014664]  [<ffffffff81682f39>] cpufreq_init_policy+0x79/0xe0
[   22.014666]  [<ffffffff81682cb0>] ? cpufreq_update_policy+0x120/0x120
[   22.014669]  [<ffffffff816833a6>] cpufreq_online+0x406/0x820
[   22.014671]  [<ffffffff8168381f>] cpufreq_add_dev+0x5f/0x90
[   22.014717]  [<ffffffff81530ac8>] subsys_interface_register+0xb8/0x100
[   22.014719]  [<ffffffff816821bc>] cpufreq_register_driver+0x14c/0x210
[   22.014749]  [<ffffffff81fe1d90>] intel_pstate_init+0x39d/0x4d5
[   22.014751]  [<ffffffff81fe13f2>] ? cpufreq_gov_dbs_init+0x12/0x12

Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 806f203..bc976a3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -562,12 +562,12 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
 	u64 value, cap;
 
-	rdmsrl(MSR_HWP_CAPABILITIES, cap);
-	hw_min = HWP_LOWEST_PERF(cap);
-	hw_max = HWP_HIGHEST_PERF(cap);
-	range = hw_max - hw_min;
-
 	for_each_cpu(cpu, cpumask) {
+		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
+		hw_min = HWP_LOWEST_PERF(cap);
+		hw_max = HWP_HIGHEST_PERF(cap);
+		range = hw_max - hw_min;
+
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 		adj_range = limits->min_perf_pct * range / 100;
 		min = hw_min + adj_range;
-- 
2.7.4

