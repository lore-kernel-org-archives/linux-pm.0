From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 09 Feb 2015 15:17:14 -0800
Message-ID: <54D93FFA.3090506@codeaurora.org>
References: <54C8E125.3070905@free.fr> <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr> <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch> <54D576B1.4000001@free.fr> <54D903F6.3050608@codeaurora.org> <54D93556.9050008@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34050 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759672AbbBIXRQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 18:17:16 -0500
In-Reply-To: <54D93556.9050008@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Stefan Agner <stefan@agner.ch>

On 02/09/15 14:31, Mason wrote:
>
> My platform provides a 32-bit counter, ticking at a constant 27 MHz.
> Reading this counter has a latency of roughly 70 ns (it has to go
> over the system memory bus). I think this is good enough for both
> the clock source and sched_clock, is it not?
>
> So the plan would be:
> - clocksource and sched_clock : 27 MHz, 32-bit counter, platform
> - clockevents : TWD, standard

Yep, that sounds like a good plan. If your platform has the ARM global
timer (drivers/clocksource/arm_global_timer.c) then you don't need
anything besides that timer because it provides both the clocksource,
sched_clock, and clockevents. Sounds like you don't have that timer
though, so you have to write a driver for your custom platform timer and
at least hook up clocksource and sched_clock to it. If you have
interrupts with your platform timer you can skip out on TWD and also
register a clockevent in your platform timer driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

