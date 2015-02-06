From: Mike Turquette <mturquette@linaro.org>
Subject: Re: cpuidle vs suspend vs something else
Date: Fri, 06 Feb 2015 10:49:45 -0800
Message-ID: <20150206184945.421.74720@quantum>
References: <54D43143.2010403@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:62485 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbbBFStw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Feb 2015 13:49:52 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so4724489igd.4
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2015 10:49:52 -0800 (PST)
In-Reply-To: <54D43143.2010403@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>

Quoting Mason (2015-02-05 19:13:07)
> Hello everyone,
> 
> I've been reading about related sub-systems (cpuidle and suspend)
> and I'm not sure I understand how they relate / interact.
> 
> If I understand correctly (please do point out any misconceptions)
> on ARM Cortex A9, the first level of power saving is WFI, which is
> typically called from the idle loop.
> 
> This places the core in low-power mode ("Standby mode" in ARM docs).
> "RAM arrays" (don't know what they are), "processor logic", and
> "data engine" (not sure what any of these exactly refers to, guess
> I have more reading to do) are still powered-up, but most of the
> clocks are disabled.
> 
> In ARM's exact words, "WFI and WFE Standby modes disable most of the
> clocks in a processor, while keeping its logic powered up. This reduces
> the power drawn to the static leakage current, leaving a tiny clock
> power overhead requirement to enable the device to wake up."
> 
> Some CPUs like Intel's have several levels of sleep (deeper levels
> mean less power, but have a higher wake-up latency). AFAIU, cpuidle
> is used to describe and manage these levels?

(warning: over-simplification below. Please be kind if you decide to
blow it up)

Hello Mason,

A critical thing to understand is that you are talking about two classes
of idle behavior or power-saving behavior.

First there are the physical idle states and low-power states that the
*hardware* (silicon) can achieve. These vary in how much power they save
with trade-offs such increased wake-up latency, loss of context/cache,
etc.

WFI is the gateway to low-power states in ARM hardware (from the
perspective of the Linux kernel). A plain WFI without any extra steps
will gate the CPUs clocks. With some extra steps (programming target
power domain state, etc) then WFI can trigger lower voltages supplied by
the PMIC/regulators, or total power gating for power domains/island
resulting in increased energy savings but costlier wake-up time and loss
of context.

The second behavior is what the *software* (Linux OS) tries to do to
save power. You mentioned two such behaviors above:

1) CPUidle tries to save power by programming the hardware to a low
power idle state (see above) during moments of idleness. What is idle
time? It is when no work is scheduled to be run Right Now and the
scheduler enters the idle thread/loop. Note that CPUidle does not aim to
affect the schedulability (new word!) of the Linux scheduler. E.g. it
ideally should not impact performance, as it is only going to target a
low power hardware idle state opportunistically based on naturally
occurring idle time from the scheduler.

2) Suspend is very different from CPUidle. It *forces* idleness upon the
OS until a wake-up event resumes the OS from suspend. Imagine closing
the lid on your laptop while it is running. That is suspend. Processes
are frozen regardless of whether we have lots of work scheduled or not.
Suspend forces the OS to be idle. Typically this software idleness
corresponds to the deepest hardware idle state, but it doesn't have to.

That last point is why it is important to understand the different
between idling in software and idling in hardware. More on that below.

> 
> Isn't suspend somewhat like the deepest level of sleep?
> (Or is it different in that things like RAM state are only a concern
> for suspend, not cpuidle?)
>

There is nothing stopping a platform from suspending to RAM and leaving
everything powered up and only clock gating the CPUs with a WFI. That is
a brain-dead thing to do but it is possible and illustrates the
separation of software and hardware idling.

Regarding CPUidle, if you predict that you will be idle for a long
enough period of time then it is perfectly valid for you to hit your
deepest sleep state in the CPUidle path.

OMAP3 did this quite well: it had a CHIP OFF state that was utilized
both by suspend/hibernate as well CPUidle (when CPUidle thought that
there was sufficient idle time to go to that state without adversely
affecting performance).

However, these days it does seem more common for suspend to target a
deeper hardware sleep state than the deepest possible CPUidle state for
a given platform.

Finally, the idle states (C-states) available to CPUidle drivers in the
mainline Linux kernel are often a poor representation of what the
hardware can really do to save power. Look at vendor git tree for
whatever platform you are hacking on and usually you will see that there
are lots more C-states in those trees than what is merged upstream.
Maybe we'll fix that problem some day.

Regards,
Mike

> Are both subsystems still actively used?
> 
> I saw plans to merge cpufreq into cpuidle / scheduler decisions.
> 
> LCA14: LCA14-306: CPUidle & CPUfreq integration with scheduler
> http://www.slideshare.net/linaroorg/lca14-306-cpuidlecpufreqintegrationwithscheduler
> 
> This presentation doesn't mention suspend, I think.
> 
> ARM has a mode called "Dormant Mode". Is suspend typically
> used to put the SoC in that mode?
> 
> I think I need to read this document carefully:
> Power Management In The Linux Kernel -- Current Status And Future
> http://events.linuxfoundation.org/sites/events/files/slides/kernel_PM_plain.pdf
> 
> There's also an older document that may prove insightful:
> CPUIdle versus Suspend
> http://www.linuxplumbersconf.org/2010/ocw/proposals/789
> 
> But things move so fast in kernel-land, that I don't know how relevant
> a 4 year-old document can be.
> 
> Regards.
> 
