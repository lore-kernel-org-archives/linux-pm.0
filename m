From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 09 Feb 2015 15:50:12 -0800
Message-ID: <54D947B4.4080401@free.fr>
References: <54C8E125.3070905@free.fr> <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr> <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch> <54D576B1.4000001@free.fr> <54D903F6.3050608@codeaurora.org> <54D93556.9050008@free.fr> <54D93FFA.3090506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <54D93FFA.3090506@codeaurora.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Stefan Agner <stefan@agner.ch>
List-Id: linux-pm@vger.kernel.org

Stephen Boyd wrote:

> Mason wrote:
>
>> My platform provides a 32-bit counter, ticking at a constant 27 MHz.
>> Reading this counter has a latency of roughly 70 ns (it has to go
>> over the system memory bus). I think this is good enough for both
>> the clock source and sched_clock, is it not?
>>
>> So the plan would be:
>> - clocksource and sched_clock : 27 MHz, 32-bit counter, platform
>> - clockevents : TWD, standard
>
> Yep, that sounds like a good plan. If your platform has the ARM global
> timer (drivers/clocksource/arm_global_timer.c) then you don't need
> anything besides that timer because it provides both the clocksource,
> sched_clock, and clockevents. Sounds like you don't have that timer

I'm using Cortex A9, so I do have the global timer (AFAIU).

However, I don't think I can safely use it as a clock source because
I'm also using cpufreq, and I don't think the arm_global_timer driver
handles CPU frequency updates, while the TWD driver does (?)

/*
  * Updates clockevent frequency when the cpu frequency changes.
  * Called on the cpu that is changing frequency with interrupts disabled.
  */

"The Interrupt Controller, global timer, private timers, and watchdogs
are clocked with PERIPHCLK." And PERIPHCLK is tied to CLK, which is
modified by cpufreq. I didn't see any code in the arm_global_timer
driver to deal with with that.

Did I overlook something fundamental?

> though, so you have to write a driver for your custom platform timer and
> at least hook up clocksource and sched_clock to it. If you have
> interrupts with your platform timer you can skip out on TWD and also
> register a clockevent in your platform timer driver.

Registering a clock source or a sched_clock seems straight-forward.
All I need to provide is a function to read the platform counter.

However, why would I skip out on TWD?
(I'm trying to minimize code needed for the port.)

Regards.

