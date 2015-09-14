From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10] Report interrupt that caused system wakeup
Date: Tue, 15 Sep 2015 01:02:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509150100350.3971@nanos>
References: <1442253742-14240-1-git-send-email-alexandra.yates@linux.intel.com> <3579246.1W0f3mW1op@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41002 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbINXCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 19:02:49 -0400
In-Reply-To: <3579246.1W0f3mW1op@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Tue, 15 Sep 2015, Rafael J. Wysocki wrote:
> > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > index d22786a..d26a823 100644
> > --- a/kernel/irq/pm.c
> > +++ b/kernel/irq/pm.c
> > @@ -21,7 +21,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
> >  		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
> >  		desc->depth++;
> >  		irq_disable(desc);
> > -		pm_system_wakeup();
> > +		pm_system_irq_wakeup(irq_desc_get_irq(desc));
> >  		return true;
> >  	}
> 
> Thomas, any objections agains the above?

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
 
> >  	return false;
> > @@ -73,6 +73,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
> >  	if (!desc->action || desc->no_suspend_depth)
> >  		return false;
> >  
> > +
> 
> A leftover from the previous versions of the patch?
> 
> Not useful anyway.

You said it way more polite than I would have :)

Thanks,

	tglx
