From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing
 policy->governor_data
Date: Tue, 26 Jan 2016 18:01:19 +0000
Message-ID: <20160126180119.GK10898@e106622-lin>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org>
 <20160126095751.GJ10898@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126095751.GJ10898@e106622-lin>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 26/01/16 09:57, Juri Lelli wrote:
> Hi Viresh,
> 
> On 25/01/16 22:33, Viresh Kumar wrote:
> > There is a little race discovered by Juri, where we are able to:
> > - create and read a sysfs file before policy->governor_data is being set
> >   to a non NULL value.
> >   OR
> > - set policy->governor_data to NULL, and reading a file before being
> >   destroyed.
> > 
> > And so such a crash is reported:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> > pgd = edfc8000
> > [0000000c] *pgd=bfc8c835
> > Internal error: Oops: 17 [#1] SMP ARM
> > Modules linked in:
> > CPU: 4 PID: 1730 Comm: cat Not tainted 4.5.0-rc1+ #463
> > Hardware name: ARM-Versatile Express
> > task: ee8e8480 ti: ee930000 task.ti: ee930000
> > PC is at show_ignore_nice_load_gov_pol+0x24/0x34
> > LR is at show+0x4c/0x60
> > pc : [<c058f1bc>]    lr : [<c058ae88>]    psr: a0070013
> > sp : ee931dd0  ip : ee931de0  fp : ee931ddc
> > r10: ee4bc290  r9 : 00001000  r8 : ef2cb000
> > r7 : ee4bc200  r6 : ef2cb000  r5 : c0af57b0  r4 : ee4bc2e0
> > r3 : 00000000  r2 : 00000000  r1 : c0928df4  r0 : ef2cb000
> > Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: adfc806a  DAC: 00000051
> > Process cat (pid: 1730, stack limit = 0xee930210)
> > Stack: (0xee931dd0 to 0xee932000)
> > 1dc0:                                     ee931dfc ee931de0 c058ae88 c058f1a4
> > 1de0: edce3bc0 c07bfca4 edce3ac0 00001000 ee931e24 ee931e00 c01fcb90 c058ae48
> > 1e00: 00000001 edce3bc0 00000000 00000001 ee931e50 ee8ff480 ee931e34 ee931e28
> > 1e20: c01fb33c c01fcb0c ee931e8c ee931e38 c01a5210 c01fb314 ee931e9c ee931e48
> > 1e40: 00000000 edce3bf0 befe4a00 ee931f78 00000000 00000000 000001e4 00000000
> > 1e60: c00545a8 edce3ac0 00001000 00001000 befe4a00 ee931f78 00000000 00001000
> > 1e80: ee931ed4 ee931e90 c01fbed8 c01a5038 ed085a58 00020000 00000000 00000000
> > 1ea0: c0ad72e4 ee931f78 ee8ff488 ee8ff480 c077f3fc 00001000 befe4a00 ee931f78
> > 1ec0: 00000000 00001000 ee931f44 ee931ed8 c017c328 c01fbdc4 00001000 00000000
> > 1ee0: ee8ff480 00001000 ee931f44 ee931ef8 c017c65c c03deb10 ee931fac ee931f08
> > 1f00: c0009270 c001f290 c0a8d968 ef2cb000 ef2cb000 ee8ff480 00000020 ee8ff480
> > 1f20: ee8ff480 befe4a00 00001000 ee931f78 00000000 00000000 ee931f74 ee931f48
> > 1f40: c017d1ec c017c2f8 c019c724 c019c684 ee8ff480 ee8ff480 00001000 befe4a00
> > 1f60: 00000000 00000000 ee931fa4 ee931f78 c017d2a8 c017d160 00000000 00000000
> > 1f80: 000a9f20 00001000 befe4a00 00000003 c000ffe4 ee930000 00000000 ee931fa8
> > 1fa0: c000fe40 c017d264 000a9f20 00001000 00000003 befe4a00 00001000 00000000
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> > 1fc0: 000a9f20 00001000 befe4a00 00000003 00000000 00000000 00000003 00000001
> > pgd = edfc4000
> > [0000000c] *pgd=bfcac835
> > 1fe0: 00000000 befe49dc 000197f8 b6e35dfc 60070010 00000003 3065b49d 134ac2c9
> > 
> > [<c058f1bc>] (show_ignore_nice_load_gov_pol) from [<c058ae88>] (show+0x4c/0x60)
> > [<c058ae88>] (show) from [<c01fcb90>] (sysfs_kf_seq_show+0x90/0xfc)
> > [<c01fcb90>] (sysfs_kf_seq_show) from [<c01fb33c>] (kernfs_seq_show+0x34/0x38)
> > [<c01fb33c>] (kernfs_seq_show) from [<c01a5210>] (seq_read+0x1e4/0x4e4)
> > [<c01a5210>] (seq_read) from [<c01fbed8>] (kernfs_fop_read+0x120/0x1a0)
> > [<c01fbed8>] (kernfs_fop_read) from [<c017c328>] (__vfs_read+0x3c/0xe0)
> > [<c017c328>] (__vfs_read) from [<c017d1ec>] (vfs_read+0x98/0x104)
> > [<c017d1ec>] (vfs_read) from [<c017d2a8>] (SyS_read+0x50/0x90)
> > [<c017d2a8>] (SyS_read) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> > Code: e5903044 e1a00001 e3081df4 e34c1092 (e593300c)
> > ---[ end trace 5994b9a5111f35ee ]---
> > 
> > Fix that by making sure, policy->governor_data is updated at the right
> > places only.
> > 
> 
> This patch fixes the crash I was seeing.
> 
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> 
> However, it exposes another problem (running the concurrent lockdep test
> that you merged in your tests). After the test is finished there is
> always at least one task spinning. Do you think it might be related to
> the race we are already discussing in the thread related to my cleanups
> patches? This is what I see:
> 
> [   37.963599] ======================================================
> [   37.982113] [ INFO: possible circular locking dependency detected ]
> [   38.000890] 4.5.0-rc1+ #468 Not tainted
> [   38.012368] -------------------------------------------------------
> [   38.031137] runme.sh/1710 is trying to acquire lock:
> [   38.045999]  (s_active#41){++++.+}, at: [<c01fb12c>] kernfs_remove_by_name_ns+0x4c/0x94
> [   38.070063]
> [   38.070063] but task is already holding lock:
> [   38.087530]  (od_dbs_cdata.mutex){+.+.+.}, at: [<c0591050>] cpufreq_governor_dbs+0x34/0x5d0
> [   38.112615]
> [   38.112615] which lock already depends on the new lock.
> [   38.112615]
> [   38.137114]
> [   38.137114] the existing dependency chain (in reverse order) is:
> [   38.159528]
> -> #2 (od_dbs_cdata.mutex){+.+.+.}:
> [   38.173664]        [<c0769ae8>] mutex_lock_nested+0x7c/0x420
> [   38.190637]        [<c0591050>] cpufreq_governor_dbs+0x34/0x5d0
> [   38.208380]        [<c058ed10>] od_cpufreq_governor_dbs+0x20/0x28
> [   38.226641]        [<c058c094>] __cpufreq_governor+0x98/0x1bc
> [   38.243861]        [<c058c91c>] cpufreq_set_policy+0x150/0x204
> [   38.261341]        [<c058cd98>] store_scaling_governor+0x70/0x8c
> [   38.279343]        [<c058aa70>] store+0x88/0xa4
> [   38.292917]        [<c01fca54>] sysfs_kf_write+0x5c/0x60
> [   38.308835]        [<c01fbccc>] kernfs_fop_write+0xdc/0x1c8
> [   38.325535]        [<c017c170>] __vfs_write+0x3c/0xe4
> [   38.340678]        [<c017d0b0>] vfs_write+0xb0/0x154
> [   38.355555]        [<c017d338>] SyS_write+0x50/0x90
> [   38.370170]        [<c000fe40>] ret_fast_syscall+0x0/0x1c
> [   38.386354]
> -> #1 (&policy->rwsem){+++++.}:
> [   38.399441]        [<c076b498>] down_read+0x58/0x94
> [   38.414058]        [<c058ae6c>] show+0x30/0x60
> [   38.427372]        [<c01fcb90>] sysfs_kf_seq_show+0x90/0xfc
> [   38.444079]        [<c01fb33c>] kernfs_seq_show+0x34/0x38
> [   38.460266]        [<c01a5210>] seq_read+0x1e4/0x4e4
> [   38.475149]        [<c01fbed8>] kernfs_fop_read+0x120/0x1a0
> [   38.491844]        [<c017c328>] __vfs_read+0x3c/0xe0
> [   38.506721]        [<c017d1ec>] vfs_read+0x98/0x104
> [   38.521456]        [<c017d2a8>] SyS_read+0x50/0x90
> [   38.535812]        [<c000fe40>] ret_fast_syscall+0x0/0x1c
> [   38.551993]
> -> #0 (s_active#41){++++.+}:
> [   38.564311]        [<c0082038>] lock_acquire+0xd4/0x20c
> [   38.579975]        [<c01fa348>] __kernfs_remove+0x288/0x328
> [   38.596677]        [<c01fb12c>] kernfs_remove_by_name_ns+0x4c/0x94
> [   38.615199]        [<c01fd868>] remove_files+0x44/0x88
> [   38.630594]        [<c01fdde8>] sysfs_remove_group+0x50/0xa4
> [   38.647554]        [<c0591408>] cpufreq_governor_dbs+0x3ec/0x5d0
> [   38.665556]        [<c058ed10>] od_cpufreq_governor_dbs+0x20/0x28
> [   38.683815]        [<c058c094>] __cpufreq_governor+0x98/0x1bc
> [   38.701032]        [<c058c8f4>] cpufreq_set_policy+0x128/0x204
> [   38.718513]        [<c058cd98>] store_scaling_governor+0x70/0x8c
> [   38.736511]        [<c058aa70>] store+0x88/0xa4
> [   38.750176]        [<c01fca54>] sysfs_kf_write+0x5c/0x60
> [   38.766128]        [<c01fbccc>] kernfs_fop_write+0xdc/0x1c8
> [   38.782844]        [<c017c170>] __vfs_write+0x3c/0xe4
> [   38.797981]        [<c017d0b0>] vfs_write+0xb0/0x154
> [   38.812855]        [<c017d338>] SyS_write+0x50/0x90
> [   38.827468]        [<c000fe40>] ret_fast_syscall+0x0/0x1c
> [   38.843648]
> [   38.843648] other info that might help us debug this:
> [   38.843648]
> [   38.867627] Chain exists of:
>   s_active#41 --> &policy->rwsem --> od_dbs_cdata.mutex
> 
> [   38.891693]  Possible unsafe locking scenario:
> [   38.891693]
> [   38.909419]        CPU0                    CPU1
> [   38.922978]        ----                    ----
> [   38.936535]   lock(od_dbs_cdata.mutex);
> [   38.948146]                                lock(&policy->rwsem);
> [   38.966168]                                lock(od_dbs_cdata.mutex);
> [   38.985219]   lock(s_active#41);
> [   38.994923]
> [   38.994923]  *** DEADLOCK ***
> [   38.994923]
> [   39.012669] 5 locks held by runme.sh/1710:
> [   39.024925]  #0:  (sb_writers#7){.+.+.+}, at: [<c017ed30>] __sb_start_write+0xb8/0xc4
> [   39.048456]  #1:  (&of->mutex){+.+.+.}, at: [<c01fbc5c>] kernfs_fop_write+0x6c/0x1c8
> [   39.071715]  #2:  (s_active#35){.+.+.+}, at: [<c01fbc64>] kernfs_fop_write+0x74/0x1c8
> [   39.095274]  #3:  (cpu_hotplug.lock){++++++}, at: [<c0029eec>] get_online_cpus+0x48/0xb8
> [   39.119579]  #4:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c0591050>] cpufreq_governor_dbs+0x34/0x5d0
> [   39.145965]
> [   39.145965] stack backtrace:
> [   39.159008] CPU: 1 PID: 1710 Comm: runme.sh Not tainted 4.5.0-rc1+ #468
> [   39.178816] Hardware name: ARM-Versatile Express
> [   39.192652] [<c0018948>] (unwind_backtrace) from [<c001404c>] (show_stack+0x20/0x24)
> [   39.215863] [<c001404c>] (show_stack) from [<c04583d8>] (dump_stack+0x80/0xb4)
> [   39.237511] [<c04583d8>] (dump_stack) from [<c0128324>] (print_circular_bug+0x29c/0x2f0)
> [   39.261767] [<c0128324>] (print_circular_bug) from [<c00813dc>] (__lock_acquire+0x1670/0x1d74)
> [   39.287580] [<c00813dc>] (__lock_acquire) from [<c0082038>] (lock_acquire+0xd4/0x20c)
> [   39.311049] [<c0082038>] (lock_acquire) from [<c01fa348>] (__kernfs_remove+0x288/0x328)
> [   39.335040] [<c01fa348>] (__kernfs_remove) from [<c01fb12c>] (kernfs_remove_by_name_ns+0x4c/0x94)
> [   39.361635] [<c01fb12c>] (kernfs_remove_by_name_ns) from [<c01fd868>] (remove_files+0x44/0x88)
> [   39.387445] [<c01fd868>] (remove_files) from [<c01fdde8>] (sysfs_remove_group+0x50/0xa4)
> [   39.411696] [<c01fdde8>] (sysfs_remove_group) from [<c0591408>] (cpufreq_governor_dbs+0x3ec/0x5d0)
> [   39.438547] [<c0591408>] (cpufreq_governor_dbs) from [<c058ed10>] (od_cpufreq_governor_dbs+0x20/0x28)
> [   39.466241] [<c058ed10>] (od_cpufreq_governor_dbs) from [<c058c094>] (__cpufreq_governor+0x98/0x1bc)
> [   39.493705] [<c058c094>] (__cpufreq_governor) from [<c058c8f4>] (cpufreq_set_policy+0x128/0x204)
> [   39.520034] [<c058c8f4>] (cpufreq_set_policy) from [<c058cd98>] (store_scaling_governor+0x70/0x8c)
> [   39.546884] [<c058cd98>] (store_scaling_governor) from [<c058aa70>] (store+0x88/0xa4)
> [   39.570345] [<c058aa70>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   39.591720] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   39.616228] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   39.639691] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   39.661589] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   39.682707] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)

