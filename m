From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: cpufreq regression due to dceff5c "cpufreq: fix serialization
 issues with freq change notifiers"
Date: Thu, 12 Sep 2013 10:27:24 -0600
Message-ID: <5231EB6C.6060504@wwwdotorg.org>
References: <5230ECB4.2090306@wwwdotorg.org> <13389782.ui3WXEBqQV@vostro.rjw.lan> <5230F46B.7070006@wwwdotorg.org> <CAKohpomqKgQumyEHQuuZ+SUHHULkJaAj5pgw1TFLVLsZzba_2Q@mail.gmail.com> <CAKohpo=pwSHF=WWmNfi6Mp3uKp-VdFki7+aXWdJNns=TSh_oGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34923 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3ILQfQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 12:35:16 -0400
In-Reply-To: <CAKohpo=pwSHF=WWmNfi6Mp3uKp-VdFki7+aXWdJNns=TSh_oGA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 09/11/2013 06:31 PM, Viresh Kumar wrote:
> On 12 September 2013 05:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> For the record this is where this problem is getting discussed:
>>
>> https://lkml.org/lkml/2013/9/9/270
> 
> Can you help us a bit here? That patch was reverted for now but we are planning
> to get it back and I have few patches which must help us here...
> 
> If you can try them on Tegra, it would be great!!
> All are present here:
> 
> https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/cpufreq-transition-ongoing

I'm not sure how relevant it is anymore given the discussion in response
to the patches you posted, but I tested anyway. Let me know if there's
anything else you need me to test; I'm a little confused with all the
overlapping/alternate cpufreq patches flying by recently. git branches
are easiest for me.

==========
Branch cpufreq-suspend-fix
Commit 8f777cc "cpufreq: use correct values of cpus in
__cpufreq_remove_dev_finish()"

That works fine; I can both suspend/resume multiple times, and force
cpufreq frequency, and everything appears to work.

==========
Branch cpufreq-transition-ongoing
Commit 42851e3 "cpufreq: fix notification serialization issues"

Forcing cpufreq appears to work fine for me in this branch. However,
suspend/resume has problems:

1) On the first resume, I see sysfs complaining:

