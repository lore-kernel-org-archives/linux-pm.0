From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Wed, 20 Jan 2016 20:07:18 +0100
Message-ID: <20160120190718.GS6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59106 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcATTHW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:07:22 -0500
Content-Disposition: inline
In-Reply-To: <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, Jan 20, 2016 at 05:00:32PM +0100, Daniel Lezcano wrote:
> +++ b/kernel/irq/handle.c
> @@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
>  			/* Fall through to add to randomness */
>  		case IRQ_HANDLED:
>  			flags |= action->flags;
> +			handle_irqtiming(irq, action->dev_id);
>  			break;
>  
>  		default:

> +++ b/kernel/irq/internals.h

> +static inline void handle_irqtiming(unsigned int irq, void *dev_id)
> +{
> +	if (__irqtimings->handler)
> +		__irqtimings->handler(irq, ktime_get(), dev_id);
> +}

Here too, ktime_get() is daft.

Also, you really want to take the timestamp _before_ we call the
handlers, not after, otherwise you mix in whatever variance exist in the
handler duration.
