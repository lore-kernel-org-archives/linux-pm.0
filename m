From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH - RE-RESEND] IRQ: don't suspend nested_thread irqs over
 system suspend.
Date: Mon, 18 May 2015 14:16:27 +0200
Message-ID: <20150518121627.GF21418@twins.programming.kicks-ass.net>
References: <20150517151934.2393e8f8@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45227 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbbERMQl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 08:16:41 -0400
Content-Disposition: inline
In-Reply-To: <20150517151934.2393e8f8@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>

On Sun, May 17, 2015 at 03:19:34PM +1000, NeilBrown wrote:
> 
> 
> Nested IRQs can only fire when the parent irq fires.
> So when the parent is suspended, there is no need to suspend
> the child irq.
> 
> Suspending nested irqs can cause a problem is they are suspended or
> resumed in the wrong order.
> If an interrupt fires while the parent is active but the child is
> suspended, then the interrupt will not be acknowledged properly
> and so an interrupt storm can result.
> This is particularly likely if the parent is resumed before
> the child, and the interrupt was raised during suspend.
> 
> Ensuring correct ordering would be possible, but it is simpler
> to just never suspend nested interrupts.

Looks sane to me, but it's Thomas' call.

FWIW:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 5204a6d1b985..d22786a6dbde 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -123,6 +123,8 @@ void suspend_device_irqs(void)
>  		unsigned long flags;
>  		bool sync;
>  
> +		if (irq_settings_is_nested_thread(desc))
> +			continue;
>  		raw_spin_lock_irqsave(&desc->lock, flags);
>  		sync = suspend_device_irq(desc, irq);
>  		raw_spin_unlock_irqrestore(&desc->lock, flags);
> @@ -163,6 +165,8 @@ static void resume_irqs(bool want_early)
>  
>  		if (!is_early && want_early)
>  			continue;
> +		if (irq_settings_is_nested_thread(desc))
> +			continue;
>  
>  		raw_spin_lock_irqsave(&desc->lock, flags);
>  		resume_irq(desc, irq);


