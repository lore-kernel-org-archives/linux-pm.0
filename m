From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH, v2]
Date: Mon, 28 Jul 2014 14:11:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407281350550.23352@nanos>
References: <20140724212620.GO3935@laptop> <1663327.PISiM9sMHC@vostro.rjw.lan> <3637397.iCmFpOsayO@vostro.rjw.lan> <3337421.bsfMykWVnZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3337421.bsfMykWVnZ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Jul 2014, Rafael J. Wysocki wrote:
> On Sunday, July 27, 2014 05:53:07 PM Rafael J. Wysocki wrote:
>  irqreturn_t
> +do_irqaction(struct irq_desc *desc, struct irqaction *action,
> +	     unsigned int irq, void *dev_id)
> +{
> +	irqreturn_t ret;
> +
> +	if (unlikely((desc->istate & IRQS_SHARED_SUSPENDED) &&
> +		     !(action->flags & IRQF_NO_SUSPEND)))
> +		return IRQ_NONE;

I really want to avoid that conditional. We burden it on every
interrupt just to deal with this nonsense.

A simple solution for this is to add irq_desc::action_suspended and
move the shared actions which are not flagged NO_SUSPEND over and
bring them back on resume.

> Index: linux-pm/kernel/irq/spurious.c
> ===================================================================
> --- linux-pm.orig/kernel/irq/spurious.c
> +++ linux-pm/kernel/irq/spurious.c
> @@ -275,6 +275,8 @@ try_misrouted_irq(unsigned int irq, stru
>  void note_interrupt(unsigned int irq, struct irq_desc *desc,
>  		    irqreturn_t action_ret)
>  {
> +	int misrouted;
> +
>  	if (desc->istate & IRQS_POLL_INPROGRESS ||
>  	    irq_settings_is_polled(desc))
>  		return;
> @@ -384,6 +386,9 @@ void note_interrupt(unsigned int irq, st
>  		}
>  	}
>  
> +	misrouted = unlikely(try_misrouted_irq(irq, desc, action_ret)) ?
> +			misrouted_irq(irq) : 0;

If the system is suspended, why would we try misrouted irqs at all?
All non wakeup irqs are disabled, so we just spend a gazillion of
cycles for nothing.

Thanks,

	tglx
