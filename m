From: Stefan Agner <stefan@agner.ch>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Fri, 06 Feb 2015 21:25:44 +0100
Message-ID: <e028a4eb604a491f4438557f4a1373ef@agner.ch>
References: <54C8E125.3070905@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:55245 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbBFU0N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Feb 2015 15:26:13 -0500
In-Reply-To: <54C8E125.3070905@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DT <devicetree@vger.kernel.org>

On 2015-01-28 14:16, Mason wrote:
> Hello,
> 
> I am swimming in a sea of confusion, and am hoping someone would toss
> me a life-jacket (of enlightenment). Please forgive me if some of my
> questions are poorly asked or appear in seemingly random order.
> 
> Working on a Cortex A9 based SoC, I set out to "clean up" the platform
> specific timer code, by using as much generic framework as possible.
> (Right now, there's a lot of "redundant" code in the mach dir.)
> 
> 
> Q1. the {n,u,m}delay function family
> 
> arch/arm/include/asm/delay.h mentions
> "Delay routines, using a pre-computed "loops_per_second" value."
> *BUT* if the frequency changes dynamically (thanks to cpufreq)
> the "loops_per_second" value cannot be pre-computed, as it would
> change dynamically too, right?
> 
> Looking at arch/arm/lib/delay.c it seems the default implementation
> is a busy loop (in delay-loop.S) which looks up "loops_per_jiffy"
> in the prolog to determine the number of times to loop, right?
> 
> http://lxr.free-electrons.com/source/arch/arm/lib/delay-loop.S
> 
> (Side issue, why is the loop unrolled in __loop_delay? What is the
> point of unrolling a busy loop? This is commented code however.)
> 
> What happens if loops_per_jiffy changes while one core is in the
> busy loop? It seems we might exit the loop too early, which could
> break some drivers with some weird heisenbug, no?
> 
> Also, is the update of loops_per_jiffy atomic? Is it possible that
> if one core reads it while another updates it, we get garbage?
> 
> I suppose this is one reason why the default functions are overridden
> by register_current_timer_delay(&arch_delay_timer) right? I think the
> property of a timer is that its frequency doesn't change, even if the
> CPU's frequency changes? So we are still busy looping, but we are
> checking the actual time spent in the loop, whatever the cpufreq?
> 
> Reference
> https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> 
> 
> Q2. Cortex A9 global and private timers
> 
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407f/CIHGECHJ.html
> 
> (What are private timers used for?)
> 
> In my platform-specific code, there is a config option to choose between
> 
> 1) the ARM global timer
> 2) a platform-specific timer (timer0)
> 
> I noticed that there is generic code to support the global timer in
> drivers/clocksource/arm_global_timer.c
> 
> config ARM_GLOBAL_TIMER
> bool
> select CLKSRC_OF if OF
> help
>   This options enables support for the ARM global timer unit
> 
> config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> bool
> depends on ARM_GLOBAL_TIMER
> default y
> help
>  Use ARM global timer clock source as sched_clock
> 
> I was thinking it would be better to use the "standard" option (ARM
> global timer)
> as it is "officially" supported in the vanilla kernel. So less code to write and
> to debug, and it has likely received more testing. Why would one rely on
> platform-specific timers then?
> 
> Are high-resolution timers supported with the global timer?
> 
> 
> Q3. Using the generic global timer implementation
> 
> So, how do I use that implementation?
> (Is someone other than STMicro using it?)
> 
> I see:
> 
> static void __init global_timer_of_register(struct device_node *np)
> CLOCKSOURCE_OF_DECLARE(arm_gt, "arm,cortex-a9-global-timer",
> global_timer_of_register);
> 
> OF stands for open firmware, yes?
> So is this related to device tree?
> 
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/arm/global_timer.txt
> 
> This file makes no sense to me.
> 
> - interrupts : One interrupt to each core
> interrupts = <1 13 0xf01>;
> what are 1 13 0xf01 ??
> 
> - clocks : Should be phandle to a clock.
> clocks = <&arm_periph_clk>;
> 
> For my (old) 3.14 kernel, I found this:
> 
>     /*
>      * ARM Peripheral clock for timers
>      */
>     arm_periph_clk: arm_periph_clk {
>       #clock-cells = <0>;
>       compatible = "fixed-clock";
>       clock-frequency = <600000000>;
>     };
> 
> But it looks like the definitions have moved around since then?

Hi Mason,

Just recently I added support of ARM global timer as clocksource for
Vybrid SoC. This SoC doesn't use cpufreq, hence it is safe to use the
ARM global timer. The nice thing of device tree is, the patch to add
support for that did not change a single line of code:

http://thread.gmane.org/gmane.linux.kernel/1794460

--
Stefan

> 
> This device tree concept is too much to swallow in a single serving.
> Please tell me if I'm going down the correct rabbit hole, and I'll
> do some LWN readings to try to wrap my mind around the concept.
> 
> 
> Anyway, if anyone can help me out on some of these topics, I'd be
> eternally grateful.
> 
> Regards.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