So, this goes away with your patch (that I forward ported) and a small
additional fix on top of that. I pushed all that here (so that it is
also tested by 0-day):

 git://linux-arm.org/linux-jl.git fixes/cpufreq/policy_exit_race 

However, I can still see what below :/.

Best,

- Juri

> [   81.100358] NMI watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [runme.sh:1710]
> [   81.122790] Modules linked in:
> [   81.131959] irq event stamp: 6981
> [   81.141905] hardirqs last  enabled at (6981): [<c0769fa4>] __mutex_unlock_slowpath+0x118/0x1ac
> [   81.167788] hardirqs last disabled at (6980): [<c0769ee8>] __mutex_unlock_slowpath+0x5c/0x1ac
> [   81.193345] softirqs last  enabled at (4864): [<c002ed90>] __do_softirq+0x338/0x58c
> [   81.216299] softirqs last disabled at (4859): [<c002f374>] irq_exit+0xd4/0x140
> [   81.237957] CPU: 4 PID: 1710 Comm: runme.sh Not tainted 4.5.0-rc1+ #468
> [   81.257767] Hardware name: ARM-Versatile Express
> [   81.271625] task: ee8dd080 ti: ee92a000 task.ti: ee92a000
> [   81.287879] PC is at srcu_notifier_chain_register+0x58/0xe4
> [   81.304570] LR is at trace_hardirqs_on_caller+0x1c/0x1f4
> [   81.320489] pc : [<c004ea9c>]    lr : [<c00829b8>]    psr: a00f0013
> [   81.320489] sp : ee92bba8  ip : ee92bb28  fp : ee92bbbc
> [   81.354896] r10: ee92bf78  r9 : 00000000  r8 : c0af5860
> [   81.370542] r7 : 00000000  r6 : 00000000  r5 : c0af58a4  r4 : c130d03c
> [   81.390103] r3 : c0af58a4  r2 : 00000000  r1 : c0af58a8  r0 : 00000000
> [   81.409657] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   81.431033] Control: 10c5387d  Table: adde406a  DAC: 00000051
> [   81.448244] CPU: 4 PID: 1710 Comm: runme.sh Not tainted 4.5.0-rc1+ #468
> [   81.468054] Hardware name: ARM-Versatile Express
> [   81.481917] [<c0018948>] (unwind_backtrace) from [<c001404c>] (show_stack+0x20/0x24)
> [   81.505138] [<c001404c>] (show_stack) from [<c04583d8>] (dump_stack+0x80/0xb4)
> [   81.526782] [<c04583d8>] (dump_stack) from [<c0010c3c>] (show_regs+0x1c/0x20)
> [   81.548168] [<c0010c3c>] (show_regs) from [<c00ea6f0>] (watchdog_timer_fn+0x1dc/0x258)
> [   81.571919] [<c00ea6f0>] (watchdog_timer_fn) from [<c00aa8b8>] (__hrtimer_run_queues+0x1b0/0x5dc)
> [   81.598527] [<c00aa8b8>] (__hrtimer_run_queues) from [<c00ab740>] (hrtimer_interrupt+0xd4/0x234)
> [   81.624861] [<c00ab740>] (hrtimer_interrupt) from [<c05ad290>] (arch_timer_handler_virt+0x38/0x40)
> [   81.651806] [<c05ad290>] (arch_timer_handler_virt) from [<c0093548>] (handle_percpu_devid_irq+0xe4/0x310)
> [   81.680563] [<c0093548>] (handle_percpu_devid_irq) from [<c008ec00>] (generic_handle_irq+0x28/0x38)
> [   81.707676] [<c008ec00>] (generic_handle_irq) from [<c008ed54>] (__handle_domain_irq+0x64/0xbc)
> [   81.733745] [<c008ed54>] (__handle_domain_irq) from [<c00094dc>] (gic_handle_irq+0x54/0xa0)
> [   81.758774] [<c00094dc>] (gic_handle_irq) from [<c0014bf8>] (__irq_svc+0x58/0x78)
> [   81.781191] Exception stack(0xee92bb58 to 0xee92bba0)
> [   81.796320] bb40:                                                       00000000 c0af58a8
> [   81.820826] bb60: 00000000 c0af58a4 c130d03c c0af58a4 00000000 00000000 c0af5860 00000000
> [   81.845331] bb80: ee92bf78 ee92bbbc ee92bb28 ee92bba8 c00829b8 c004ea9c a00f0013 ffffffff
> [   81.869841] [<c0014bf8>] (__irq_svc) from [<c004ea9c>] (srcu_notifier_chain_register+0x58/0xe4)
> [   81.895911] [<c004ea9c>] (srcu_notifier_chain_register) from [<c058b30c>] (cpufreq_register_notifier+0x64/0x9c)
> [   81.926150] [<c058b30c>] (cpufreq_register_notifier) from [<c05908bc>] (cs_init+0x94/0xc0)
> [   81.950920] [<c05908bc>] (cs_init) from [<c05914e0>] (cpufreq_governor_dbs+0x4c4/0x5d0)
> [   81.974909] [<c05914e0>] (cpufreq_governor_dbs) from [<c058fda0>] (cs_cpufreq_governor_dbs+0x20/0x28)
> [   82.002541] [<c058fda0>] (cs_cpufreq_governor_dbs) from [<c058c094>] (__cpufreq_governor+0x98/0x1bc)
> [   82.029914] [<c058c094>] (__cpufreq_governor) from [<c058c91c>] (cpufreq_set_policy+0x150/0x204)
> [   82.056244] [<c058c91c>] (cpufreq_set_policy) from [<c058cd98>] (store_scaling_governor+0x70/0x8c)
> [   82.083095] [<c058cd98>] (store_scaling_governor) from [<c058aa70>] (store+0x88/0xa4)
> [   82.106561] [<c058aa70>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   82.127945] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   82.152455] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   82.175922] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   82.197825] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   82.218947] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> [   83.940245] INFO: rcu_sched self-detected stall on CPU
> [   83.955652]  4-...: (2485 ticks this GP) idle=7f5/140000000000001/0 softirq=6279/6282 fqs=2484
> [   83.981748]   (t=2600 jiffies g=1205 c=1204 q=4709)
> [   83.996422] Task dump for CPU 4:
> [   84.006077] runme.sh        R running      0  1710      1 0x00000002
> [   84.025148] [<c0018948>] (unwind_backtrace) from [<c001404c>] (show_stack+0x20/0x24)
> [   84.048356] [<c001404c>] (show_stack) from [<c005d9d0>] (sched_show_task+0x15c/0x264)
> [   84.071826] [<c005d9d0>] (sched_show_task) from [<c0060944>] (dump_cpu_task+0x48/0x4c)
> [   84.095556] [<c0060944>] (dump_cpu_task) from [<c009c690>] (rcu_dump_cpu_stacks+0xa8/0xd8)
> [   84.120326] [<c009c690>] (rcu_dump_cpu_stacks) from [<c00a3398>] (rcu_check_callbacks+0x564/0xa14)
> [   84.147179] [<c00a3398>] (rcu_check_callbacks) from [<c00a9b8c>] (update_process_times+0x40/0x6c)
> [   84.173772] [<c00a9b8c>] (update_process_times) from [<c00bce64>] (tick_sched_handle+0x64/0x70)
> [   84.199842] [<c00bce64>] (tick_sched_handle) from [<c00bcf6c>] (tick_sched_timer+0x54/0x94)
> [   84.224870] [<c00bcf6c>] (tick_sched_timer) from [<c00aa8b8>] (__hrtimer_run_queues+0x1b0/0x5dc)
> [   84.251201] [<c00aa8b8>] (__hrtimer_run_queues) from [<c00ab740>] (hrtimer_interrupt+0xd4/0x234)
> [   84.277534] [<c00ab740>] (hrtimer_interrupt) from [<c05ad290>] (arch_timer_handler_virt+0x38/0x40)
> [   84.304387] [<c05ad290>] (arch_timer_handler_virt) from [<c0093548>] (handle_percpu_devid_irq+0xe4/0x310)
> [   84.333062] [<c0093548>] (handle_percpu_devid_irq) from [<c008ec00>] (generic_handle_irq+0x28/0x38)
> [   84.360175] [<c008ec00>] (generic_handle_irq) from [<c008ed54>] (__handle_domain_irq+0x64/0xbc)
> [   84.386245] [<c008ed54>] (__handle_domain_irq) from [<c00094dc>] (gic_handle_irq+0x54/0xa0)
> [   84.411295] [<c00094dc>] (gic_handle_irq) from [<c0014bf8>] (__irq_svc+0x58/0x78)
> [   84.433831] Exception stack(0xee92bb58 to 0xee92bba0)
> [   84.448957] bb40:                                                       00000000 c0af58a8
> [   84.473461] bb60: 00000000 c0af58a4 c130d03c c0af58a4 00000000 00000000 c0af5860 00000000
> [   84.497966] bb80: ee92bf78 ee92bbbc ee92bb28 ee92bba8 c00829b8 c004eaa0 a00f0013 ffffffff
> [   84.522474] [<c0014bf8>] (__irq_svc) from [<c004eaa0>] (srcu_notifier_chain_register+0x5c/0xe4)
> [   84.548544] [<c004eaa0>] (srcu_notifier_chain_register) from [<c058b30c>] (cpufreq_register_notifier+0x64/0x9c)
> [   84.578782] [<c058b30c>] (cpufreq_register_notifier) from [<c05908bc>] (cs_init+0x94/0xc0)
> [   84.603551] [<c05908bc>] (cs_init) from [<c05914e0>] (cpufreq_governor_dbs+0x4c4/0x5d0)
> [   84.627539] [<c05914e0>] (cpufreq_governor_dbs) from [<c058fda0>] (cs_cpufreq_governor_dbs+0x20/0x28)
> [   84.655171] [<c058fda0>] (cs_cpufreq_governor_dbs) from [<c058c094>] (__cpufreq_governor+0x98/0x1bc)
> [   84.682542] [<c058c094>] (__cpufreq_governor) from [<c058c91c>] (cpufreq_set_policy+0x150/0x204)
> [   84.708872] [<c058c91c>] (cpufreq_set_policy) from [<c058cd98>] (store_scaling_governor+0x70/0x8c)
> [   84.735721] [<c058cd98>] (store_scaling_governor) from [<c058aa70>] (store+0x88/0xa4)
> [   84.759187] [<c058aa70>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   84.780569] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   84.805077] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   84.828543] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   84.850445] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   84.871619] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> [   92.891647] INFO: task runme.sh:1708 blocked for more than 30 seconds.
> [   92.911227]       Tainted: G             L  4.5.0-rc1+ #468
> [   92.927938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   92.951408] runme.sh        D c07674b4     0  1708      1 0x00000000
> [   92.970570] [<c07674b4>] (__schedule) from [<c0767d78>] (schedule+0x50/0xcc)
> [   92.991720] [<c0767d78>] (schedule) from [<c0768038>] (schedule_preempt_disabled+0x30/0x4c)
> [   93.016771] [<c0768038>] (schedule_preempt_disabled) from [<c0769c54>] (mutex_lock_nested+0x1e8/0x420)
> [   93.044692] [<c0769c54>] (mutex_lock_nested) from [<c0591050>] (cpufreq_governor_dbs+0x34/0x5d0)
> [   93.071035] [<c0591050>] (cpufreq_governor_dbs) from [<c058fda0>] (cs_cpufreq_governor_dbs+0x20/0x28)
> [   93.098695] [<c058fda0>] (cs_cpufreq_governor_dbs) from [<c058c094>] (__cpufreq_governor+0x98/0x1bc)
> [   93.126076] [<c058c094>] (__cpufreq_governor) from [<c058c91c>] (cpufreq_set_policy+0x150/0x204)
> [   93.152425] [<c058c91c>] (cpufreq_set_policy) from [<c058cd98>] (store_scaling_governor+0x70/0x8c)
> [   93.179290] [<c058cd98>] (store_scaling_governor) from [<c058aa70>] (store+0x88/0xa4)
> [   93.202782] [<c058aa70>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   93.224178] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   93.248706] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   93.272183] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   93.294103] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   93.315241] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> [   93.337939] INFO: lockdep is turned off.
> [   93.349690] INFO: task runme.sh:1709 blocked for more than 30 seconds.
> [   93.369263]       Tainted: G             L  4.5.0-rc1+ #468
> [   93.385961] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   93.409440] runme.sh        D c07674b4     0  1709      1 0x00000000
> [   93.428564] [<c07674b4>] (__schedule) from [<c0767d78>] (schedule+0x50/0xcc)
> [   93.449710] [<c0767d78>] (schedule) from [<c076bd80>] (rwsem_down_write_failed+0x1ec/0x4a4)
> [   93.474749] [<c076bd80>] (rwsem_down_write_failed) from [<c076b438>] (down_write+0xa8/0xb0)
> [   93.499796] [<c076b438>] (down_write) from [<c058aa50>] (store+0x68/0xa4)
> [   93.520156] [<c058aa50>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   93.541560] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   93.566077] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   93.589566] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   93.611476] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   93.632615] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> [   93.655302] INFO: lockdep is turned off.
> [   93.667064] INFO: task runme.sh:1711 blocked for more than 30 seconds.
> [   93.686628]       Tainted: G             L  4.5.0-rc1+ #468
> [   93.703334] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   93.726808] runme.sh        D c07674b4     0  1711      1 0x00000000
> [   93.745909] [<c07674b4>] (__schedule) from [<c0767d78>] (schedule+0x50/0xcc)
> [   93.767051] [<c0767d78>] (schedule) from [<c076bd80>] (rwsem_down_write_failed+0x1ec/0x4a4)
> [   93.792089] [<c076bd80>] (rwsem_down_write_failed) from [<c076b438>] (down_write+0xa8/0xb0)
> [   93.817135] [<c076b438>] (down_write) from [<c058aa50>] (store+0x68/0xa4)
> [   93.837483] [<c058aa50>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   93.858887] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   93.883408] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   93.906892] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   93.928803] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   93.949942] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> [   93.972630] INFO: lockdep is turned off.
> [   93.984396] INFO: task runme.sh:1712 blocked for more than 30 seconds.
> [   94.003960]       Tainted: G             L  4.5.0-rc1+ #468
> [   94.020667] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   94.044137] runme.sh        D c07674b4     0  1712      1 0x00000000
> [   94.063237] [<c07674b4>] (__schedule) from [<c0767d78>] (schedule+0x50/0xcc)
> [   94.084378] [<c0767d78>] (schedule) from [<c076bd80>] (rwsem_down_write_failed+0x1ec/0x4a4)
> [   94.109416] [<c076bd80>] (rwsem_down_write_failed) from [<c076b438>] (down_write+0xa8/0xb0)
> [   94.134467] [<c076b438>] (down_write) from [<c058aa50>] (store+0x68/0xa4)
> [   94.154816] [<c058aa50>] (store) from [<c01fca54>] (sysfs_kf_write+0x5c/0x60)
> [   94.176214] [<c01fca54>] (sysfs_kf_write) from [<c01fbccc>] (kernfs_fop_write+0xdc/0x1c8)
> [   94.200733] [<c01fbccc>] (kernfs_fop_write) from [<c017c170>] (__vfs_write+0x3c/0xe4)
> [   94.224216] [<c017c170>] (__vfs_write) from [<c017d0b0>] (vfs_write+0xb0/0x154)
> [   94.246127] [<c017d0b0>] (vfs_write) from [<c017d338>] (SyS_write+0x50/0x90)
> [   94.267271] [<c017d338>] (SyS_write) from [<c000fe40>] (ret_fast_syscall+0x0/0x1c)
> 
> Now, you already pointed me at a possible fix. I'm going to test that
> (even if I have questions about that patch :)) and see if it makes this
> go away. 
> 
> Thanks,
> 
> - Juri
