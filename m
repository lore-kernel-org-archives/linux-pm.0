From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/12] cpufreq: Fix governor races - part 2
Date: Mon, 15 Jun 2015 10:19:08 +0530
Message-ID: <557E5944.6060805@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:38353 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbFOEtR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 00:49:17 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 00:49:16 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7B44238C8041
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 00:49:14 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F4nEuF49938642
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:49:14 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F4nCWU018272
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 00:49:14 -0400
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Hi,
> 
> This is a next step of the earlier work I have posted [1].
> 
> The first 5 patches are minor cleanups, 6th & 7th try to optimize few
> things to make code less complex.
> 
> Patches 8-11 actually solve (or try to solve :)) the synchronization
> problems, or the crashes I was getting.
> 
> And the last one again optimizes code a bit.
> 
> I don't get the crashes anymore and want others to try. At least Preeti
> and Ke Wang (Sorry if I haven't spelled it properly :( ), as you two
> have reported the issues to me.
> 
> This patchset should be rebased over the earlier one [1].
> 
> To make things simple, all these patches are pushed here [2] and are
> rebased over pm/bleeeding-edge because of some recent important changes
> there:
> 
> 
> [1] http://marc.info/?i=cover.1433326032.git.viresh.kumar%40linaro.org
> [2] ssh://git@git.linaro.org/people/viresh.kumar/linux.git cpufreq/gov-locking

I ran the kernel compiled from the above ^^ branch.
I get data access exception with the following backtrace:

[   67.834689] Unable to handle kernel paging request for data at address 0x00000008
[   67.834800] Faulting instruction address: 0xc000000000859708
cpu 0x0: Vector: 300 (Data Access) at [c00000000382b4b0]
    pc: c000000000859708: dbs_cpufreq_notifier+0x68/0xe0
    lr: c000000000100dec: notifier_call_chain+0xbc/0x120
    sp: c00000000382b730
   msr: 9000000100009033
   dar: 8
 dsisr: 40000000
  current = 0xc0000000038876c0
  paca    = 0xc000000007da0000	 softe: 0	 irq_happened: 0x01
    pid   = 737, comm = kworker/0:2
enter ? for help
[c00000000382b780] c000000000100dec notifier_call_chain+0xbc/0x120
[c00000000382b7d0] c000000000101638 __srcu_notifier_call_chain+0xa8/0x110
[c00000000382b830] c000000000850844 cpufreq_notify_transition+0x1a4/0x540
[c00000000382b920] c000000000850d1c cpufreq_freq_transition_begin+0x13c/0x180
[c00000000382b9b0] c000000000851958 __cpufreq_driver_target+0x2b8/0x4a0
[c00000000382ba70] c0000000008578b0 od_check_cpu+0x120/0x140
[c00000000382baa0] c00000000085ac7c dbs_check_cpu+0x25c/0x310
[c00000000382bb50] c0000000008580f0 od_dbs_timer+0x120/0x190
[c00000000382bb90] c00000000085b2c0 dbs_timer+0xf0/0x150
[c00000000382bbe0] c0000000000f489c process_one_work+0x24c/0x910
[c00000000382bc90] c0000000000f50dc worker_thread+0x17c/0x540
[c00000000382bd20] c0000000000fed70 kthread+0x120/0x140
[c00000000382be30] c000000000009678 ret_from_kernel_thread+0x5c/0x64



I also get the following lockdep warning just before hitting the above panic.

[   64.414664] 
[   64.414724] ======================================================
[   64.414810] [ INFO: possible circular locking dependency detected ]
[   64.414883] 4.1.0-rc7-00513-g3af78d9 #44 Not tainted
[   64.414934] -------------------------------------------------------
[   64.414998] ppc64_cpu/3378 is trying to acquire lock:
[   64.415049]  ((&(&j_cdbs->dwork)->work)){+.+...}, at: [<c0000000000f5848>] flush_work+0x8/0x350
[   64.415172] 
[   64.415172] but task is already holding lock:
[   64.415236]  (od_dbs_cdata.mutex){+.+.+.}, at: [<c00000000085b3a0>] cpufreq_governor_dbs+0x80/0x940
[   64.415366] 
[   64.415366] which lock already depends on the new lock.
[   64.415366] 
[   64.415443] 
[   64.415443] the existing dependency chain (in reverse order) is:
[   64.415518] 
-> #1 (od_dbs_cdata.mutex){+.+.+.}:
[   64.415608]        [<c0000000001489c8>] lock_acquire+0xf8/0x340
[   64.415674]        [<c000000000a6dc28>] mutex_lock_nested+0xb8/0x5b0
[   64.415752]        [<c00000000085b220>] dbs_timer+0x50/0x150
[   64.415824]        [<c0000000000f489c>] process_one_work+0x24c/0x910
[   64.415909]        [<c0000000000f50dc>] worker_thread+0x17c/0x540
[   64.415981]        [<c0000000000fed70>] kthread+0x120/0x140
[   64.416052]        [<c000000000009678>] ret_from_kernel_thread+0x5c/0x64
[   64.416139] 
-> #0 ((&(&j_cdbs->dwork)->work)){+.+...}:
[   64.416240]        [<c000000000147764>] __lock_acquire+0x1114/0x1990
[   64.416321]        [<c0000000001489c8>] lock_acquire+0xf8/0x340
[   64.416385]        [<c0000000000f58a8>] flush_work+0x68/0x350
[   64.416453]        [<c0000000000f5c74>] __cancel_work_timer+0xe4/0x270
[   64.416530]        [<c00000000085b8d0>] cpufreq_governor_dbs+0x5b0/0x940
[   64.416605]        [<c000000000857e3c>] od_cpufreq_governor_dbs+0x3c/0x60
[   64.416684]        [<c000000000852b04>] __cpufreq_governor+0xe4/0x320
[   64.416762]        [<c000000000855bb8>] __cpufreq_remove_dev_prepare.isra.22+0x78/0x340
[   64.416851]        [<c000000000855f44>] cpufreq_cpu_callback+0xc4/0xe0
[   64.416928]        [<c000000000100dec>] notifier_call_chain+0xbc/0x120
[   64.417005]        [<c00000000025a3bc>] _cpu_down+0xec/0x440
[   64.417072]        [<c00000000025a76c>] cpu_down+0x5c/0xa0
[   64.417137]        [<c00000000064f52c>] cpu_subsys_offline+0x2c/0x50
[   64.417214]        [<c000000000646de4>] device_offline+0x114/0x150
[   64.417291]        [<c000000000646fac>] online_store+0x6c/0xc0
[   64.417355]        [<c000000000642cc8>] dev_attr_store+0x68/0xa0
[   64.417421]        [<c0000000003bfd44>] sysfs_kf_write+0x94/0xc0
[   64.417488]        [<c0000000003be94c>] kernfs_fop_write+0x18c/0x1f0
[   64.417564]        [<c000000000304dfc>] __vfs_write+0x6c/0x190
[   64.417630]        [<c000000000305b10>] vfs_write+0xc0/0x200
[   64.417694]        [<c000000000306b0c>] SyS_write+0x6c/0x110
[   64.417759]        [<c000000000009364>] system_call+0x38/0xd0
[   64.417823] 
[   64.417823] other info that might help us debug this:
[   64.417823] 
[   64.417901]  Possible unsafe locking scenario:
[   64.417901] 
[   64.417965]        CPU0                    CPU1
[   64.418015]        ----                    ----
[   64.418065]   lock(od_dbs_cdata.mutex);
[   64.418129]                                lock((&(&j_cdbs->dwork)->work));
[   64.418217]                                lock(od_dbs_cdata.mutex);
[   64.418304]   lock((&(&j_cdbs->dwork)->work));
[   64.418368] 
[   64.418368]  *** DEADLOCK ***
[   64.418368] 
[   64.418432] 9 locks held by ppc64_cpu/3378:
[   64.418471]  #0:  (sb_writers#3){.+.+.+}, at: [<c000000000305c20>] vfs_write+0x1d0/0x200
[   64.418600]  #1:  (&of->mutex){+.+.+.}, at: [<c0000000003be83c>] kernfs_fop_write+0x7c/0x1f0
[   64.418728]  #2:  (s_active#54){.+.+.+}, at: [<c0000000003be848>] kernfs_fop_write+0x88/0x1f0
[   64.418868]  #3:  (device_hotplug_lock){+.+...}, at: [<c0000000006452e8>] lock_device_hotplug_sysfs+0x28/0x90
[   64.419009]  #4:  (&dev->mutex){......}, at: [<c000000000646d60>] device_offline+0x90/0x150
[   64.419124]  #5:  (cpu_add_remove_lock){+.+.+.}, at: [<c00000000025a74c>] cpu_down+0x3c/0xa0
[   64.419252]  #6:  (cpu_hotplug.lock){++++++}, at: [<c0000000000cb458>] cpu_hotplug_begin+0x8/0x110
[   64.419382]  #7:  (cpu_hotplug.lock#2){+.+.+.}, at: [<c0000000000cb4f0>] cpu_hotplug_begin+0xa0/0x110
[   64.419522]  #8:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c00000000085b3a0>] cpufreq_governor_dbs+0x80/0x940
[   64.419662] 
[   64.419662] stack backtrace:
[   64.419716] CPU: 125 PID: 3378 Comm: ppc64_cpu Not tainted 4.1.0-rc7-00513-g3af78d9 #44
[   64.419795] Call Trace:
[   64.419824] [c000000fbe7832e0] [c000000000a80fe8] dump_stack+0xa0/0xdc (unreliable)
[   64.419913] [c000000fbe783310] [c000000000a7b2e8] print_circular_bug+0x354/0x388
[   64.420003] [c000000fbe7833b0] [c000000000145480] check_prev_add+0x8c0/0x8d0
[   64.420080] [c000000fbe7834b0] [c000000000147764] __lock_acquire+0x1114/0x1990
[   64.420169] [c000000fbe7835d0] [c0000000001489c8] lock_acquire+0xf8/0x340
[   64.420245] [c000000fbe783690] [c0000000000f58a8] flush_work+0x68/0x350
[   64.420321] [c000000fbe783780] [c0000000000f5c74] __cancel_work_timer+0xe4/0x270
[   64.420410] [c000000fbe783810] [c00000000085b8d0] cpufreq_governor_dbs+0x5b0/0x940
[   64.420499] [c000000fbe7838b0] [c000000000857e3c] od_cpufreq_governor_dbs+0x3c/0x60
[   64.420588] [c000000fbe7838f0] [c000000000852b04] __cpufreq_governor+0xe4/0x320
[   64.420678] [c000000fbe783970] [c000000000855bb8] __cpufreq_remove_dev_prepare.isra.22+0x78/0x340
[   64.420780] [c000000fbe7839f0] [c000000000855f44] cpufreq_cpu_callback+0xc4/0xe0
[   64.420869] [c000000fbe783a20] [c000000000100dec] notifier_call_chain+0xbc/0x120
[   64.420957] [c000000fbe783a70] [c00000000025a3bc] _cpu_down+0xec/0x440
[   64.421034] [c000000fbe783b30] [c00000000025a76c] cpu_down+0x5c/0xa0
[   64.421110] [c000000fbe783b60] [c00000000064f52c] cpu_subsys_offline+0x2c/0x50
[   64.421199] [c000000fbe783b90] [c000000000646de4] device_offline+0x114/0x150
[   64.421275] [c000000fbe783bd0] [c000000000646fac] online_store+0x6c/0xc0
[   64.421352] [c000000fbe783c20] [c000000000642cc8] dev_attr_store+0x68/0xa0
[   64.421428] [c000000fbe783c60] [c0000000003bfd44] sysfs_kf_write+0x94/0xc0
[   64.421504] [c000000fbe783ca0] [c0000000003be94c] kernfs_fop_write+0x18c/0x1f0
[   64.421594] [c000000fbe783cf0] [c000000000304dfc] __vfs_write+0x6c/0x190
[   64.421670] [c000000fbe783d90] [c000000000305b10] vfs_write+0xc0/0x200
[   64.421747] [c000000fbe783de0] [c000000000306b0c] SyS_write+0x6c/0x110

ppc64_cpu is the utility used to perform cpu hotplug.

Regards
Preeti U Murthy
> 
> --
> viresh
> 
> Viresh Kumar (12):
>   cpufreq: governor: Name delayed-work as dwork
>   cpufreq: governor: Drop unused field 'cpu'
>   cpufreq: governor: Rename 'cpu_dbs_common_info' to 'cpu_dbs_info'
>   cpufreq: governor: name pointer to cpu_dbs_info as 'cdbs'
>   cpufreq: governor: rename cur_policy as policy
>   cpufreq: governor: Keep single copy of information common to
>     policy->cpus
>   cpufreq: governor: split out common part of {cs|od}_dbs_timer()
>   cpufreq: governor: synchronize work-handler with governor callbacks
>   cpufreq: governor: Avoid invalid states with additional checks
>   cpufreq: governor: Don't WARN on invalid states
>   cpufreq: propagate errors returned from __cpufreq_governor()
>   cpufreq: conservative: remove 'enable' field
> 
>  drivers/cpufreq/cpufreq.c              |  22 ++--
>  drivers/cpufreq/cpufreq_conservative.c |  35 ++----
>  drivers/cpufreq/cpufreq_governor.c     | 200 +++++++++++++++++++++++----------
>  drivers/cpufreq/cpufreq_governor.h     |  36 +++---
>  drivers/cpufreq/cpufreq_ondemand.c     |  68 +++++------
>  5 files changed, 214 insertions(+), 147 deletions(-)
> 

