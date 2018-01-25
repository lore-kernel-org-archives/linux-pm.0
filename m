From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: enable HWP before manipulating on corresponding registers
Date: Thu, 25 Jan 2018 19:08:02 +0800
Message-ID: <20180125110802.15141-1-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48709 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbeAYLEm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jan 2018 06:04:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yu Chen <yu.c.chen@intel.com>

The following warning was triggered after resumed from S3 -
if all the nonboot CPUs were put offline before suspend:

[ 1840.329515] unchecked MSR access error: RDMSR from 0x771 at rIP: 0xffffffff86061e3a (native_read_msr+0xa/0x30)
[ 1840.329516] Call Trace:
[ 1840.329521]  __rdmsr_on_cpu+0x33/0x50
[ 1840.329525]  generic_exec_single+0x81/0xb0
[ 1840.329527]  smp_call_function_single+0xd2/0x100
[ 1840.329530]  ? acpi_ds_result_pop+0xdd/0xf2
[ 1840.329532]  ? acpi_ds_create_operand+0x215/0x23c
[ 1840.329534]  rdmsrl_on_cpu+0x57/0x80
[ 1840.329536]  ? cpumask_next+0x1b/0x20
[ 1840.329538]  ? rdmsrl_on_cpu+0x57/0x80
[ 1840.329541]  intel_pstate_update_perf_limits+0xf3/0x220
[ 1840.329544]  ? notifier_call_chain+0x4a/0x70
[ 1840.329546]  intel_pstate_set_policy+0x4e/0x150
[ 1840.329548]  cpufreq_set_policy+0xcd/0x2f0
[ 1840.329550]  cpufreq_update_policy+0xb2/0x130
[ 1840.329552]  ? cpufreq_update_policy+0x130/0x130
[ 1840.329556]  acpi_processor_ppc_has_changed+0x65/0x80
[ 1840.329558]  acpi_processor_notify+0x80/0x100
[ 1840.329561]  acpi_ev_notify_dispatch+0x44/0x5c
[ 1840.329563]  acpi_os_execute_deferred+0x14/0x20
[ 1840.329565]  process_one_work+0x193/0x3c0
[ 1840.329567]  worker_thread+0x35/0x3b0
[ 1840.329569]  kthread+0x125/0x140
[ 1840.329571]  ? process_one_work+0x3c0/0x3c0
[ 1840.329572]  ? kthread_park+0x60/0x60
[ 1840.329575]  ? do_syscall_64+0x67/0x180
[ 1840.329577]  ret_from_fork+0x25/0x30
[ 1840.329585] unchecked MSR access error: WRMSR to 0x774 (tried to write 0x0000000000000000) at rIP: 0xffffffff86061f78 (native_write_msr+0x8/0x30)
[ 1840.329586] Call Trace:
[ 1840.329587]  __wrmsr_on_cpu+0x37/0x40
[ 1840.329589]  generic_exec_single+0x81/0xb0
[ 1840.329592]  smp_call_function_single+0xd2/0x100
[ 1840.329594]  ? acpi_ds_create_operand+0x215/0x23c
[ 1840.329595]  ? cpumask_next+0x1b/0x20
[ 1840.329597]  wrmsrl_on_cpu+0x57/0x70
[ 1840.329598]  ? rdmsrl_on_cpu+0x57/0x80
[ 1840.329599]  ? wrmsrl_on_cpu+0x57/0x70
[ 1840.329602]  intel_pstate_hwp_set+0xd3/0x150
[ 1840.329604]  intel_pstate_set_policy+0x119/0x150
[ 1840.329606]  cpufreq_set_policy+0xcd/0x2f0
[ 1840.329607]  cpufreq_update_policy+0xb2/0x130
[ 1840.329610]  ? cpufreq_update_policy+0x130/0x130
[ 1840.329613]  acpi_processor_ppc_has_changed+0x65/0x80
[ 1840.329615]  acpi_processor_notify+0x80/0x100
[ 1840.329617]  acpi_ev_notify_dispatch+0x44/0x5c
[ 1840.329619]  acpi_os_execute_deferred+0x14/0x20
[ 1840.329620]  process_one_work+0x193/0x3c0
[ 1840.329622]  worker_thread+0x35/0x3b0
[ 1840.329624]  kthread+0x125/0x140
[ 1840.329625]  ? process_one_work+0x3c0/0x3c0
[ 1840.329626]  ? kthread_park+0x60/0x60
[ 1840.329628]  ? do_syscall_64+0x67/0x180
[ 1840.329631]  ret_from_fork+0x25/0x30

This is because if there's only one online CPU, the MSR_PM_ENABLE
(package wide)can not be enabled after resumed, due to
intel_pstate_hwp_enable() will only be invoked on AP's online
process after resumed - if there's no AP online, the HWP remains
disabled after resumed (BIOS has disabled it in S3).

The re-enabling of HWP can not be put into intel_pstate_resume()
as it is too late according to the log above. It is applicable
to do it in syscore_resume() but this requires a new notifier.
Thus forcely enable the HWP before manipulating on them, and this
should not impact much because users seldom touch HWP registers.

Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Yu Chen <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 93a0e88bef76..b808f0127192 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -689,6 +689,8 @@ static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
 {
 	u64 cap;
 
+	/* In case HWP is disabled after resumed from S3. */
+	wrmsrl_on_cpu(cpu, MSR_PM_ENABLE, 0x1);
 	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 	if (global.no_turbo)
 		*current_max = HWP_GUARANTEED_PERF(cap);
@@ -711,6 +713,8 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min = max;
 
+	/* In case HWP is disabled after resumed from S3. */
+	wrmsrl_on_cpu(cpu, MSR_PM_ENABLE, 0x1);
 	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 
 	value &= ~HWP_MIN_PERF(~0L);
-- 
2.13.6
