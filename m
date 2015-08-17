From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] Report interrupt(s) that caused system wakeup
Date: Mon, 17 Aug 2015 22:59:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508172234040.3873@nanos>
References: <1438919224-7003-2-git-send-email-alexandra.yates@linux.intel.com> <1996878.sZiHYD4sbd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54292 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbHQU7o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 16:59:44 -0400
In-Reply-To: <1996878.sZiHYD4sbd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 8 Aug 2015, Rafael J. Wysocki wrote:
> On Thursday, August 06, 2015 08:47:04 PM Alexandra Yates wrote:
> > Add a new IRQ flag named IRQD_WAKEUP_TRIGGERED.  This flag is set
> > when a given IRQ fires after it has been armed for system wakeup.
> > The flag is cleared before arming the IRQ for system wakeup
> > during the next system suspend. This feature makes possible to
> > check which IRQs might have woken the system up from sleep last
> > time it was suspended.
> > 
> > Add a new sysfs attribute under /sys/power/ named:pm_last_wakeup_irqs
> > when read, will return a list of IRQs with the new flag set.  That
> > will be useful for system wakeup diagnostics.
> > 
> > Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> 
> Thanks for the patch, but you've forgotten to CC the IRQ subsystem maintainer.
> 
> Hi Thomas, can you please have a look at the patch below and tell me if you
> have any concerns about it?

Sure.

> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 51f15bc..1a2d13b 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -870,6 +870,37 @@ void pm_wakeup_clear(void)
> >  	pm_abort_suspend = false;
> >  }
> >  
> > +#ifdef CONFIG_PM_SLEEP_DEBUG
> > +/*
> > + * pm_get_last_wakeup_irqs - Parses interrupts to identify which one
> > + * caused the system to wake up from suspend-to-idle.
> > + * @buf: keeps track of the irqs that casued the system to wakeup
> > + */
> > +ssize_t pm_get_last_wakeup_irqs(char *buf, size_t size)
> > +{
> > +	struct irq_desc *desc;
> > +	int irq;
> > +	char *str = buf;
> > +	char *end = buf + size;
> > +
> > +	if (!pm_abort_suspend)
> > +		return 0;
> > +
> > +	/* If pm_abort_suspend is not set, the previous suspend was aborted
> > +	 * before arming the wakeup IRQs, so avoid printing stale information
> > +	 * in that case.
> > +	 */
> > +	for_each_irq_desc(irq, desc)
> > +		if (irqd_triggered_wakeup(&desc->irq_data))
> > +			str += scnprintf(str, end - str, "%d ", irq);

This iteration needs to be protected by irq_lock_sparse().

> > --- a/kernel/irq/pm.c
> > +++ b/kernel/irq/pm.c
> > @@ -22,6 +22,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
> >  		desc->depth++;
> >  		irq_disable(desc);
> >  		pm_system_wakeup();
> > +		irqd_set(&desc->irq_data, IRQD_WAKEUP_TRIGGERED);
> >  		return true;
> >  	}
> >  	return false;
> > @@ -73,6 +74,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
> >  	if (!desc->action || desc->no_suspend_depth)
> >  		return false;
> >  
> > +	irqd_clear(&desc->irq_data, IRQD_WAKEUP_TRIGGERED);

So that leaves a stale IRQD_WAKEUP_TRIGGERED bit in the following
situation:

	suspend()
	wakeup_triggered_by_irq(X)
	resume()
	...
	close_device()
	  free_irq(X)
	
	suspend()
	wakeup_triggered_by_irq(Y)
	resume()

So the next readout will show irqs X and Y being responsible for
waking up the system.

I really have to ask why this bit fiddling is necessary at all. Isn't
the really interesting information the first interrupt which triggered
the resume? If we can reduce it to that information then this whole
thing can be simplified into a few lines of code.

Thanks,

	tglx