> [   27.215037] Enabling non-boot CPUs ...
> [   27.226919] CPU1: Booted secondary processor
> [   27.232832] ------------[ cut here ]------------
> [   27.238026] WARNING: CPU: 0 PID: 810 at fs/sysfs/dir.c:530 sysfs_add_one+0x80/0xa0()
> [   27.246566] sysfs: cannot create duplicate filename '/devices/system/cpu/cpu0/cpufreq/stats'
> [   27.255679] Modules linked in:
> [   27.259222] CPU: 0 PID: 810 Comm: bash Not tainted 3.11.0-02563-gf7baf38 #144
> [   27.267097] [<c00156b4>] (unwind_backtrace+0x0/0xf8) from [<c00116d8>] (show_stack+0x10/0x14)
> [   27.276418] [<c00116d8>] (show_stack+0x10/0x14) from [<c050da30>] (dump_stack+0x80/0xc4)
> [   27.285201] [<c050da30>] (dump_stack+0x80/0xc4) from [<c0024474>] (warn_slowpath_common+0x64/0x88)
> [   27.294952] [<c0024474>] (warn_slowpath_common+0x64/0x88) from [<c002452c>] (warn_slowpath_fmt+0x30/0x40)
> [   27.305359] [<c002452c>] (warn_slowpath_fmt+0x30/0x40) from [<c011e8b4>] (sysfs_add_one+0x80/0xa0)
> [   27.315109] [<c011e8b4>] (sysfs_add_one+0x80/0xa0) from [<c011eab8>] (create_dir+0x5c/0xbc)
> [   27.324202] [<c011eab8>] (create_dir+0x5c/0xbc) from [<c011ed60>] (sysfs_create_subdir+0x24/0x2c)
> [   27.333858] [<c011ed60>] (sysfs_create_subdir+0x24/0x2c) from [<c0120590>] (internal_create_group+0x50/0x25c)
> [   27.344648] [<c0120590>] (internal_create_group+0x50/0x25c) from [<c034688c>] (cpufreq_stat_notifier_policy+0x98/0x28c)
> [   27.356402] [<c034688c>] (cpufreq_stat_notifier_policy+0x98/0x28c) from [<c0042f48>] (notifier_call_chain+0x44/0x84)
> [   27.367855] [<c0042f48>] (notifier_call_chain+0x44/0x84) from [<c004311c>] (__blocking_notifier_call_chain+0x48/0x60)
> [   27.379424] [<c004311c>] (__blocking_notifier_call_chain+0x48/0x60) from [<c004314c>] (blocking_notifier_call_chain+0x18/0x20)
> [   27.391830] [<c004314c>] (blocking_notifier_call_chain+0x18/0x20) from [<c0344fa8>] (__cpufreq_set_policy+0xac/0x1c0)
> [   27.403355] [<c0344fa8>] (__cpufreq_set_policy+0xac/0x1c0) from [<c03450ec>] (cpufreq_init_policy+0x30/0x70)
> [   27.414047] [<c03450ec>] (cpufreq_init_policy+0x30/0x70) from [<c0346228>] (__cpufreq_add_dev.isra.27+0x494/0x608)
> [   27.425291] [<c0346228>] (__cpufreq_add_dev.isra.27+0x494/0x608) from [<c0346414>] (cpufreq_cpu_callback+0x70/0x8c)
> [   27.436643] [<c0346414>] (cpufreq_cpu_callback+0x70/0x8c) from [<c0042f48>] (notifier_call_chain+0x44/0x84)
> [   27.447251] [<c0042f48>] (notifier_call_chain+0x44/0x84) from [<c0024590>] (__cpu_notify+0x28/0x44)
> [   27.457095] [<c0024590>] (__cpu_notify+0x28/0x44) from [<c0024818>] (_cpu_up+0xf0/0x140)
> [   27.465882] [<c0024818>] (_cpu_up+0xf0/0x140) from [<c05099d8>] (enable_nonboot_cpus+0x68/0xb0)
> [   27.475376] [<c05099d8>] (enable_nonboot_cpus+0x68/0xb0) from [<c005d7d8>] (suspend_devices_and_enter+0x19c/0x2f8)
> [   27.486652] [<c005d7d8>] (suspend_devices_and_enter+0x19c/0x2f8) from [<c005daa8>] (pm_suspend+0x174/0x1e8)
> [   27.497255] [<c005daa8>] (pm_suspend+0x174/0x1e8) from [<c005c928>] (state_store+0x6c/0xbc)
> [   27.506361] [<c005c928>] (state_store+0x6c/0xbc) from [<c01e4940>] (kobj_attr_store+0x14/0x20)
> [   27.515697] [<c01e4940>] (kobj_attr_store+0x14/0x20) from [<c011d3f0>] (sysfs_write_file+0x168/0x198)
> [   27.525731] [<c011d3f0>] (sysfs_write_file+0x168/0x198) from [<c00cbed0>] (vfs_write+0xb0/0x188)
> [   27.535301] [<c00cbed0>] (vfs_write+0xb0/0x188) from [<c00cc280>] (SyS_write+0x3c/0x70)
> [   27.544029] [<c00cc280>] (SyS_write+0x3c/0x70) from [<c000e540>] (ret_fast_syscall+0x0/0x30)
> [   27.553277] ---[ end trace f27199d855bd2598 ]---
> [   27.553883] ------------[ cut here ]------------
> [   27.553925] WARNING: CPU: 1 PID: 810 at fs/sysfs/dir.c:530 sysfs_add_one+0x80/0xa0()
> [   27.553935] sysfs: cannot create duplicate filename '/devices/system/cpu/cpu0/cpufreq/stats'
> [   27.553948] Modules linked in:
> [   27.553974] CPU: 1 PID: 810 Comm: bash Tainted: G        W    3.11.0-02563-gf7baf38 #144
> [   27.554042] [<c00156b4>] (unwind_backtrace+0x0/0xf8) from [<c00116d8>] (show_stack+0x10/0x14)
> [   27.554087] [<c00116d8>] (show_stack+0x10/0x14) from [<c050da30>] (dump_stack+0x80/0xc4)
> [   27.554126] [<c050da30>] (dump_stack+0x80/0xc4) from [<c0024474>] (warn_slowpath_common+0x64/0x88)
> [   27.554160] [<c0024474>] (warn_slowpath_common+0x64/0x88) from [<c002452c>] (warn_slowpath_fmt+0x30/0x40)
> [   27.554197] [<c002452c>] (warn_slowpath_fmt+0x30/0x40) from [<c011e8b4>] (sysfs_add_one+0x80/0xa0)
> [   27.554233] [<c011e8b4>] (sysfs_add_one+0x80/0xa0) from [<c011eab8>] (create_dir+0x5c/0xbc)
> [   27.554267] [<c011eab8>] (create_dir+0x5c/0xbc) from [<c011ed60>] (sysfs_create_subdir+0x24/0x2c)
> [   27.554308] [<c011ed60>] (sysfs_create_subdir+0x24/0x2c) from [<c0120590>] (internal_create_group+0x50/0x25c)
> [   27.554350] [<c0120590>] (internal_create_group+0x50/0x25c) from [<c034688c>] (cpufreq_stat_notifier_policy+0x98/0x28c)
> [   27.554401] [<c034688c>] (cpufreq_stat_notifier_policy+0x98/0x28c) from [<c0042f48>] (notifier_call_chain+0x44/0x84)
> [   27.554445] [<c0042f48>] (notifier_call_chain+0x44/0x84) from [<c004311c>] (__blocking_notifier_call_chain+0x48/0x60)
> [   27.554488] [<c004311c>] (__blocking_notifier_call_chain+0x48/0x60) from [<c004314c>] (blocking_notifier_call_chain+0x18/0x20)
> [   27.554526] [<c004314c>] (blocking_notifier_call_chain+0x18/0x20) from [<c0344fa8>] (__cpufreq_set_policy+0xac/0x1c0)
> [   27.554561] [<c0344fa8>] (__cpufreq_set_policy+0xac/0x1c0) from [<c0345a80>] (cpufreq_update_policy+0x90/0xec)
> [   27.554596] [<c0345a80>] (cpufreq_update_policy+0x90/0xec) from [<c034641c>] (cpufreq_cpu_callback+0x78/0x8c)
> [   27.554632] [<c034641c>] (cpufreq_cpu_callback+0x78/0x8c) from [<c0042f48>] (notifier_call_chain+0x44/0x84)
> [   27.554669] [<c0042f48>] (notifier_call_chain+0x44/0x84) from [<c0024590>] (__cpu_notify+0x28/0x44)
> [   27.554701] [<c0024590>] (__cpu_notify+0x28/0x44) from [<c0024818>] (_cpu_up+0xf0/0x140)
> [   27.554745] [<c0024818>] (_cpu_up+0xf0/0x140) from [<c05099d8>] (enable_nonboot_cpus+0x68/0xb0)
> [   27.554797] [<c05099d8>] (enable_nonboot_cpus+0x68/0xb0) from [<c005d7d8>] (suspend_devices_and_enter+0x19c/0x2f8)
> [   27.554840] [<c005d7d8>] (suspend_devices_and_enter+0x19c/0x2f8) from [<c005daa8>] (pm_suspend+0x174/0x1e8)
> [   27.554879] [<c005daa8>] (pm_suspend+0x174/0x1e8) from [<c005c928>] (state_store+0x6c/0xbc)
> [   27.554920] [<c005c928>] (state_store+0x6c/0xbc) from [<c01e4940>] (kobj_attr_store+0x14/0x20)
> [   27.554956] [<c01e4940>] (kobj_attr_store+0x14/0x20) from [<c011d3f0>] (sysfs_write_file+0x168/0x198)
> [   27.554992] [<c011d3f0>] (sysfs_write_file+0x168/0x198) from [<c00cbed0>] (vfs_write+0xb0/0x188)
> [   27.555027] [<c00cbed0>] (vfs_write+0xb0/0x188) from [<c00cc280>] (SyS_write+0x3c/0x70)
> [   27.555065] [<c00cc280>] (SyS_write+0x3c/0x70) from [<c000e540>] (ret_fast_syscall+0x0/0x30)
> [   27.555079] ---[ end trace f27199d855bd2599 ]---
> [   27.555151] CPU1 is up

