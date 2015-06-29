From: pang.xunlei@zte.com.cn
Subject: Re: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware
 scheduling
Date: Mon, 29 Jun 2015 17:06:18 +0800
Message-ID: <OF2A9F9D14.FDD9C66B-ON48257E73.003184BC-48257E73.0031FA3D@zte.com.cn>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>	<5552799E.2060507@nvidia.com>
	<20150513134753.GA26396@e105550-lin.cambridge.arm.com> <CAEZQSscFKoang2X4E82xSXddcij=Ym5wyLGDLZwiwy5czJqAZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEZQSscFKoang2X4E82xSXddcij=Ym5wyLGDLZwiwy5czJqAZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abel Vesa <abelvesa@linux.com>
Cc: Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Morten Rasmussen <morten.rasmussen@arm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, Peter Boonstoppel <pboonstoppel@nvidia.com>, "peterz@infradead.org" <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sai Gurrappadi <sgurrappadi@nvidia.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Abel,

Abel Vesa <abelvesa@linux.com> wrote 2015-06-29 AM 04:26:31:
> 
> Re: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware 
scheduling
> 
> Hi,
> 
> So I tried to play around a little bit with this patchset. I did a
> checkout from:
> 
> git://linux-arm.org/linux-power.git energy_model_rfc_v4
> 
> and then, when I tried to enable the ENERGY_AWARE from sysfs inside
> qemu (x86_64) and I got this:
> 
> [69452.750245] BUG: unable to handle kernel paging request at 
ffff88009d3fb958
> [69452.750245] IP: [<ffffffff8107b8b5>] try_to_wake_up+0x125/0x310
> [69452.750245] PGD 2155067 PUD 0
> [69452.750245] Oops: 0000 [#1] SMP
> [69452.750245] Modules linked in:
> [69452.750245] CPU: 0 PID: 1007 Comm: sh Not tainted 4.1.0-rc2+ #8
> [69452.750245] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.8.1-20150318_183358- 04/01/2014
> [69452.750245] task: ffff88007c9e5aa0 ti: ffff88007be0c000 task.ti:
> ffff88007be0c000
> [69452.750245] RIP: 0010:[<ffffffff8107b8b5>]  [<ffffffff8107b8b5>]
> try_to_wake_up+0x125/0x310
> [69452.750245] RSP: 0000:ffff88007fc03d78  EFLAGS: 00000092
> [69452.750245] RAX: 00000000ffffffff RBX: 00000000ffffffff RCX: 
> 0000000000015a40
> [69452.750245] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
> ffff88007d005000
> [69452.750245] RBP: ffff88007fc03dc8 R08: 0000000000000400 R09: 
> 0000000000000000
> [69452.750245] R10: 0000000000000000 R11: 0000000000000000 R12: 
> 0000000000015a40
> [69452.750245] R13: ffff88007d3fbdaa R14: 0000000000000000 R15: 
> ffff88007d3fb660
> [69452.750245] FS:  00007f8a3c9f0700(0000) GS:ffff88007fc00000(0000)
> knlGS:0000000000000000
> [69452.750245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [69452.750245] CR2: ffff88009d3fb958 CR3: 000000007c32c000 CR4: 
> 00000000000006f0
> [69452.750245] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [69452.750245] DR3: 0000000000000000 DR6: 0000000000000000 DR7: 
> 0000000000000000
> [69452.750245] Stack:
> [69452.750245]  ffff88007fc15aa8 ffff88007c9e5b08 ffff88007fc15aa8
> 0000000000000046
> [69452.750245]  ffff88007fc03e08 ffff88007c83fe60 ffffffff81e3c8a8
> ffffffff81e3c890
> [69452.750245]  0000000000000000 0000000000000003 ffff88007fc03dd8
> ffffffff8107bb8d
> [69452.750245] Call Trace:
> [69452.750245]  <IRQ>
> [69452.750245]  [<ffffffff8107bb8d>] default_wake_function+0xd/0x10
> [69452.750245]  [<ffffffff8108ed21>] autoremove_wake_function+0x11/0x40
> [69452.750245]  [<ffffffff8108e6b5>] __wake_up_common+0x55/0x90
> [69452.750245]  [<ffffffff8108e728>] __wake_up+0x38/0x60
> [69452.750245]  [<ffffffff810ab062>] rcu_gp_kthread_wake+0x42/0x50
> [69452.750245]  [<ffffffff810acd9f>] rcu_process_callbacks+0x2ef/0x5e0
> [69452.750245]  [<ffffffff81056e0f>] __do_softirq+0x9f/0x280
> [69452.750245]  [<ffffffff81057145>] irq_exit+0xa5/0xb0
> [69452.750245]  [<ffffffff81038bd1>] smp_apic_timer_interrupt+0x41/0x50
> [69452.750245]  [<ffffffff818ae5bb>] apic_timer_interrupt+0x6b/0x70
> [69452.750245]  <EOI>
> [69452.750245] Code: 4c 89 ff ff d0 41 83 bf f8 02 00 00 01 41 8b 5f
> 48 7e 16 49 8b 47 60 89 de 44 89 f1 ba 10 00 00 00 4c 89 ff ff 50 40
> 89 c3 89 d8 <49> 0f a3 87 00 03 00 00 19 d2 85 d2 0f 84 59 01 00 00 48
> 8b 15
> [69452.750245] RIP  [<ffffffff8107b8b5>] try_to_wake_up+0x125/0x310
> [69452.750245]  RSP <ffff88007fc03d78>
> [69452.750245] CR2: ffff88009d3fb958
> [69452.750245] ---[ end trace 9b4570a93c243e98 ]---
> [69452.750245] Kernel panic - not syncing: Fatal exception in interrupt
> [69452.750245] Kernel Offset: disabled
> [69452.750245] ---[ end Kernel panic - not syncing: Fatal exception 
> in interrupt
> 
> and then I did a disassable from kgdb and I got this:
> 
> 0xffffffff8107b8ae <+286>:   callq  *0x40(%rax)
> 0xffffffff8107b8b1 <+289>:   mov    %eax,%ebx
> 0xffffffff8107b8b3 <+291>:   mov    %ebx,%eax
> 0xffffffff8107b8b5 <+293>:   bt     %rax,0x300(%r15)
> 0xffffffff8107b8bd <+301>:   sbb    %edx,%edx
> 
> and then I did a objdump and got this:
> 
> static inline
> int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int
> wake_flags)
> {
>         if (p->nr_cpus_allowed > 1)
>     7dcb:       7e 16                   jle    7de3 
<try_to_wake_up+0x123>
>                 cpu = p->sched_class->select_task_rq(p, cpu, sd_flags,
> wake_flags);
>     7dcd:       49 8b 47 60             mov    0x60(%r15),%rax
>     7dd1:       89 de                   mov    %ebx,%esi
>     7dd3:       44 89 f1                mov    %r14d,%ecx
>     7dd6:       ba 10 00 00 00          mov    $0x10,%edx
>     7ddb:       4c 89 ff                mov    %r15,%rdi
>     7dde:       ff 50 40                callq  *0x40(%rax)
>     7de1:       89 c3                   mov    %eax,%ebx
>     7de3:       89 d8                   mov    %ebx,%eax
>     7de5:       49 0f a3 87 00 03 00    bt     %rax,0x300(%r15)
>     7dec:       00
>     7ded:       19 d2                   sbb    %edx,%edx
>          * Since this is common to all placement strategies, this lives 
here.
>          *
>          * [ this allows ->select_task() to simply return task_cpu(p) 
and
>          *   not worry about this generic constraint ]
>          */
>         if (unlikely(!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||
>     7def:       85 d2                   test   %edx,%edx
> 
> I wasn't able to determine the cause from the line:
> 
> 7de5:       49 0f a3 87 00 03 00    bt     %rax,0x300(%r15)
> 
> Finally, the question I have is: Could this happen because I'm running
> it from qemu?
> 
> I hope all this info helps.

I've met this as well.

You can try to change "return -1;" in energy_aware_wake_cpu() to "return 
target_cpu;"
hope this may help.

-Xunlei

> 
> Thanks,
> Abel.

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (and any attachment transmitted herewith) is privileged and confidential and is intended for the exclusive use of the addressee(s).  If you are not an intended recipient, any disclosure, reproduction, distribution or other dissemination or use of the information contained is strictly prohibited.  If you have received this mail in error, please delete it and notify us immediately.
