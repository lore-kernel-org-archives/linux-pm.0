From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Wed, 20 Jan 2016 16:30:44 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601201620450.3575@nanos>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com> <1450349309-8107-4-git-send-email-jonathanh@nvidia.com> <CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com> <569E1366.8070005@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60118 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709AbcATPb6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 10:31:58 -0500
In-Reply-To: <569E1366.8070005@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, 19 Jan 2016, Jon Hunter wrote:
> On 18/01/16 14:47, Ulf Hansson wrote:
> >> +/* Inline functions for support of irq chips that require runtime pm */
> >> +static inline int chip_pm_get(struct irq_desc *desc)
> > 
> > Why does these new get/put functions need to be inline functions and
> > thus defined in the header file? Perhaps move them to manage.c are
> > better?
> 
> They don't have to be, and so I can move them.

Yes, please make them proper functions. The proper place for them is chip.c
 
> > This won't play nicely when CONFIG_PM is unset, as pm_runtime_put()
> > would return -ENOSYS. In such cases I guess you would like to ignore
> > the error!?
> 
> Ok, yes good point.

So you need a CONFIG_PM variant and stubs which return 0 for the !PM case.
 
> >> @@ -1116,6 +1116,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
> >>         if (!try_module_get(desc->owner))
> >>                 return -ENODEV;
> >>
> >> +       ret = chip_pm_get(desc);
> >> +       if (ret < 0)
> >> +               return ret;

That leaks the module refcount.

> > I don't think using __free_irq() is the correct place to decrease the
> > runtime PM usage count. It will keep the irqchip runtime resumed even
> > if there are no irqs enabled for it.
> >
> > Instead I would rather allow the irqchip to be runtime suspended, when
> > there are no irqs enabled on it.

Which is a no no, as you might lose interrupts that way. We disable interrupts
lazy, i.e. we do not mask them. So no, you cannot do that from
enable/disable_irq().
 
> This may appear ugly, but for something like this, we may need to have a
> separate enable/disable API, such as
> enable_irq_lazy()/disable_irq_lazy() which could be used to runtime
> suspend/resume the chip and must not be used in critical sections.

enable_irq_lazy is a misnomer. enable_irq_pm or such might be acceptable.

But before we go there I really want to see a proper use case for such
functions.

Thanks,

	tglx

