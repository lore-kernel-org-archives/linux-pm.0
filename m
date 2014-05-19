From: Bibek Basu <bbasu@nvidia.com>
Subject: [PATCH] cpufreq: remove race while accessing cur_policy
Date: Mon, 19 May 2014 10:24:01 +0530
Message-ID: <1400475241-21174-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7498 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaESEyq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 00:54:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Bibek Basu <bbasu@nvidia.com>

While accessing cur_policy during executing events
CPUFREQ_GOV_START, CPUFREQ_GOV_STOP, CPUFREQ_GOV_LIMITS,
same mutex lock is not taken, dbs_data->mutex, which leads
to race and data corruption while running continious suspend
resume test. This is seen with ondemand governor with suspend
resume test using rtcwake.

[ 367.405875] Unable to handle kernel NULL pointer dereference at virtual address 00000028
[ 367.427534] pgd = ed610000
[ 367.427545] [00000028] *pgd=adf11831, *pte=00000000, *ppte=00000000
[ 367.427555] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[ 367.427564] Modules linked in: nvhost_vi
[ 367.427573] CPU: 1 PID: 3243 Comm: rtcwake Not tainted 3.10.24-gf5cf9e5 #1
[ 367.427578] task: ee708040 ti: ed61c000 task.ti: ed61c000
[ 367.427589] PC is at cpufreq_governor_dbs+0x400/0x634
[ 367.427594] LR is at cpufreq_governor_dbs+0x3f8/0x634
[ 367.427600] pc : [<c05652b8>] lr : [<c05652b0>] psr: 600f0013
[ 367.427600] sp : ed61dcb0 ip : 000493e0 fp : c1cc14f0
[ 367.427604] r10: 00000000 r9 : 00000000 r8 : 00000000
[ 367.427608] r7 : eb725280 r6 : c1cc1560 r5 : eb575200 r4 : ebad7740
[ 367.427612] r3 : ee708040 r2 : ed61dca8 r1 : 001ebd24 r0 : 00000000
[ 367.427618] Flags: nZCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment user
[ 367.427622] Control: 10c5387d Table: ad61006a DAC: 00000015
[ 367.429201] [<c05652b8>] (cpufreq_governor_dbs+0x400/0x634) from [<c055f700>] (__cpufreq_governor+0x98/0x1b4)
[ 367.429216] [<c055f700>] (__cpufreq_governor+0x98/0x1b4) from [<c0560770>] (__cpufreq_set_policy+0x250/0x320)
[ 367.429226] [<c0560770>] (__cpufreq_set_policy+0x250/0x320) from [<c0561dcc>] (cpufreq_update_policy+0xcc/0x168)
[ 367.429235] [<c0561dcc>] (cpufreq_update_policy+0xcc/0x168) from [<c0561ed0>] (cpu_freq_notify+0x68/0xdc)
[ 367.429253] [<c0561ed0>] (cpu_freq_notify+0x68/0xdc) from [<c008eff8>] (notifier_call_chain+0x4c/0x8c)
[ 367.429270] [<c008eff8>] (notifier_call_chain+0x4c/0x8c) from [<c008f3d4>] (__blocking_notifier_call_chain+0x50/0x68)
[ 367.429283] [<c008f3d4>] (__blocking_notifier_call_chain+0x50/0x68) from [<c008f40c>] (blocking_notifier_call_chain+0x20/0x28)
[ 367.429301] [<c008f40c>] (blocking_notifier_call_chain+0x20/0x28) from [<c00aac6c>] (pm_qos_update_bounded_target+0xd8/0x310)
[ 367.429314] [<c00aac6c>] (pm_qos_update_bounded_target+0xd8/0x310) from [<c00ab3b0>] (__pm_qos_update_request+0x64/0x70)
[ 367.429328] [<c00ab3b0>] (__pm_qos_update_request+0x64/0x70) from [<c004b4b8>] (tegra_pm_notify+0x114/0x134)
[ 367.429342] [<c004b4b8>] (tegra_pm_notify+0x114/0x134) from [<c008eff8>] (notifier_call_chain+0x4c/0x8c)
[ 367.429355] [<c008eff8>] (notifier_call_chain+0x4c/0x8c) from [<c008f3d4>] (__blocking_notifier_call_chain+0x50/0x68)
[ 367.429366] [<c008f3d4>] (__blocking_notifier_call_chain+0x50/0x68) from [<c008f40c>] (blocking_notifier_call_chain+0x20/0x28)
[ 367.429376] [<c008f40c>] (blocking_notifier_call_chain+0x20/0x28) from [<c00ac228>] (pm_notifier_call_chain+0x1c/0x34)
[ 367.429389] [<c00ac228>] (pm_notifier_call_chain+0x1c/0x34) from [<c00ad38c>] (enter_state+0xec/0x128)
[ 367.429399] [<c00ad38c>] (enter_state+0xec/0x128) from [<c00ad400>] (pm_suspend+0x38/0xa4)
[ 367.429407] [<c00ad400>] (pm_suspend+0x38/0xa4) from [<c00ac114>] (state_store+0x70/0xc0)
[ 367.429423] [<c00ac114>] (state_store+0x70/0xc0) from [<c027b1e8>] (kobj_attr_store+0x14/0x20)
[ 367.429443] [<c027b1e8>] (kobj_attr_store+0x14/0x20) from [<c019cd9c>] (sysfs_write_file+0x104/0x184)
[ 367.429460] [<c019cd9c>] (sysfs_write_file+0x104/0x184) from [<c0143038>] (vfs_write+0xd0/0x19c)
[ 367.429472] [<c0143038>] (vfs_write+0xd0/0x19c) from [<c0143414>] (SyS_write+0x4c/0x78)
[ 367.429485] [<c0143414>] (SyS_write+0x4c/0x78) from [<c000f080>] (ret_fast_syscall+0x0/0x30)
[ 367.429495] Code: e1a00006 eb084346 e59b0020 e5951024 (e5903028)
[ 367.429533] ---[ end trace 0488523c8f6b0f9d ]---

Signed-off-by: Bibek Basu <bbasu@nvidia.com>
---
 drivers/cpufreq/cpufreq_governor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ba43991..e1c6433 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -366,6 +366,11 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
+		mutex_lock(&dbs_data->mutex);
+		if (!cpu_cdbs->cur_policy) {
+			mutex_unlock(&dbs_data->mutex);
+			break;
+		}
 		mutex_lock(&cpu_cdbs->timer_mutex);
 		if (policy->max < cpu_cdbs->cur_policy->cur)
 			__cpufreq_driver_target(cpu_cdbs->cur_policy,
@@ -375,6 +380,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 					policy->min, CPUFREQ_RELATION_L);
 		dbs_check_cpu(dbs_data, cpu);
 		mutex_unlock(&cpu_cdbs->timer_mutex);
+		mutex_unlock(&dbs_data->mutex);
 		break;
 	}
 	return 0;
-- 
1.8.1.5


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
