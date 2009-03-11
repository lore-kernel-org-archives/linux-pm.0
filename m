From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 11:33:01 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903111106450.29264__41702.0896137275$1236768233$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903111030.39371.rjw@sisk.pl>
	<200903111036.02482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903111036.02482.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Rafael,

On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:

> Index: linux-2.6/kernel/irq/pm.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/kernel/irq/pm.c
> @@ -0,0 +1,89 @@
> +/*
> + * linux/kernel/irq/pm.c
> + *
> + * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> + *
> + * This file contains power management functions related to interrupts.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +
> +#include "internals.h"
> +
> +/**
> + * suspend_device_irqs - disable all currently enabled interrupt lines
> + *
> + * During system-wide suspend or hibernation device interrupts need to be
> + * disabled at the chip level and this function is provided for this purpose.
> + * It disables all interrupt lines that are enabled at the moment and sets the
> + * IRQ_SUSPENDED flag for them.
> + */
> +void suspend_device_irqs(void)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	for_each_irq_desc(irq, desc) {
> +		unsigned long flags;
> +		bool sync = false;
> +
> +		spin_lock_irqsave(&desc->lock, flags);
> +
> +		if (desc->action && !(desc->action->flags & IRQF_TIMER)) {
> +			if (!desc->depth++) {
> +				desc->status |= IRQ_DISABLED;
> +				desc->chip->disable(irq);
> +				sync = true;
> +			}
> +			desc->status |= IRQ_SUSPENDED;

  This flag needs to be checked in __enable_irq().

> +		}
> +
> +		spin_unlock_irqrestore(&desc->lock, flags);
> +
> +		if (sync)
> +			synchronize_irq(irq);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(suspend_device_irqs);

  I'm not too enthusiastic about this open coded implementation of
  disable_irq() with slightly different semantics.

  Can we please move the fiddling with desc->* into
  kernel/irq/manage.c and share the code there ?

> +/**
> + * resume_device_irqs - enable interrupt lines disabled by suspend_device_irqs()
> + *
> + * Enable all interrupt lines previously disabled by suspend_device_irqs() that
> + * have the IRQ_SUSPENDED flag set.
> + */
> +void resume_device_irqs(void)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	for_each_irq_desc(irq, desc) {
> +		unsigned long flags;
> +
> +		if (!(desc->status & IRQ_SUSPENDED))
> +			continue;
> +
> +		spin_lock_irqsave(&desc->lock, flags);
> +		desc->status &= ~IRQ_SUSPENDED;
> +		__enable_irq(desc, irq);
> +		spin_unlock_irqrestore(&desc->lock, flags);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(resume_device_irqs);

  Ditto.

Thanks,

	tglx
