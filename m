From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
	during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 21:59:19 +0100
Message-ID: <200903112159.21166.rjw__37072.3253385679$1236805619$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903111036.02482.rjw@sisk.pl>
	<alpine.LFD.2.00.0903111106450.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903111106450.29264@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 March 2009, Thomas Gleixner wrote:
> Rafael,
> 
> On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:
> 
> > Index: linux-2.6/kernel/irq/pm.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/kernel/irq/pm.c
> > @@ -0,0 +1,89 @@
> > +/*
> > + * linux/kernel/irq/pm.c
> > + *
> > + * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> > + *
> > + * This file contains power management functions related to interrupts.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include "internals.h"
> > +
> > +/**
> > + * suspend_device_irqs - disable all currently enabled interrupt lines
> > + *
> > + * During system-wide suspend or hibernation device interrupts need to be
> > + * disabled at the chip level and this function is provided for this purpose.
> > + * It disables all interrupt lines that are enabled at the moment and sets the
> > + * IRQ_SUSPENDED flag for them.
> > + */
> > +void suspend_device_irqs(void)
> > +{
> > +	struct irq_desc *desc;
> > +	int irq;
> > +
> > +	for_each_irq_desc(irq, desc) {
> > +		unsigned long flags;
> > +		bool sync = false;
> > +
> > +		spin_lock_irqsave(&desc->lock, flags);
> > +
> > +		if (desc->action && !(desc->action->flags & IRQF_TIMER)) {
> > +			if (!desc->depth++) {
> > +				desc->status |= IRQ_DISABLED;
> > +				desc->chip->disable(irq);
> > +				sync = true;
> > +			}
> > +			desc->status |= IRQ_SUSPENDED;
> 
>   This flag needs to be checked in __enable_irq().
> 
> > +		}
> > +
> > +		spin_unlock_irqrestore(&desc->lock, flags);
> > +
> > +		if (sync)
> > +			synchronize_irq(irq);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(suspend_device_irqs);
> 
>   I'm not too enthusiastic about this open coded implementation of
>   disable_irq() with slightly different semantics.

The difference in semantics is important IMO, otherwise I woulndn't have
done that.  In particular, IMO, the condition should be under the spinlock IMO
and I'd rather not synchronize all interrupts we don't really disable here.

>   Can we please move the fiddling with desc->* into
>   kernel/irq/manage.c and share the code there ?

Can you please discuss that with Ingo?  I moved that from manage.c at his
request.

Thanks,
Rafael
