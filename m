From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Fri, 18 Mar 2016 15:57:11 +0200
Message-ID: <56EC0937.9080702@ti.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com>
 <569E1366.8070005@nvidia.com> <alpine.DEB.2.11.1601201620450.3575@nanos>
 <CAPDyKFrqQO6Mh7ew5YTW011a11LmFW7c+cZpAKmY8tovxjGmOw@mail.gmail.com>
 <alpine.DEB.2.11.1601212026230.3886@nanos>
 <CACRpkdbE-Ny585yK+DBkNENpWyk8rSEvdRdvLgMTCBp13grp4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdbE-Ny585yK+DBkNENpWyk8rSEvdRdvLgMTCBp13grp4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02/05/2016 04:37 PM, Linus Walleij wrote:
> On Thu, Jan 21, 2016 at 8:51 PM, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> 
>> So as long as an interrupt handler is installed, there is no sane way that we
>> can decide to power down the irq chip, unless that chip has the magic ability
>> to relay incoming interrupts while powered down :)
> 
> Actually isn't that exactly what almost every SoC that supports
> deepsleep does?
> 
> They power off the primary interrupt controller and arm the padring
> of the SoC with an asynchronous edge detector to wake up as soon
> as something happens on a few select lines, like a keypad button
> or whatnot.
> 
> The asynchronous edge detector is handled by the ROM or some
> power-management microcontroller, which wakes up the system
> and restores power to the CPU and primary interrupt controller.
> That is the magic ability right there.
> 
> Of course as the wakeup signal may be deasserted at the
> point the system actually comes back up, so the magic ROM
> power management unit then needs to latch
> any latent IRQs from some shadow register to the primary interrupt
> controller, which as far as I've seen is done by out-of-tree hacks
> similar to the irq_[get/set]_irqchip_state() implemented
> by Marc Zyngier, albeit for virtualization.
> 
> I've not seen it on any non-primary interrupt controller though.
> 

OMAP gpio can lose context(Power) even if there
GPIO IRQs configured as wakeup sources (wakeup happen through the SoC specific HW
responsible for wakeup in this case) - pcs.

It also injects IRQs if their triggering type is not fully compatible with PM HW.  

-- 
regards,
-grygorii
