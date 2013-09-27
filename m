From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] arm: vexpress: tc2: fix CPU hotplug and CPU idle race on
 cluster power down
Date: Fri, 27 Sep 2013 16:27:52 +0100
Message-ID: <20130927152752.GC10613@e102568-lin.cambridge.arm.com>
References: <1380292153-10480-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130927151043.GA9746@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54063 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3I0P1z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 11:27:55 -0400
In-Reply-To: <20130927151043.GA9746@localhost.localdomain>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>

On Fri, Sep 27, 2013 at 04:10:49PM +0100, Dave Martin wrote:
> On Fri, Sep 27, 2013 at 03:29:13PM +0100, Lorenzo Pieralisi wrote:
> > On the TC2 testchip, when all CPUs in a cluster enter standbywfi and
> > commit a power down request, the power controller will wait for
> 
> [...]
> 
> (Minor nit: please wrap the commit message to a shorter length for git
> log.  I use 67, but I can't remember where that recommendation came from)

Ok, will do.

> [...]
> 
> > This patch moves the GIC CPU IF disable call in the TC2 MCPM implementation
> > from the suspend method to the power down method to fix the mentioned
> > race condition.
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Tested-by: Dave Martn <Dave.Martin@arm.com> (for kexec)

Thanks !

> It's worth briefly summarising the kexec scenario too:
> 
> kexec hotplugs secondary CPUs out during kernel reload/restart.
> Because kexec may (deliberately) trash the old kernel text, it is
> not OK for CPUs to follow the MCPM soft reboot path, since
> instructions after the WFI may have been replaced by kexec.
> 
> If tc2_pm_down() does not disable the GIC cpu interface, there is a
> race between CPU powerdown in the old kernel and the IPI from the
> new kernel that triggers secondary boot, particluarly if the
> powerdown is slow (due to L2 cache cleaning for example).  If the
> new kernel wins the race, the affected CPU(s) will not really be
> reset and may execute garbage after the WFI.
> 
> (some comments below)
> 
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> > ---
> >  arch/arm/mach-vexpress/tc2_pm.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> > index 7aeb5d6..e6eb481 100644
> > --- a/arch/arm/mach-vexpress/tc2_pm.c
> > +++ b/arch/arm/mach-vexpress/tc2_pm.c
> > @@ -131,6 +131,16 @@ static void tc2_pm_down(u64 residency)
> >  	} else
> >  		BUG();
> >  
> > +	/*
> > +	 * If the CPU is committed to power down, make sure
> > +	 * the power controller will be in charge of waking it
> > +	 * up upon IRQ, ie IRQ lines are cut from GIC CPU IF
> > +	 * to the CPU by disabling the GIC CPU IF to prevent wfi
> > +	 * from completing execution behind power controller back
> > +	 */
> > +	if (!skip_wfi)
> > +		gic_cpu_if_down();
> > +
> 
> In my version of this fix, I disabled the CPU interface much earlier,
> just after entering the function.  I think it probably works either
> way.  Do you think the location is critical, or should it not matter?
> 
> As far as I could tell, it matters only that this is done sometime
> between committing to WFI and actually doing it, but if you think
> there are extra requirements then I would like to understand them.

You are right, it can be added anywhere before executing wfi; I just added it
there for two reasons:

- MCPM checked if wfi should be skipped. If wfi should be skipped disabling
  GIC CPU IF is useless
- I want to issue the write to the GIC before we enter the no-fly zone
  (disable C-bit, clean cache, exit SMP (and disable CCI)). I know we
  could disable the GIC CPU IF right before executing wfi, but let's not
  play with fire, if that write hides a barrier we are in a bind.

Lorenzo

