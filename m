From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Mon, 9 Feb 2015 08:10:16 -0800
Message-ID: <5ae40a8e27a14965a130686fee7262f6@BN1BFFO11FD036.protection.gbl>
References: <54C8E125.3070905@free.fr>
 <20150203120925.GM8656@n2100.arm.linux.org.uk> <54D509EC.7020708@free.fr>
 <20150206191419.GA8656@n2100.arm.linux.org.uk>
 <83b8298aa6384cbda3650b9ce1b5c842@BN1AFFO11OLC003.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2on0094.outbound.protection.outlook.com ([207.46.100.94]:1056
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932284AbbBIQK6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Feb 2015 11:10:58 -0500
Content-Disposition: inline
In-Reply-To: <83b8298aa6384cbda3650b9ce1b5c842@BN1AFFO11OLC003.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mason <mpeg.blue@free.fr>, Mike Turquette <mturquette@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Soren Brinkmann <sorenb@xilinx.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, 2015-02-09 at 08:45AM +0100, Michal Simek wrote:
> + Soren
> 
> >> $ grep -rn ARM_GLOBAL_TIMER | grep -v SCHED_CLOCK
> >> arch/arm/mach-vexpress/Kconfig:7:	select ARM_GLOBAL_TIMER
> >> arch/arm/mach-bcm/Kconfig:87:	select ARM_GLOBAL_TIMER
> >> arch/arm/mach-bcm/Kconfig:108:	select ARM_GLOBAL_TIMER
> >> arch/arm/mach-rockchip/Kconfig:14:	select ARM_GLOBAL_TIMER
> >> arch/arm/mach-sti/Kconfig:4:	select ARM_GLOBAL_TIMER
> >> arch/arm/mach-zynq/Kconfig:6:	select ARM_GLOBAL_TIMER if !CPU_FREQ
> >>
> >> There are indeed a few users; also I wonder why mach-zynq enables
> >> ARM_GLOBAL_TIMER only if !CPU_FREQ. (Could it be that they have
> >> the CPU CLOCK driving PERIPHCLK?)
> > 
> > I'm afraid I don't know.
> 
> The reason is that cpu clock input and global timer clock input are not independent
> that's why changing clock for cpu also affect global timer freq which is wrong.
> It is caused by incorrect hw design.
> Soren can give you more detail information if you need.

Right, it is a (broken) attempt to avoid usage of the global timer in
case cpufreq is enabled. On Zynq, all timer's clock inputs are derived
from the CPU clock. Hence they all do change when cpufreq scales the CPU
clock. I wrote a fragile construct of clk notifiers for our cadence TTC
which compensates for those changes. But the TTC is fairly narrow and
slow, hence to guarantee it becomes the selected clocksource, I tried to
blacklist the global timer this way (which obviously fails when
something else selects the timer).

	Thanks,
	Soren
