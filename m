From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Thu, 21 Jan 2016 20:51:11 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601212026230.3886@nanos>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com> <1450349309-8107-4-git-send-email-jonathanh@nvidia.com> <CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com> <569E1366.8070005@nvidia.com> <alpine.DEB.2.11.1601201620450.3575@nanos>
 <CAPDyKFrqQO6Mh7ew5YTW011a11LmFW7c+cZpAKmY8tovxjGmOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40926 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbcAUTw2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 14:52:28 -0500
In-Reply-To: <CAPDyKFrqQO6Mh7ew5YTW011a11LmFW7c+cZpAKmY8tovxjGmOw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, 21 Jan 2016, Ulf Hansson wrote:
> >> > I don't think using __free_irq() is the correct place to decrease the
> >> > runtime PM usage count. It will keep the irqchip runtime resumed even
> >> > if there are no irqs enabled for it.
> >> >
> >> > Instead I would rather allow the irqchip to be runtime suspended, when
> >> > there are no irqs enabled on it.
> >
> > Which is a no no, as you might lose interrupts that way. We disable interrupts
> > lazy, i.e. we do not mask them. So no, you cannot do that from
> > enable/disable_irq().
> 
> Thanks for the input!
> 
> My main point around the approach suggested in $subject patch, is that
> I don't think it's *enough* fine grained.
> 
> From a runtime PM perspective, we should allow the irqchip to enter a
> low power state when there are no IRQs enabled for it.
> 
> As enable|disable_irq() isn't the place to do runtime PM reference
> counting from, perhaps there is another option? Maybe the irqchip
> driver itself is better suited to take these decisions?

The irq chip driver does not have more information than the core code,
actually it has less.

Let's look at disable_irq(). It's normaly used for short periods of time where
a driver needs to make sure that the interrupt is not handled. That's hardly a
point to do power management, because its going to be reenabled right
away. That's one of the reasons for doing the lazy masking, though the main
reason is to prevent losing interrupt on edge driven irq lines.

So as long as an interrupt handler is installed, there is no sane way that we
can decide to power down the irq chip, unless that chip has the magic ability
to relay incoming interrupts while powered down :)

There is also the issue with shared interrupts....

So the only sane way to power down the irq chip is to remove the handlers when
the device is not in use. Actually some of the subsystems/drivers do that
already.

Though there might be a case where the device driver is still in use, but it
has brought down the device into a quiescent state, which guarantees that no
interrupts happen unless its powered up again. That would be an opportunity to
shut down the interrupt and do power management as well. So currently we only
have the option of freeing the interrupt and requesting it again.

It might be conveniant to avoid that by having extra functions which are less
heavyweight. Something like irq_[de]activate(irq, void *dev_id), which would
mask/unmask the interrupt and do power management on the irq chip.

If you can come up with a simple comparision of such an approach with the
free/request_irq() method which shows that it is superior, I'm surely not in
the way. No need to code that core part, just show how a few drivers would use
those functions and why this is less intrusive and simpler to use for the
developer that going for the free/request() solution.

Thanks,

	tglx








