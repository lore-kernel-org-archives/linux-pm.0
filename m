From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 17:23:25 +0100
Message-ID: <20150904162325.GG21084@n2100.arm.linux.org.uk>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
 <20150904091735.GC21084@n2100.arm.linux.org.uk>
 <20150904092716.GD21084@n2100.arm.linux.org.uk>
 <20150904151202.GA876@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:50497 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758620AbbIDQXh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 12:23:37 -0400
Content-Disposition: inline
In-Reply-To: <20150904151202.GA876@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, sboyd@codeaurora.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 04, 2015 at 09:12:02AM -0600, Lina Iyer wrote:
> On Fri, Sep 04 2015 at 03:27 -0600, Russell King - ARM Linux wrote:
> >On Fri, Sep 04, 2015 at 10:17:35AM +0100, Russell King - ARM Linux wrote:
> >>On Thu, Sep 03, 2015 at 01:58:34PM -0600, Lina Iyer wrote:
> >>> @@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
> >>>  	local_irq_enable();
> >>>  	local_fiq_enable();
> >>>
> >>> +	/* We are running, enable runtime PM for the CPU. */
> >>> +	cpu_dev = get_cpu_device(cpu);
> >>> +	if (cpu_dev)
> >>> +		pm_runtime_get_sync(cpu_dev);
> >>> +
> >>
> >>Please no.  This is fragile.
> >>
> >>pm_runtime_get_sync() can sleep, and this path is used when the system
> >>is fully up and running.  Locks may be held, which cause this to sleep.
> >>However, we're calling it from a context where we can't sleep - which
> >>is the general rule for any part of system initialisation where we
> >>have not entered the idle thread yet (the idle thread is what we run
> >>when sleeping.)
> >>
> More explanation below.
> 
> Another patch (3/7) in this series defines CPU devices as IRQ safe and
> therefore the dev->power.lock would be spinlock'd before calling the
> rest of the PM runtime code and the domain. The CPU PM domain would also
> be an IRQ safe domain (patch 2/7 makes the genpd framework usable in IRQ
> safe context).
> 
> >>NAK on this.
> >
> >There's another issue here.  This is obviously wrong.  If the CPU is
> >inside the PM domain, then don't you need the PM domain powered up for
> >the CPU to start executing instructions?
> >
> This would not be the case for CPU PM domains. The CPU PM domains AFAIK,
> are triggered by the same wake up interrupt that brings the CPU out of
> its power downs state. The domain hardware has to be awake before the
> CPU executes its first instruction. Thefore the hw power up is a logical
> OR of the wakeup signals to any of the cores.

You're taking the behaviour of the hardware you have in front of you
and claiming that it's true everywhere, and shoving that into generic
code.

I know, for example on OMAP, you have to power up the CPU first before
you can "wake" it.

I wouldn't be surprised if other SoCs are like that: where they require
the CPU core to be powered and held in reset, before releasing the reset
to then allow them to start executing the secondary core bringup.

Relying on hardware to do this sounds really fragile and bad design to
me.

If you want to persue your current design, don't make it generic code,
because it's got no right to be generic with assumptions like that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
