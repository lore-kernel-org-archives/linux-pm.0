From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V10] Report interrupt that caused system wakeup
Date: Tue, 15 Sep 2015 01:45:39 +0200
Message-ID: <9331847.OW4AnB7gRN@vostro.rjw.lan>
References: <1442253742-14240-1-git-send-email-alexandra.yates@linux.intel.com> <3579246.1W0f3mW1op@vostro.rjw.lan> <alpine.DEB.2.11.1509150100350.3971@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62188 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752077AbbINXRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 19:17:40 -0400
In-Reply-To: <alpine.DEB.2.11.1509150100350.3971@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Tuesday, September 15, 2015 01:02:09 AM Thomas Gleixner wrote:
> On Tue, 15 Sep 2015, Rafael J. Wysocki wrote:
> > > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > > index d22786a..d26a823 100644
> > > --- a/kernel/irq/pm.c
> > > +++ b/kernel/irq/pm.c
> > > @@ -21,7 +21,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
> > >  		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
> > >  		desc->depth++;
> > >  		irq_disable(desc);
> > > -		pm_system_wakeup();
> > > +		pm_system_irq_wakeup(irq_desc_get_irq(desc));
> > >  		return true;
> > >  	}
> > 
> > Thomas, any objections agains the above?
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>  
> > >  	return false;
> > > @@ -73,6 +73,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
> > >  	if (!desc->action || desc->no_suspend_depth)
> > >  		return false;
> > >  
> > > +
> > 
> > A leftover from the previous versions of the patch?
> > 
> > Not useful anyway.
> 
> You said it way more polite than I would have :)

Heh

OK, I'll drop the pointless hunk from the patch and apply it then.

Thanks,
Rafael

