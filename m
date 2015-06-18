From: Sebastian Parschauer <sebastian.riemer@profitbricks.com>
Subject: Re: cpuidle: Kernel panics with AMD Opteron 6300 entering C2 - clock
 related
Date: Thu, 18 Jun 2015 12:52:12 +0200
Message-ID: <5582A2DC.7060001@profitbricks.com>
References: <55814696.1050803@profitbricks.com> <55828DBD.5000109@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35366 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbFRKwP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 06:52:15 -0400
Received: by wgbhy7 with SMTP id hy7so60298955wgb.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 03:52:14 -0700 (PDT)
In-Reply-To: <55828DBD.5000109@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Sebastian Parschauer <sebastian.riemer@profitbricks.com>

On 18.06.2015 11:22, Daniel Lezcano wrote:
> On 06/17/2015 12:06 PM, Sebastian Parschauer wrote:
>> Hi cpuidle maintainers,
>>
>> we notice kernel panics with CPUs from the AMD Opteron 6300 series and
>> kernel 3.12 when entering C2. In that C-state the clock is shut down but
>> the flag CPUIDLE_FLAG_TIMER_STOP isn't set. We use the TSC clock source
>> for performance as our servers host KVM VMs. During the panics
>> interrupts are enabled again and the timer interrupt corrupts the
>> instruction pointer and/or the stack pointer.
>>
>> Would it help to set the flag CPUIDLE_FLAG_TIMER_STOP for C2?
>> Or how to fix this?
> 
> Did you try the flag ? Does it fix it ?

Thanks for your reply. Unfortunately we can't roll out new kernels fast
(VMs have to be migrated). But we've disabled the C2 state via sysfs for
all CPU cores and all servers and had one more kernel panic with the
same call trace although C2 was (or should have been) disabled. We use
the menu governor and a v3.12.40 kernel.

It's strange to me coming into the same code path with state index 2 as
parameter again. I think I'll prepare a kernel with some debug messages
when transitioning from one state to another and deploy it to a test system.

Is there any better method to debug the cpuidle driver?

How do you guys test it?

Can we provide any missing additional information?

Maybe something else corrupts the memory in an interrupt and the cpuidle
driver is just the one noticing an unrelated problem.

>> ==========
>> Additional debug info:
>>
>> BUG: unable to handle kernel NULL pointer dereference at           (null)
>> IP: [<          (null)>]           (null)
>> ...
>> Call trace:
>> [<ffffffff815af9b5>] cpuidle_idle_call+0xc5/0x150
>> [<ffffffff8100b529>] arch_cpu_idle+0x9/0x20
>> [<ffffffff81092e6f>] cpu_startup_entry+0xaf/0x240
>> [<ffffffff8102df4b>] start_secondary+0x1db/0x240
>>
>> The CPUs provide three C-states:
>> 0: POLL
>> 1: C1
>> 2: C2
>>
>> C2 information from the crash dump:
>>
>>> {
>>>        name = "C2\000\000\000\000\000\000\000\000\000\000\000\000\000",
>>>        desc = "ACPI IOPORT
>>> 0x815\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
>>>        flags = 1,
>>>        exit_latency = 100,
>>>        power_usage = 0,
>>>        target_residency = 200,
>>>        disabled = false,
>>>        enter = 0xffffffffa00ab026 <acpi_idle_enter_simple>,
>>>        enter_dead = 0xffffffffa00aa39c <acpi_idle_play_dead>
>>> }
>>
>> Assembly level analysis:
>>
>>> RDX: 0000000225c17d03
>>
>> So EDX is 00000002 and that's the entered state C2.
>>
>>> RDI: ffffffff81c15540
>>> ..
>>> crash> info symbol 0xffffffff81c15540
>>> clocksource_tsc in section .data
>>>
>>> crash> disassemble cpuidle_enter_state
>>> ...
>>>     0xffffffff815af5fc <+60>:    callq  0xffffffff8109b360 <ktime_get>
>>>     0xffffffff815af601 <+65>:    sti
>>>     0xffffffff815af602 <+66>:    sub    %r13,%rax <- here rdi still
>>> points to clocksource_tsc
>>>     0xffffffff815af605 <+69>:    mov    %rax,%rdi <- rdi is
>>> overwritten by the ktime_get return address
> 
> 

