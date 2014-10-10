From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 09:55:11 -0400
Message-ID: <5437E53F.2000209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbaJJNzY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Oct 2014 09:55:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Robert_Sch=F6ne?= <robert.schoene@tu-dresden.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>


My test is similar to Robert's.  With 3.17 + Viresh's 3 v2 patches,

#!/bin/bash

i=0
while [ True ]; do
	i=$((i+1))
	echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
	echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
	echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
	echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
	if [ $((i % 100)) = 0 ]; then
		echo $i
	fi
done

and I get...

BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffff81577052>] cpufreq_governor_dbs+0x52/0x820
PGD ff5aff067 PUD ff8546067 PMD 0
Oops: 0000 [#1] SMP
Modules linked in: sg nfsv3 rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache
cfg80211 rfkill x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm igb
iTCO_wdt iTCO_vendor_support crct10dif_pclmul crc32_pclmul ptp crc32c_intel
ioatdma pps_core ghash_clmulni_intel aesni_intel dca lrw gf128mul glue_helper
ablk_helper cryptd pcspkr sb_edac edac_core shpchp i2c_i801 lpc_ich mfd_core wmi
ipmi_si ipmi_msghandler nfsd acpi_cpufreq auth_rpcgss nfs_acl lockd grace sunrpc
xfs libcrc32c sd_mod sr_mod crc_t10dif cdrom crct10dif_common mgag200
syscopyarea sysfillrect sysimgblt i2c_algo_bit drm_kms_helper ttm isci drm
libsas ahci libahci scsi_transport_sas libata i2c_core dm_mirror dm_region_hash
dm_log dm_mod
CPU: 39 PID: 8576 Comm: doit Tainted: G        W      3.17.0+ #2
Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
RMLSDP.86I.00.29.D696.1311111329 11/11/2013
task: ffff880ff3920000 ti: ffff880ff4190000 task.ti: ffff880ff4190000
RIP: 0010:[<ffffffff81577052>]  [<ffffffff81577052>] cpufreq_governor_dbs+0x52/0x820
RSP: 0018:ffff880ff4193a70  EFLAGS: 00010297
RAX: 0000000000000024 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000009
RBP: ffff880ff4193ae0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff880ff4193716 R12: ffff880fff62b800
R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff81bd3b80
FS:  00007fd0291ee740(0000) GS:ffff881012400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000ff3cdd000 CR4: 00000000001407e0
Stack:
 ffffffff81570c27 00000000fffffffe 0000000000000046 ffffffff81bd3340
 0000000000000001 0000000000000246 ffffffff81bd3348 ffffffff810e1a1d
 ffff880ff4193ae0 ffff880fff62b800 0000000000000001 ffffffff81bd3500
Call Trace:
 [<ffffffff81570c27>] ? __cpufreq_governor+0x57/0x230
 [<ffffffff810e1a1d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffff81574f27>] od_cpufreq_governor_dbs+0x17/0x20
 [<ffffffff81570c62>] __cpufreq_governor+0x92/0x230
 [<ffffffff81570fd8>] cpufreq_set_policy+0x1d8/0x2b0
 [<ffffffff8157181d>] store_scaling_governor+0xad/0xf0
 [<ffffffff81572860>] ? cpufreq_update_policy+0x1f0/0x1f0
 [<ffffffff815709a0>] ? store+0x70/0xd0
 [<ffffffff81572303>] ? cpufreq_freq_transition_begin+0xb3/0x140
 [<ffffffff810d4953>] ? __wake_up+0x23/0x50
 [<ffffffff815709bb>] store+0x8b/0xd0
 [<ffffffff812c9174>] sysfs_kf_write+0x44/0x60
 [<ffffffff812c8a67>] kernfs_fop_write+0xe7/0x170
 [<ffffffff8124239a>] vfs_write+0xba/0x1f0
 [<ffffffff81242fe8>] SyS_write+0x58/0xd0
 [<ffffffff81731769>] system_call_fastpath+0x16/0x1b
Code: ff 84 c0 0f 84 50 02 00 00 49 8b 5c 24 58 48 85 db 0f 84 59 07 00 00 41 83
fe 04 0f 84 70 02 00 00 41 83 fe 05 0f 84 3e 02 00 00 <48> 8b 03 44 89 ef ff 50
20 48 89 45 c0 48 8b 03 83 38 01 0f 84
RIP  [<ffffffff81577052>] cpufreq_governor_dbs+0x52/0x820
 RSP <ffff880ff4193a70>
CR2: 0000000000000000
---[ end trace 2d1b939e62867d1f ]---

This occurs at boot on my system, during systemd setup.  This *does not* happen
with plain upstream kernel.

Robert, OOC ... what happens when you patch in (sorry for the cut-and-paste)
the following? [warning: complete and total hack.  This "breaks" arm, but the
original patch that introduced this change broke x86]

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 24bf76f..94ac441 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2195,9 +2195,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *polic
        /* end old governor */
        if (old_gov) {
                __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-               up_write(&policy->rwsem);
                __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-               down_write(&policy->rwsem);
        }

        /* start new governor */
@@ -2206,9 +2204,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *polic
                if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
                        goto out;

-               up_write(&policy->rwsem);
                __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-               down_write(&policy->rwsem);
        }

P.
