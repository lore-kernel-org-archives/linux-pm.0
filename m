From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 1/8] clk: add an APPLY_RATE_CHANGE notifier event during
 clk_set_rate()
Date: Mon, 07 Jul 2014 16:44:18 -0700
Message-ID: <53BB30D2.3010908@codeaurora.org>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com> <1404744702-32010-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:48045 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaGGXoU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jul 2014 19:44:20 -0400
In-Reply-To: <1404744702-32010-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 07/07/14 07:51, Thomas Petazzoni wrote:
> The current clk_set_rate() logic allows notifiers to be notified of
> three different events:
>
>  * PRE_RATE_CHANGE: before the clock driver ->set_rate() function is
>    called.
>  * ABORT_RATE_CHANGE: called if the rate change failed
>  * POST_RATE_CHANGE: called after the rate change has been
>    successfully done, but after ->recalc_rate() has been called, and
>    only if the rate of the clock has actually changed.
>
> This commit adds an additional APPLY_RATE_CHANGE, which we require on
> Armada XP to implement dynamic frequency scaling of the CPU
> clocks. The problem is as follows.
>
> On Armada XP, there are three hardware blocks involved in the dynamic
> frequency scaling of the CPU clocks:
>
>  - The CPU clocks hardware block itself, whose registers are already
>    "managed" by drivers/clk/mvebu/clk-cpu.c (compatible string:
>    marvell,armada-xp-cpu-clock). The driver currently only supports
>    changing the rate of the CPU clock when the clock is off (i.e
>    before we boot the secondary CPUs).
>
>  - The PMU DFS registers, which are used to configure the target
>    frequency for a dynamic rate change. Those registers are relatively
>    well isolated from other PMU registers, so they can also be
>    "managed" by the drivers/clk/mvebu/clk-cpu.c.
>
>  - The PMSU registers, which are used to actually trigger the dynamic
>    frequency change procedure, which consists in programming a bunch
>    of PMSU registers, entering the idle state on the CPU we want to
>    change the frequency, and then again reprogram a bunch of PMSU
>    registers.
>
> The procedure to change the frequency is:
>
>  1/ Reset some clocks using the CPU clocks hardware block.
>  2/ Define the target frequency using the PMU DFS registers.
>  3/ Do the actual frequency change using the PMSU registers.
>
> However, the PMSU registers are already "managed" by a driver in
> arch/arm/mach-mvebu/pmsu.c, and the code there is needed for a wide
> variety of power management activities: booting of secondary CPUs, CPU
> hotplug, cpuidle, cpufreq, and soon suspend/resume. The same registers
> in the PMSU are used for several of those activities.
>
> So, what we need to do is to have steps (1) and (2) above done in the
> CPU clocks driver, and then step (3) done through a clk notifier.
>
> However, the current POST_RATE_CHANGE notifier is called too late
> (after ->recalc_rate) and only if the rate has changed. So it works
> fine for a pure notification of a frequency change, but it doesn't
> work if the notified code is actually involved in the frequency
> change, which is exactly the case we have here. Until the sequence
> that uses the PMSU registers has been executed, the rate of the CPU
> clock has not changed.
>
> In order to solve this problem, we propose to add an APPLY_RATE_CHANGE
> notifier event, which gets called right after ->set_rate(), but before
> ->recalc_rate(), and therefore regardless of whether there was an
> actualy frequency change or not.

Is there any reason why we can't call the pmsu code (part #3) directly
from the cpu clock driver? It seems like if we just called the
.set_rate() op we wouldn't actually have changed the clock's rate. That
doesn't seem very intuitive and it really makes the code flow hard to
follow.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