2) On the second suspend, I see a crash; I think the same one we've been
discussing before:

> [   47.983000] Disabling non-boot CPUs ...
> [   48.003941] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [   48.029770] pgd = ed9cc000
> [   48.054576] [00000000] *pgd=2d978831, *pte=00000000, *ppte=00000000
> [   48.079572] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
> [   48.103709] Modules linked in:
> [   48.125565] CPU: 0 PID: 810 Comm: bash Tainted: G        W    3.11.0-02563-gf7baf38 #144
> [   48.153195] task: ed444a80 ti: edb0a000 task.ti: edb0a000
> [   48.178409] PC is at cpufreq_stat_notifier_policy+0x21c/0x28c
> [   48.204310] LR is at notifier_call_chain+0x44/0x84
> [   48.229463] pc : [<c0346a10>]    lr : [<c0042f48>]    psr: 60000113
> [   48.229463] sp : edb0bdb0  ip : 00000000  fp : 000aa2d8
> [   48.282667] r10: c0fec048  r9 : c073cf40  r8 : ee281c80
> [   48.309108] r7 : 00000004  r6 : 00000000  r5 : ee281c80  r4 : 00000000
> [   48.336891] r3 : 00000000  r2 : 008bc000  r1 : 00000000  r0 : 00000001
> [   48.364323] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [   48.392331] Control: 10c5387d  Table: 2d9cc04a  DAC: 00000015
> [   48.419065] Process bash (pid: 810, stack limit = 0xedb0a238)
> [   48.445723] Stack: (0xedb0bdb0 to 0xedb0c000)
> [   48.470712] bda0:                                     ed90da10 00000000 c073ccb4 ffffffff
> [   48.499809] bdc0: 00000000 00000000 00000004 ee281c80 c073cf40 c0fec048 000aa2d8 c0042f48
> [   48.529033] bde0: c076599c ffffffff ee281c80 00000004 00000001 c004311c 00000000 00200200
> [   48.558145] be00: ed444a80 ee281c80 00000001 00000000 c07c9068 c004314c 00000000 c034476c
> [   48.587155] be20: c07310ac c0344a7c 00000015 00000001 c07cb9e4 00000015 00000001 ee08ec40
> [   48.615942] be40: c073d804 c0346428 c03463a4 ffffffde edb0be88 c0042f48 00000001 c073c414
> [   48.644546] be60: c073ccb4 00000010 00000001 c0024590 edb0be88 c073c414 c073ccb4 c0509778
> [   48.672930] be80: 000aa2d8 c050c40c 00000021 edb0bea4 00000010 00000001 00000001 c073c414
> [   48.701175] bea0: c073ccb4 00000000 c0780080 c0024a84 c07837ac 00000000 00000003 c07837ac
> [   48.729214] bec0: c003ede0 c005d79c 000aa2d8 c050c40c c065d4d0 edb0beec 00000003 edb0beec
> [   48.757174] bee0: 00000000 00000003 c0516a80 00000003 ee33e000 ee08ec40 00000004 c005daa8
> [   48.785030] bf00: 0000006d 00000003 c06349e8 c005c928 00000004 00000004 ed86fac0 ed86fad8
> [   48.812686] bf20: edb0bf80 c05310c4 ee0e5868 c01e4940 00000004 c011d3f0 ed4e6140 00000004
> [   48.840184] bf40: 000ac408 edb0bf80 00000000 edb0a000 00000004 c00cbed0 edab6500 00000001
> [   48.867552] bf60: 0000000a 00000000 00000000 ed4e6140 000ac408 00000000 00000004 c00cc280
> [   48.894723] bf80: 00000000 00000000 ee1474c0 b6f61a78 00000004 000ac408 00000004 c000e6c4
> [   48.921639] bfa0: 00000000 c000e540 b6f61a78 00000004 00000001 000ac408 00000004 00000000
> [   48.948312] bfc0: b6f61a78 00000004 000ac408 00000004 be95e95c 000a6094 00000000 000aa2d8
> [   48.974906] bfe0: 00000000 be95e8dc b6ed1b77 b6f0825c 40070010 00000001 2e7f6821 2e7f6c21
> [   49.001489] [<c0346a10>] (cpufreq_stat_notifier_policy+0x21c/0x28c) from [<c0042f48>] (notifier_call_chain+0x44/0x84)
> [   49.031019] [<c0042f48>] (notifier_call_chain+0x44/0x84) from [<c004311c>] (__blocking_notifier_call_chain+0x48/0x60)
> [   49.060673] [<c004311c>] (__blocking_notifier_call_chain+0x48/0x60) from [<c004314c>] (blocking_notifier_call_chain+0x18/0x20)
> [   49.110276] [<c004314c>] (blocking_notifier_call_chain+0x18/0x20) from [<c0344a7c>] (__cpufreq_remove_dev_prepare.isra.11+0x140/0x27c)
> [   49.162054] [<c0344a7c>] (__cpufreq_remove_dev_prepare.isra.11+0x140/0x27c) from [<c0346428>] (cpufreq_cpu_callback+0x84/0x8c)
> [   49.214698] [<c0346428>] (cpufreq_cpu_callback+0x84/0x8c) from [<c0042f48>] (notifier_call_chain+0x44/0x84)
> [   49.245939] [<c0042f48>] (notifier_call_chain+0x44/0x84) from [<c0024590>] (__cpu_notify+0x28/0x44)
> [   49.276638] [<c0024590>] (__cpu_notify+0x28/0x44) from [<c0509778>] (_cpu_down+0x80/0x238)
> [   49.306512] [<c0509778>] (_cpu_down+0x80/0x238) from [<c0024a84>] (disable_nonboot_cpus+0x68/0xe8)
> [   49.337171] [<c0024a84>] (disable_nonboot_cpus+0x68/0xe8) from [<c005d79c>] (suspend_devices_and_enter+0x160/0x2f8)
> [   49.369662] [<c005d79c>] (suspend_devices_and_enter+0x160/0x2f8) from [<c005daa8>] (pm_suspend+0x174/0x1e8)
> [   49.401642] [<c005daa8>] (pm_suspend+0x174/0x1e8) from [<c005c928>] (state_store+0x6c/0xbc)
> [   49.432373] [<c005c928>] (state_store+0x6c/0xbc) from [<c01e4940>] (kobj_attr_store+0x14/0x20)
> [   49.463408] [<c01e4940>] (kobj_attr_store+0x14/0x20) from [<c011d3f0>] (sysfs_write_file+0x168/0x198)
> [   49.495146] [<c011d3f0>] (sysfs_write_file+0x168/0x198) from [<c00cbed0>] (vfs_write+0xb0/0x188)
> [   49.526605] [<c00cbed0>] (vfs_write+0xb0/0x188) from [<c00cc280>] (SyS_write+0x3c/0x70)
> [   49.557445] [<c00cc280>] (SyS_write+0x3c/0x70) from [<c000e540>] (ret_fast_syscall+0x0/0x30)
> [   49.588767] Code: e5950010 e7922100 e783c002 e595300c (e5813000) 
> [   49.618011] ---[ end trace f27199d855bd259b ]---

