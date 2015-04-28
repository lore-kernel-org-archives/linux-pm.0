From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Tue, 28 Apr 2015 14:04:56 +0100
Message-ID: <553F8578.5050109@arm.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>	<18575128.8R6Lp68k0Q@vostro.rjw.lan>	<CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>	<553F6236.5020300@linaro.org>	<553F6424.1090704@arm.com> <CAJZ5v0j+9gzpfZMyj1Pjnfr8VCoiFirD_U77-wRTn0vpM+Tz8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j+9gzpfZMyj1Pjnfr8VCoiFirD_U77-wRTn0vpM+Tz8g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 28/04/15 13:19, Rafael J. Wysocki wrote:
> On Tue, Apr 28, 2015 at 12:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

>>
>> At-least I observed issue only when I am using hardware broadcast timer.
>> It doesn't hang when I am using hrtimer as broadcast timer in which case
>> one of the cpu will be not enter deeper idle states that lose timer.
>> I will rerun on v4.1-rc1 and post the complete log.
>
> So the bug here is that cpuidle_enter() enables interrupts, so the
> assumption about them being not enabled made by
> tick_broadcast_oneshot_control() is actually not valid.
>
> It looks like we need to acquire the clockevents_lock at least in this
> particular case.  Let me see where to put it and I'll send a patch for
> testing.
>

Thanks for looking at this, I can also help in testing. Sending the 
complete log again with v4.1-rc1 if it's any useful.

Regards,
Sudeep

--->8

BUG: spinlock lockup suspected on CPU#0, swapper/0/0
  lock: tick_broadcast_lock+0x0/0x40, .magic: dead4ead, .owner: 
swapper/0/0, .owner_cpu: 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.0-rc1 #16
Hardware name: ARM-Versatile Express
[<c0014b1d>] (unwind_backtrace) from [<c0011659>] (show_stack+0x11/0x14)
[<c0011659>] (show_stack) from [<c05192ed>] (dump_stack+0x6d/0x78)
[<c05192ed>] (dump_stack) from [<c005c897>] (do_raw_spin_lock+0xc3/0x144)
[<c005c897>] (do_raw_spin_lock) from [<c00811f9>] 
(tick_handle_oneshot_broadcast+0x25/0x164)
[<c00811f9>] (tick_handle_oneshot_broadcast) from [<c001dd21>] 
(sp804_timer_interrupt+0x31/0x34)
[<c001dd21>] (sp804_timer_interrupt) from [<c0067ee1>] 
(handle_irq_event_percpu+0x45/0x154)
[<c0067ee1>] (handle_irq_event_percpu) from [<c006801f>] 
(handle_irq_event+0x2f/0x44)
[<c006801f>] (handle_irq_event) from [<c0069edb>] 
(handle_fasteoi_irq+0x6f/0xf0)
[<c0069edb>] (handle_fasteoi_irq) from [<c00677c7>] 
(generic_handle_irq+0x23/0x2c)
[<c00677c7>] (generic_handle_irq) from [<c0067a0d>] 
(__handle_domain_irq+0x45/0x84)
[<c0067a0d>] (__handle_domain_irq) from [<c0009303>] 
(gic_handle_irq+0x27/0x50)
[<c0009303>] (gic_handle_irq) from [<c0011eff>] (__irq_svc+0x3f/0x64)
Exception stack(0xc07ebf08 to 0xc07ebf50)
bf00:                   00000000 c1038814 00000001 00000001 c07f3f80 
ee78dec0
bf20: 00000000 c1038810 00000000 00000001 c07ebf88 c0520fc8 00000000 
c07ebf50
bf40: c008151d c02e104e 40000173 ffffffff
[<c0011eff>] (__irq_svc) from [<c02e104e>] (_test_and_clear_bit+0x26/0x48)
[<c02e104e>] (_test_and_clear_bit) from [<c008151d>] 
(tick_broadcast_oneshot_control+0x159/0x1ec)
[<c008151d>] (tick_broadcast_oneshot_control) from [<c0050273>] 
(cpu_startup_entry+0x2c3/0x2f8)
[<c0050273>] (cpu_startup_entry) from [<c0782a47>] 
(start_kernel+0x327/0x330)
BUG: spinlock lockup suspected on CPU#3, swapper/3/0
BUG: spinlock lockup suspected on CPU#4, swapper/4/0
  lock: tick_broadcast_lock+0x0/0x40, .magic: dead4ead, .owner: 
swapper/0/0, .owner_cpu: 0
CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.1.0-rc1 #16
Hardware name: ARM-Versatile Express
[<c0014b1d>] (unwind_backtrace) from [<c0011659>] (show_stack+0x11/0x14)
[<c0011659>] (show_stack) from [<c05192ed>] (dump_stack+0x6d/0x78)
BUG: spinlock lockup suspected on CPU#2, swapper/2/0
[<c05192ed>] (dump_stack) from [<c005c897>] (do_raw_spin_lock+0xc3/0x144)
  lock: tick_broadcast_lock+0x0/0x40, .magic: dead4ead, .owner: 
swapper/0/0, .owner_cpu: 0
[<c005c897>] (do_raw_spin_lock) from [<c0081409>] 
(tick_broadcast_oneshot_control+0x45/0x1ec)
[<c0081409>] (tick_broadcast_oneshot_control) from [<c0050273>] 
(cpu_startup_entry+0x2c3/0x2f8)
[<c0050273>] (cpu_startup_entry) from [<800093d1>] (0x800093d1)
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.1.0-rc1 #16
Hardware name: ARM-Versatile Express
[<c0014b1d>] (unwind_backtrace) from [<c0011659>] (show_stack+0x11/0x14)
[<c0011659>] (show_stack) from [<c05192ed>] (dump_stack+0x6d/0x78)
[<c05192ed>] (dump_stack) from [<c005c897>] (do_raw_spin_lock+0xc3/0x144)
[<c005c897>] (do_raw_spin_lock) from [<c0081409>] 
(tick_broadcast_oneshot_control+0x45/0x1ec)
[<c0081409>] (tick_broadcast_oneshot_control) from [<c0050273>] 
(cpu_startup_entry+0x2c3/0x2f8)
[<c0050273>] (cpu_startup_entry) from [<800093d1>] (0x800093d1)
  lock: tick_broadcast_lock+0x0/0x40, .magic: dead4ead, .owner: 
swapper/0/0, .owner_cpu: 0
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.1.0-rc1 #16
Hardware name: ARM-Versatile Express
[<c0014b1d>] (unwind_backtrace) from [<c0011659>] (show_stack+0x11/0x14)
[<c0011659>] (show_stack) from [<c05192ed>] (dump_stack+0x6d/0x78)
[<c05192ed>] (dump_stack) from [<c005c897>] (do_raw_spin_lock+0xc3/0x144)
[<c005c897>] (do_raw_spin_lock) from [<c0081409>] 
(tick_broadcast_oneshot_control+0x45/0x1ec)
[<c0081409>] (tick_broadcast_oneshot_control) from [<c0050273>] 
(cpu_startup_entry+0x2c3/0x2f8)
[<c0050273>] (cpu_startup_entry) from [<800093d1>] (0x800093d1)





