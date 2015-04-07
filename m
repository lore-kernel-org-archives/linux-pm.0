From: Sebastian Parschauer <sebastian.riemer@profitbricks.com>
Subject: Regarding 0b89e9aa "cpuidle: delay enabling interrupts until all
 coupled CPUs leave idle"
Date: Tue, 07 Apr 2015 15:09:03 +0200
Message-ID: <5523D6EF.4000606@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33660 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbbDGNJG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 09:09:06 -0400
Received: by wiax7 with SMTP id x7so10411633wia.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2015 06:09:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-pm@vger.kernel.org

Hi Paul,

we are using the acpi_idle driver with AMD Opteron CPUs and are
witnessing kernel panics with instruction pointer corruption. Our guess
is that it's either cpuidle or CPB (Core Performance Boost) related. We
had it with our 3.4 kernels before but with our 3.12 kernels it became
much more frequent.

Your commit 0b89e9aa ("cpuidle: delay enabling interrupts until all
coupled CPUs") seems to be related and we are thinking about
cherry-picking it to our 3.12 kernels.

Is it safe doing so from your experience?

I've read your comment about the commit here:
http://marc.info/?l=linux-pm&m=139453090007900&w=2

But I need more information.
Did you also witness kernel panics with IP corruption?

Thanks,
Sebastian


Our call traces from netconsole look like the following but nothing
calls "setup_percpu_irq". The stack and the call trace seem to be
intact. So this must be an RIP corruption.

> BUG: unable to handle kernel NULL pointer dereference NULL pointer dereference at 0000000000000070
> IP: [<ffffffff81091924>] setup_percpu_irq+0x34/0x90
> PGD 0 
> Oops: 0000 [#1] SMP
> Modules linked in: ...
> CPU: 4 PID: 61915 Comm: kvm Tainted: G           O 3.12.38-1-pserver #1
> Hardware name: Supermicro SBA-7142G-T4/BHQGE, BIOS 3.00       10/24/2012
> task: ffff8810020f6820 ti: ffff880fc3e0a000 task.ti: ffff880fc3e0a000
> RIP: 0010:[<ffffffff81091924>] setup_percpu_irq+0x34/0x90
> RSP: 0018:ffff880807d03ea0  EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffffffff81c13580 RCX: 000000000000f1db
> RDX: ffff880807d0c2b8 RSI: ffff880807d0c278 RDI: ffffffff81c13580
> RBP: ffff880807d03ee8 R08: 000000000000f1db R09: 0000000000000000
> R10: fffff8027744f140 R11: 7fffffffffffffff R12: 0000000007865304
> R13: ffff880807d0c238 R14: 000000005515ef6b R15: ffff880807d0c278
> FS:  00000000b641e000(0053) GS:ffff880807d00000(002b) knlGS:00007ff7b641c000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000070 CR3: 0000000ef3739000 CR4: 00000000000407e0
> Stack:
>  ffffffff81097e1a 0000000000000001 ffff880807d0c2b8 0000000000000046
>  0000000000000001 ffff880807d0c180 0000000000000001 0000000000000001
>  ffff8807c331bc00 ffff880807d03f68 ffffffff81069ccd ffff8808044affd8
> Call Trace:
>  <IRQ> 
>  [<ffffffff81097e1a>] ? ktime_get_update_offsets+0x4a/0xf0
>  [<ffffffff81069ccd>] hrtimer_interrupt+0x7d/0x230
>  [<ffffffffa1172310>] ? 0xffffffffa117230f
>  [<ffffffff8102d906>] local_apic_timer_interrupt+0x36/0x60
>  [<ffffffff8102df5e>] smp_apic_timer_interrupt+0x3e/0x60
>  [<ffffffff8171dbca>] apic_timer_interrupt+0x6a/0x70
>  <EOI> 
> 
>  [<ffffffffa11726f6>] ? svm_read_l1_tsc+0x3e6/0x6f00 [kvm_amd]
>  [<ffffffffa06a85ae>] ? kvm_arch_vcpu_ioctl_run+0x8de/0xf90 [kvm]
>  [<ffffffff810a08ff>] ? futex_wake+0xff/0x120
>  [<ffffffffa06a8cde>] ? kvm_put_guest_fpu+0x7e/0xe0 [kvm]
>  [<ffffffffa06a3562>] ? kvm_arch_vcpu_load+0x52/0x1b0 [kvm]
>  [<ffffffffa0692b7c>] vcpu_put+0x34c/0x6c0 [kvm]
>  [<ffffffffa068f150>] ? kvm_is_visible_gfn+0xb0/0x13b0 [kvm]
>  [<ffffffff8116a0c7>] do_vfs_ioctl+0x87/0x510
>  [<ffffffff8107938e>] ? pick_next_task_fair+0x6e/0x1a0
>  [<ffffffff810a30f3>] ? SyS_futex+0x93/0x1a0
>  [<ffffffff8116a5e1>] SyS_ioctl+0x91/0xb0
>  [<ffffffff8171d022>] system_call_fastpath+0x16/0x1b
> Code: ...
> RIP [<ffffffff81091924>] setup_percpu_irq+0x34/0x90
>  RSP <ffff880807d03ea0>
> CR2: 0000000000000070
> Kernel panic - not syncing: Fatal exception in interrupt
