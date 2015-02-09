From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 09 Feb 2015 14:31:50 -0800
Message-ID: <54D93556.9050008@free.fr>
References: <54C8E125.3070905@free.fr> <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr> <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch> <54D576B1.4000001@free.fr> <54D903F6.3050608@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:25952 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379AbbBIWcI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Feb 2015 17:32:08 -0500
In-Reply-To: <54D903F6.3050608@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Stefan Agner <stefan@agner.ch>

Stephen Boyd wrote:

> Mason wrote:
>
>> config HAVE_ARM_TWD
>>    bool
>>    depends on SMP
>>    select CLKSRC_OF if OF
>>    help
>>      This options enables support for the ARM timer and watchdog unit
>>
>> One problem I see is that HAVE_ARM_TWD depends on SMP...
>>
>> One of the systems I want to support is UP (single-core Cortex A9).
>> Does that mean I should use an SMP kernel even for that system?
>> Or is there a different subsystem for UP systems?
>
> I don't see any problem with the TWD dropping the dependency on SMP. The
> code should work the same on a UP configuration and if that's the only
> timer you have that can deliver interrupts to your processor then it
> would be required. You'd still need a clocksource though, which the TWD
> doesn't provide.

I want to use as much mainlined code as possible. Thus, this means
(if my reasoning is not flawed) that I should use standard ARM
"services" (can't think of a better term) for which code is already
available in the kernel.

As for clock events, IIUC, I can choose either TWD or the global
timer (with a slight advantage to TWD). Are there other options?

(I probably have some platform-specific infrastructure available,
but I'm asking about standard support.)

My platform provides a 32-bit counter, ticking at a constant 27 MHz.
Reading this counter has a latency of roughly 70 ns (it has to go
over the system memory bus). I think this is good enough for both
the clock source and sched_clock, is it not?

So the plan would be:
- clocksource and sched_clock : 27 MHz, 32-bit counter, platform
- clockevents : TWD, standard

Regards.


For my own reference
http://elinux.org/Kernel_Timer_Systems
http://thread.gmane.org/gmane.linux.kernel/1062438 (not merged)
Message-ID: <20150206191419.GA8656@n2100.arm.linux.org.uk>

