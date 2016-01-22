From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Fri, 22 Jan 2016 12:08:23 +0100
Message-ID: <CAPDyKFoNcARZRZfXM1Rdn2PZqtnUdbfn1Fb4PzKZs_DKkxKtSw@mail.gmail.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
	<1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com>
	<569E1366.8070005@nvidia.com>
	<alpine.DEB.2.11.1601201620450.3575@nanos>
	<CAPDyKFrqQO6Mh7ew5YTW011a11LmFW7c+cZpAKmY8tovxjGmOw@mail.gmail.com>
	<alpine.DEB.2.11.1601212026230.3886@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1601212026230.3886@nanos>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 21 January 2016 at 20:51, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> On Thu, 21 Jan 2016, Ulf Hansson wrote:
>> >> > I don't think using __free_irq() is the correct place to decrease the
>> >> > runtime PM usage count. It will keep the irqchip runtime resumed even
>> >> > if there are no irqs enabled for it.
>> >> >
>> >> > Instead I would rather allow the irqchip to be runtime suspended, when
>> >> > there are no irqs enabled on it.
>> >
>> > Which is a no no, as you might lose interrupts that way. We disable interrupts
>> > lazy, i.e. we do not mask them. So no, you cannot do that from
>> > enable/disable_irq().
>>
>> Thanks for the input!
>>
>> My main point around the approach suggested in $subject patch, is that
>> I don't think it's *enough* fine grained.
>>
>> From a runtime PM perspective, we should allow the irqchip to enter a
>> low power state when there are no IRQs enabled for it.
>>
>> As enable|disable_irq() isn't the place to do runtime PM reference
>> counting from, perhaps there is another option? Maybe the irqchip
>> driver itself is better suited to take these decisions?
>
> The irq chip driver does not have more information than the core code,
> actually it has less.
>
> Let's look at disable_irq(). It's normaly used for short periods of time where
> a driver needs to make sure that the interrupt is not handled. That's hardly a
> point to do power management, because its going to be reenabled right
> away. That's one of the reasons for doing the lazy masking, though the main
> reason is to prevent losing interrupt on edge driven irq lines.

I didn't think of the edge driven irq case.

I totally agree, disable|enable_irq() can't be used for power management.

>
> So as long as an interrupt handler is installed, there is no sane way that we
> can decide to power down the irq chip, unless that chip has the magic ability
> to relay incoming interrupts while powered down :)
>
> There is also the issue with shared interrupts....
>
> So the only sane way to power down the irq chip is to remove the handlers when
> the device is not in use. Actually some of the subsystems/drivers do that
> already.
>
> Though there might be a case where the device driver is still in use, but it
> has brought down the device into a quiescent state, which guarantees that no
> interrupts happen unless its powered up again. That would be an opportunity to
> shut down the interrupt and do power management as well. So currently we only
> have the option of freeing the interrupt and requesting it again.

I agree, this is exactly the case I have been thinking of.

Closely related to this topic.

Currently there are several cases where subsystems/drivers don't
protects themselves from receiving an IRQ, when the device is in a
quiescent state.
This may lead to hangs at device register accesses etc, especially
when the IRQ handler expects the device to be functional and not in a
low power state.

This is a different issue, but the solution I had in mind was to use
disable|enable_irq() as protection. I now realize that
freeing/re-requesting the IRQ handler is better, as that would
potentially allow power management for the irqchip as well.

>
> It might be conveniant to avoid that by having extra functions which are less
> heavyweight. Something like irq_[de]activate(irq, void *dev_id), which would
> mask/unmask the interrupt and do power management on the irq chip.

I like that idea!

We may also want to distinguish between the PM case and by just having
an IRQ handler registered, for whatever reason.

More importantly, we don't want to introduce unnecessary latencies
when bringing devices back to full power from a quiescent power state.

Perhaps the functions should be named something with "pm" to better
reflect their purpose?

>
> If you can come up with a simple comparision of such an approach with the
> free/request_irq() method which shows that it is superior, I'm surely not in
> the way. No need to code that core part, just show how a few drivers would use
> those functions and why this is less intrusive and simpler to use for the
> developer that going for the free/request() solution.

Here's a small collection of drivers that I easily picked up as
candidates for using these new APIs.
In principle, they would invoke these new APIs from their runtime PM callbacks.

drivers/spi/spi-atmel.c
drivers/spi/spi-pl022.c
drivers/i2c/busses/i2c-omap.c
drivers/i2c/busses/i2c-nomadik.c
drivers/i2c/busses/i2c-sh_mobile.c
drivers/mmc/host/mtk-sd.c
drivers/mmc/host/mmci.c

Kind regards
Uffe
