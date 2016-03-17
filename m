From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Thu, 17 Mar 2016 09:02:29 -0400
Message-ID: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36613 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936079AbcCQNCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 09:02:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

Hello,

I have an Intel Atom based NUC that is producing the following
backtraces on boot of Linus' tree as of last evening.  This does not
happen with a tree with top level commit 271ecc5253e2, but does happen
when using the tree mentioned in the subject with top level commit
63e30271b04c.

The first backtrace appears to be a warning because the intel_pstate
driver is calling wrmsrl_on_cpu when interrupts are disabled?  Not
sure on that one.

The second backtrace is a lockdep report.  Both are from the same boot.

josh

[    2.063588] Intel P-state driver initializing.
[    2.064225] ------------[ cut here ]------------
[    2.064236] WARNING: CPU: 0 PID: 1 at kernel/smp.c:291
smp_call_function_single+0x116/0x130()
[    2.064240] Modules linked in:
[    2.064247] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.6.0-0.rc0.git6.1.fc25.x86_64 #1
[    2.064250] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[    2.064254]  0000000000000086 000000008f3c08c6 ffff880237203bf0
ffffffff8144ed43
[    2.064262]  0000000000000000 ffffffff81c3eba4 ffff880237203c28
ffffffff810b1482
[    2.064269]  0000000000000000 ffffffff814881b0 ffff880232bdfa80
0000000000000093
[    2.064276] Call Trace:
[    2.064279]  <IRQ>  [<ffffffff8144ed43>] dump_stack+0x85/0xc2
[    2.064291]  [<ffffffff810b1482>] warn_slowpath_common+0x82/0xc0
[    2.064297]  [<ffffffff814881b0>] ? __rdmsr_on_cpu+0x70/0x70
[    2.064302]  [<ffffffff810b15ca>] warn_slowpath_null+0x1a/0x20
[    2.064307]  [<ffffffff81155666>] smp_call_function_single+0x116/0x130
[    2.064313]  [<ffffffff81488450>] wrmsrl_on_cpu+0x50/0x70
[    2.064319]  [<ffffffff8170beb4>] atom_set_pstate+0x74/0x90
[    2.064324]  [<ffffffff8170bcec>] intel_pstate_set_pstate+0x13c/0x220
[    2.064330]  [<ffffffff8170c025>] intel_pstate_update_util+0x155/0x340
[    2.064335]  [<ffffffff8110a411>] ? cpuacct_charge+0xd1/0x1a0
[    2.064340]  [<ffffffff8110a345>] ? cpuacct_charge+0x5/0x1a0
[    2.064346]  [<ffffffff810f74d3>] task_tick_fair+0x613/0xa60
[    2.064352]  [<ffffffff810e853b>] scheduler_tick+0x5b/0xe0
[    2.064357]  [<ffffffff8114f340>] ? tick_sched_do_timer+0x60/0x60
[    2.064362]  [<ffffffff8113cb81>] update_process_times+0x51/0x60
[    2.064367]  [<ffffffff8114eaa5>] tick_sched_handle.isra.20+0x25/0x60
[    2.064372]  [<ffffffff8114f37d>] tick_sched_timer+0x3d/0x70
[    2.064377]  [<ffffffff8113d8f0>] __hrtimer_run_queues+0x110/0x540
[    2.064382]  [<ffffffff8113e417>] hrtimer_interrupt+0xb7/0x1d0
[    2.064388]  [<ffffffff8105b258>] local_apic_timer_interrupt+0x38/0x60
[    2.064394]  [<ffffffff818b273d>] smp_apic_timer_interrupt+0x3d/0x50
[    2.064399]  [<ffffffff818b07a6>] apic_timer_interrupt+0x96/0xa0
[    2.064402]  <EOI>  [<ffffffff818af07b>] ?
_raw_spin_unlock_irqrestore+0x3b/0x60
[    2.064411]  [<ffffffff81450bd8>] ida_simple_get+0x98/0x100
[    2.064417]  [<ffffffff813236ef>] __kernfs_new_node+0x5f/0xc0
[    2.064423]  [<ffffffff813249b9>] kernfs_new_node+0x29/0x50
[    2.064427]  [<ffffffff81326502>] __kernfs_create_file+0x32/0xd0
[    2.064432]  [<ffffffff81326e40>] sysfs_add_file_mode_ns+0x90/0x1b0
[    2.064437]  [<ffffffff81326f8a>] sysfs_create_file_ns+0x2a/0x30
[    2.064442]  [<ffffffff8170872b>] cpufreq_online+0x30b/0x860
[    2.064447]  [<ffffffff81708d32>] cpufreq_add_dev+0x62/0x90
[    2.064453]  [<ffffffff815aa69c>] subsys_interface_register+0xbc/0x110
[    2.064459]  [<ffffffff81706aac>] cpufreq_register_driver+0x14c/0x210
[    2.064464]  [<ffffffff821f83e6>] intel_pstate_init+0x3b5/0x504
[    2.064469]  [<ffffffff821f8031>] ? intel_pstate_setup+0x9a/0x9a
[    2.064474]  [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[    2.064479]  [<ffffffff810d86f7>] ? parse_args+0x297/0x4b0
[    2.064486]  [<ffffffff8219b227>] kernel_init_freeable+0x1f3/0x28d
[    2.064492]  [<ffffffff8189f6ee>] kernel_init+0xe/0x100
[    2.064497]  [<ffffffff818afcb2>] ret_from_fork+0x22/0x50
[    2.064501]  [<ffffffff8189f6e0>] ? rest_init+0x140/0x140
[    2.064661] ---[ end trace 83cfc0c0effa9465 ]---

[   21.748603] ======================================================
[   21.748606] [ INFO: possible circular locking dependency detected ]
[   21.748611] 4.6.0-0.rc0.git6.1.fc25.x86_64 #1 Tainted: G        W
[   21.748614] -------------------------------------------------------
[   21.748617] abrt-handle-eve/849 is trying to acquire lock:
[   21.748620]  (&p->pi_lock){-.-.-.}, at: [<ffffffff810e57f1>]
try_to_wake_up+0x31/0x510
[   21.748635]
               but task is already holding lock:
[   21.748638]  (random_write_wait.lock){-.....}, at:
[<ffffffff81102913>] __wake_up+0x23/0x50
[   21.748647]
               which lock already depends on the new lock.

[   21.748651]
               the existing dependency chain (in reverse order) is:
[   21.748655]
               -> #2 (random_write_wait.lock){-.....}:
[   21.748662]        [<ffffffff811128ee>] lock_acquire+0xfe/0x1f0
[   21.748667]        [<ffffffff818af7b6>] _raw_spin_lock_irqsave+0x56/0x90
[   21.748674]        [<ffffffff81102913>] __wake_up+0x23/0x50
[   21.748679]        [<ffffffff8157b442>] account.part.28+0x1d2/0x250
[   21.748685]        [<ffffffff8157cd5d>] extract_entropy+0x9d/0x530
[   21.748689]        [<ffffffff8157de21>] get_random_bytes+0x51/0x150
[   21.748694]        [<ffffffff810b13df>] print_oops_end_marker+0x3f/0x60
[   21.748700]        [<ffffffff810b1487>] warn_slowpath_common+0x87/0xc0
[   21.748705]        [<ffffffff810b15ca>] warn_slowpath_null+0x1a/0x20
[   21.748710]        [<ffffffff81155666>] smp_call_function_single+0x116/0x130
[   21.748716]        [<ffffffff81488450>] wrmsrl_on_cpu+0x50/0x70
[   21.748723]        [<ffffffff8170beb4>] atom_set_pstate+0x74/0x90
[   21.748729]        [<ffffffff8170bcec>] intel_pstate_set_pstate+0x13c/0x220
[   21.748734]        [<ffffffff8170c025>] intel_pstate_update_util+0x155/0x340
[   21.748739]        [<ffffffff810f74d3>] task_tick_fair+0x613/0xa60
[   21.748745]        [<ffffffff810e853b>] scheduler_tick+0x5b/0xe0
[   21.748749]        [<ffffffff8113cb81>] update_process_times+0x51/0x60
[   21.748755]        [<ffffffff8114eaa5>] tick_sched_handle.isra.20+0x25/0x60
[   21.748760]        [<ffffffff8114f37d>] tick_sched_timer+0x3d/0x70
[   21.748765]        [<ffffffff8113d8f0>] __hrtimer_run_queues+0x110/0x540
[   21.748769]        [<ffffffff8113e417>] hrtimer_interrupt+0xb7/0x1d0
[   21.748773]        [<ffffffff8105b258>] local_apic_timer_interrupt+0x38/0x60
[   21.748779]        [<ffffffff818b273d>] smp_apic_timer_interrupt+0x3d/0x50
[   21.748784]        [<ffffffff818b07a6>] apic_timer_interrupt+0x96/0xa0
[   21.748788]        [<ffffffff81450bd8>] ida_simple_get+0x98/0x100
[   21.748794]        [<ffffffff813236ef>] __kernfs_new_node+0x5f/0xc0
[   21.748800]        [<ffffffff813249b9>] kernfs_new_node+0x29/0x50
[   21.748805]        [<ffffffff81326502>] __kernfs_create_file+0x32/0xd0
[   21.748809]        [<ffffffff81326e40>] sysfs_add_file_mode_ns+0x90/0x1b0
[   21.748814]        [<ffffffff81326f8a>] sysfs_create_file_ns+0x2a/0x30
[   21.748819]        [<ffffffff8170872b>] cpufreq_online+0x30b/0x860
[   21.748824]        [<ffffffff81708d32>] cpufreq_add_dev+0x62/0x90
[   21.748828]        [<ffffffff815aa69c>] subsys_interface_register+0xbc/0x110
[   21.748835]        [<ffffffff81706aac>] cpufreq_register_driver+0x14c/0x210
[   21.748840]        [<ffffffff821f83e6>] intel_pstate_init+0x3b5/0x504
[   21.748846]        [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[   21.748851]        [<ffffffff8219b227>] kernel_init_freeable+0x1f3/0x28d
[   21.748858]        [<ffffffff8189f6ee>] kernel_init+0xe/0x100
[   21.748863]        [<ffffffff818afcb2>] ret_from_fork+0x22/0x50
[   21.748868]
               -> #1 (&rq->lock){-.-.-.}:
[   21.748874]        [<ffffffff811128ee>] lock_acquire+0xfe/0x1f0
[   21.748880]        [<ffffffff818aeb9d>] _raw_spin_lock+0x3d/0x80
[   21.748884]        [<ffffffff810ec5ad>] sched_move_task+0x4d/0x280
[   21.748888]        [<ffffffff810ec7ee>] cpu_cgroup_fork+0xe/0x10
[   21.748893]        [<ffffffff8116e883>] cgroup_post_fork+0x43/0x130
[   21.748899]        [<ffffffff810afcdd>] copy_process.part.25+0x15ad/0x1b30
[   21.748904]        [<ffffffff810b043e>] _do_fork+0xee/0x700
[   21.748908]        [<ffffffff810b0a79>] kernel_thread+0x29/0x30
[   21.748913]        [<ffffffff8189f5c2>] rest_init+0x22/0x140
[   21.748917]        [<ffffffff8219b013>] start_kernel+0x49a/0x4bb
[   21.748922]        [<ffffffff8219a32c>] x86_64_start_reservations+0x2a/0x2c
[   21.748927]        [<ffffffff8219a478>] x86_64_start_kernel+0x14a/0x16d
[   21.748931]
               -> #0 (&p->pi_lock){-.-.-.}:
[   21.748937]        [<ffffffff81111cb4>] __lock_acquire+0x1a34/0x1c60
[   21.748942]        [<ffffffff811128ee>] lock_acquire+0xfe/0x1f0
[   21.748946]        [<ffffffff818af7b6>] _raw_spin_lock_irqsave+0x56/0x90
[   21.748951]        [<ffffffff810e57f1>] try_to_wake_up+0x31/0x510
[   21.748955]        [<ffffffff810e5d72>] default_wake_function+0x12/0x20
[   21.748960]        [<ffffffff812a7b13>] pollwake+0x73/0x90
[   21.748966]        [<ffffffff811028b2>] __wake_up_common+0x52/0x90
[   21.748970]        [<ffffffff81102929>] __wake_up+0x39/0x50
[   21.748974]        [<ffffffff8157b442>] account.part.28+0x1d2/0x250
[   21.748978]        [<ffffffff8157cd5d>] extract_entropy+0x9d/0x530
[   21.748983]        [<ffffffff8157de21>] get_random_bytes+0x51/0x150
[   21.748987]        [<ffffffff812fba6a>] load_elf_binary+0xc2a/0x1750
[   21.748992]        [<ffffffff81297c77>] search_binary_handler+0x97/0x1c0
[   21.748997]        [<ffffffff81299882>]
do_execveat_common.isra.36+0x6a2/0x9a0
[   21.749001]        [<ffffffff81299e6a>] SyS_execve+0x3a/0x50
[   21.749005]        [<ffffffff81004027>] do_syscall_64+0x67/0x190
[   21.749010]        [<ffffffff818afb3f>] return_from_SYSCALL_64+0x0/0x7a
[   21.749015]
               other info that might help us debug this:

[   21.749019] Chain exists of:
                 &p->pi_lock --> &rq->lock --> random_write_wait.lock

[   21.749026]  Possible unsafe locking scenario:

[   21.749030]        CPU0                    CPU1
[   21.749032]        ----                    ----
[   21.749034]   lock(random_write_wait.lock);
[   21.749038]                                lock(&rq->lock);
[   21.749042]                                lock(random_write_wait.lock);
[   21.749046]   lock(&p->pi_lock);
[   21.749050]
                *** DEADLOCK ***

[   21.749054] 1 lock held by abrt-handle-eve/849:
[   21.749056]  #0:  (random_write_wait.lock){-.....}, at:
[<ffffffff81102913>] __wake_up+0x23/0x50
[   21.749065]
               stack backtrace:
[   21.749070] CPU: 0 PID: 849 Comm: abrt-handle-eve Tainted: G
W       4.6.0-0.rc0.git6.1.fc25.x86_64 #1
[   21.749073] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[   21.749077]  0000000000000086 0000000077cdecb8 ffff880221b13960
ffffffff8144ed43
[   21.749084]  ffffffff82af6c50 ffffffff82aebfe0 ffff880221b139a0
ffffffff8110e863
[   21.749090]  ffff880221b13a20 0000000000000001 ffff880221b6b0c0
ffff880221b6bd68
[   21.749097] Call Trace:
[   21.749102]  [<ffffffff8144ed43>] dump_stack+0x85/0xc2
[   21.749107]  [<ffffffff8110e863>] print_circular_bug+0x1e3/0x250
[   21.749112]  [<ffffffff81111cb4>] __lock_acquire+0x1a34/0x1c60
[   21.749117]  [<ffffffff8112f54d>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[   21.749122]  [<ffffffff81110d47>] ? __lock_acquire+0xac7/0x1c60
[   21.749126]  [<ffffffff811107cc>] ? __lock_acquire+0x54c/0x1c60
[   21.749131]  [<ffffffff811128ee>] lock_acquire+0xfe/0x1f0
[   21.749136]  [<ffffffff810e57f1>] ? try_to_wake_up+0x31/0x510
[   21.749140]  [<ffffffff818af7b6>] _raw_spin_lock_irqsave+0x56/0x90
[   21.749145]  [<ffffffff810e57f1>] ? try_to_wake_up+0x31/0x510
[   21.749149]  [<ffffffff810e57f1>] try_to_wake_up+0x31/0x510
[   21.749153]  [<ffffffff810e5d72>] default_wake_function+0x12/0x20
[   21.749158]  [<ffffffff812a7b13>] pollwake+0x73/0x90
[   21.749162]  [<ffffffff810e5d60>] ? wake_up_q+0x70/0x70
[   21.749166]  [<ffffffff811028b2>] __wake_up_common+0x52/0x90
[   21.749170]  [<ffffffff81102929>] __wake_up+0x39/0x50
[   21.749174]  [<ffffffff8157b442>] account.part.28+0x1d2/0x250
[   21.749179]  [<ffffffff8157cd5d>] extract_entropy+0x9d/0x530
[   21.749183]  [<ffffffff812fba6a>] ? load_elf_binary+0xc2a/0x1750
[   21.749187]  [<ffffffff812fba6a>] ? load_elf_binary+0xc2a/0x1750
[   21.749191]  [<ffffffff8157de21>] get_random_bytes+0x51/0x150
[   21.749195]  [<ffffffff812fba6a>] load_elf_binary+0xc2a/0x1750
[   21.749200]  [<ffffffff81297c77>] search_binary_handler+0x97/0x1c0
[   21.749205]  [<ffffffff81299882>] do_execveat_common.isra.36+0x6a2/0x9a0
[   21.749209]  [<ffffffff812997d5>] ? do_execveat_common.isra.36+0x5f5/0x9a0
[   21.749213]  [<ffffffff81299e6a>] SyS_execve+0x3a/0x50
[   21.749217]  [<ffffffff81004027>] do_syscall_64+0x67/0x190
[   21.749222]  [<ffffffff818afb3f>] entry_SYSCALL64_slow_path+0x25/0x25
