From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] Report interrupt(s) that caused system wakeup
Date: Tue, 18 Aug 2015 01:17:10 +0200
Message-ID: <2470788.QaFQb9rj3y@vostro.rjw.lan>
References: <1438919224-7003-2-git-send-email-alexandra.yates@linux.intel.com> <1996878.sZiHYD4sbd@vostro.rjw.lan> <alpine.DEB.2.11.1508172234040.3873@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58641 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751767AbbHQWtu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 18:49:50 -0400
In-Reply-To: <alpine.DEB.2.11.1508172234040.3873@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, August 17, 2015 10:59:15 PM Thomas Gleixner wrote:
> On Sat, 8 Aug 2015, Rafael J. Wysocki wrote:
> > On Thursday, August 06, 2015 08:47:04 PM Alexandra Yates wrote:
> > > Add a new IRQ flag named IRQD_WAKEUP_TRIGGERED.  This flag is set
> > > when a given IRQ fires after it has been armed for system wakeup.
> > > The flag is cleared before arming the IRQ for system wakeup
> > > during the next system suspend. This feature makes possible to
> > > check which IRQs might have woken the system up from sleep last
> > > time it was suspended.
> > > 
> > > Add a new sysfs attribute under /sys/power/ named:pm_last_wakeup_irqs
> > > when read, will return a list of IRQs with the new flag set.  That
> > > will be useful for system wakeup diagnostics.
> > > 
> > > Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> > 
> > Thanks for the patch, but you've forgotten to CC the IRQ subsystem maintainer.
> > 
> > Hi Thomas, can you please have a look at the patch below and tell me if you
> > have any concerns about it?
> 
> Sure.
> 
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index 51f15bc..1a2d13b 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -870,6 +870,37 @@ void pm_wakeup_clear(void)
> > >  	pm_abort_suspend = false;
> > >  }
> > >  
> > > +#ifdef CONFIG_PM_SLEEP_DEBUG
> > > +/*
> > > + * pm_get_last_wakeup_irqs - Parses interrupts to identify which one
> > > + * caused the system to wake up from suspend-to-idle.
> > > + * @buf: keeps track of the irqs that casued the system to wakeup
> > > + */
> > > +ssize_t pm_get_last_wakeup_irqs(char *buf, size_t size)
> > > +{
> > > +	struct irq_desc *desc;
> > > +	int irq;
> > > +	char *str = buf;
> > > +	char *end = buf + size;
> > > +
> > > +	if (!pm_abort_suspend)
> > > +		return 0;
> > > +
> > > +	/* If pm_abort_suspend is not set, the previous suspend was aborted
> > > +	 * before arming the wakeup IRQs, so avoid printing stale information
> > > +	 * in that case.
> > > +	 */
> > > +	for_each_irq_desc(irq, desc)
> > > +		if (irqd_triggered_wakeup(&desc->irq_data))
> > > +			str += scnprintf(str, end - str, "%d ", irq);
> 
> This iteration needs to be protected by irq_lock_sparse().

Right.

> > > --- a/kernel/irq/pm.c
> > > +++ b/kernel/irq/pm.c
> > > @@ -22,6 +22,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
> > >  		desc->depth++;
> > >  		irq_disable(desc);
> > >  		pm_system_wakeup();
> > > +		irqd_set(&desc->irq_data, IRQD_WAKEUP_TRIGGERED);
> > >  		return true;
> > >  	}
> > >  	return false;
> > > @@ -73,6 +74,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
> > >  	if (!desc->action || desc->no_suspend_depth)
> > >  		return false;
> > >  
> > > +	irqd_clear(&desc->irq_data, IRQD_WAKEUP_TRIGGERED);
> 
> So that leaves a stale IRQD_WAKEUP_TRIGGERED bit in the following
> situation:
> 
> 	suspend()
> 	wakeup_triggered_by_irq(X)
> 	resume()
> 	...
> 	close_device()
> 	  free_irq(X)
> 	
> 	suspend()
> 	wakeup_triggered_by_irq(Y)
> 	resume()
> 
> So the next readout will show irqs X and Y being responsible for
> waking up the system.

Right.

> I really have to ask why this bit fiddling is necessary at all. Isn't
> the really interesting information the first interrupt which triggered
> the resume? If we can reduce it to that information then this whole
> thing can be simplified into a few lines of code.

The original point was that if two wakeup interrupts happened at the same time,
it would be kind of moot which one was the "real" wakeup, but now that I think
about it, reporting the first one should be enough to catch suprious wakeups
anyway.

Thanks,
Rafael

