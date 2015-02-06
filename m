From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Fri, 06 Feb 2015 10:37:32 -0800
Message-ID: <54D509EC.7020708@free.fr>
References: <54C8E125.3070905@free.fr> <20150203120925.GM8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:34245 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732AbbBFSht (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Feb 2015 13:37:49 -0500
In-Reply-To: <20150203120925.GM8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Mike Turquette <mturquette@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>

Hello Russell,

First of all, thanks for the insight you've been providing. It helps a lot.
(And thanks to everyone who's been answering some of my questions.)

Russell King - ARM Linux wrote:

> On Wed, Jan 28, 2015 at 02:16:21PM +0100, Mason wrote:
>
>> [snip udelay discussion]
>>
>> Q2. Cortex A9 global and private timers
>>
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407f/CIHGECHJ.html
>>
>> (What are private timers used for?)
>
> The per-cpu private timers are mostly scheduling of threads.

Hmmm, I'm confused (again).

CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK means "use the global timer
for the scheduler clock", right? In that case, are the local timers
unused by Linux?

#ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
   sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
#endif

Is there generic code to set up local timers? (If so, where?)
sched_clock_register only seems to appear in machine-specific code.

What are the pros/cons of global timer vs local timers?
Or is such a question irrelevant?
(Because they are used for different purposes?)

>> In my platform-specific code, there is a config option to choose between
>>
>> 1) the ARM global timer
>> 2) a platform-specific timer (timer0)
>
> Most platforms implement their own timer, because its really sexy for
> hardware engineers to create yet another different timer implementation
> which is soo much better than every other timer implementation that has
> already been created.  You wouldn't believe how many different ways that
> there are to create a timer - and we still have people coming up with
> new novel implementations!

There is trouble in paradise. I was planning to give the global timer a try,
instead of the platform-specific timer, until I noticed: "The global timer
is clocked by PERIPHCLK." And it turns PERIPHCLK is connected to the SoC's
CPU_CLK (the clock that drives the CPU cores); the same clock that is managed
by cpufreq. I imagine it's double plus ungood for precise time-keeping to
have frequency changes of the clocksource input?

>> Q3. Using the generic global timer implementation
>>
>> So, how do I use that implementation?
>> (Is someone other than STMicro using it?)

To answer that question:

$ grep -rn ARM_GLOBAL_TIMER | grep -v SCHED_CLOCK
arch/arm/mach-vexpress/Kconfig:7:	select ARM_GLOBAL_TIMER
arch/arm/mach-bcm/Kconfig:87:	select ARM_GLOBAL_TIMER
arch/arm/mach-bcm/Kconfig:108:	select ARM_GLOBAL_TIMER
arch/arm/mach-rockchip/Kconfig:14:	select ARM_GLOBAL_TIMER
arch/arm/mach-sti/Kconfig:4:	select ARM_GLOBAL_TIMER
arch/arm/mach-zynq/Kconfig:6:	select ARM_GLOBAL_TIMER if !CPU_FREQ

There are indeed a few users; also I wonder why mach-zynq enables
ARM_GLOBAL_TIMER only if !CPU_FREQ. (Could it be that they have
the CPU CLOCK driving PERIPHCLK?)

Regards.
