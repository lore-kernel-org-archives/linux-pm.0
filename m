From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Tue, 28 Apr 2015 14:58:37 +0100
Message-ID: <553F920D.6090404@arm.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <8051605.iKEaLUIlGb@vostro.rjw.lan> <4162206.ldgadmp1aL@vostro.rjw.lan> <21687949.Wq8byZT4f8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21687949.Wq8byZT4f8@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 28/04/15 15:14, Rafael J. Wysocki wrote:
> On Tuesday, April 28, 2015 03:37:44 PM Rafael J. Wysocki wrote:
>> On Tuesday, April 28, 2015 03:31:54 PM Rafael J. Wysocki wrote:
>>> On Tuesday, April 28, 2015 02:37:10 PM Linus Walleij wrote:
>>>> On Tue, Apr 28, 2015 at 2:19 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>> Sudeep:
>>>>>> At-least I observed issue only when I am using hardware broadcast timer.
>>>>>> It doesn't hang when I am using hrtimer as broadcast timer in which case
>>>>>> one of the cpu will be not enter deeper idle states that lose timer.
>>>>>> I will rerun on v4.1-rc1 and post the complete log.
>>>>>
>>>>> So the bug here is that cpuidle_enter() enables interrupts, so the
>>>>> assumption about them being not enabled made by
>>>>> tick_broadcast_oneshot_control() is actually not valid.
>>>>>
>>>>> It looks like we need to acquire the clockevents_lock at least in this
>>>>> particular case.  Let me see where to put it and I'll send a patch for
>>>>> testing.
>>>>
>>>> Aha that looks very much like it. Put me on the patch and I'll
>>>> take it for a spin.
>>>
>>> OK, so something like the below for starters (the _irqsave variant is used to
>>> avoid adding one more WARN_ON(irqs_disabled()) in there).
>>>
>>> I haven't tested it, but then I can't reproduce the original issue in the
>>> first place.
>>
>> Of course, the whole "broadcast" thing could be done from cpuidle_enter()
>> in the first place, but then we could not avoid the problem with the cpuidle
>> *callback* enabling interrupts possibly in there anyway (not to mention the
>> "coupled" stuff).
>
> That said, if the given state is marked with CPUIDLE_FLAG_TIMER_STOP, I really
> wouldn't expect it to re-enable interrupts on exit and the "coupled" thing
> seems to be fundamentally at odds with that flag either.
>
> So it should be possible to move the "broadcast" logic into the cpuidle layer,
> which I'm going to try to do.
>

Makes sense.

> Please test the patch I've sent, though, as it should bring the code back to
> where it was before the clockevents_notify() removal and it'd be good to verify
> that.
>

I tested your patch and it works now. Anyways I am continuing to run
stress tests on my board. I will report if I find any issues.

Regards,
Sudeep
