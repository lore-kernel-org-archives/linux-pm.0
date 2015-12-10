From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] gpio: pl061: add support for wakeup configuration
Date: Thu, 10 Dec 2015 23:28:13 +0100
Message-ID: <29010084.S7IOntDGTH@vostro.rjw.lan>
References: <1448644755-29183-1-git-send-email-sudeep.holla@arm.com> <566846D6.6010501@arm.com> <CACRpkdZMhzgWqCLodW9B9o7HFi6UnKPccGNPbiErfY2OEoUMHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZMhzgWqCLodW9B9o7HFi6UnKPccGNPbiErfY2OEoUMHA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Aubrey Li <aubrey.li@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 10, 2015 07:22:12 PM Linus Walleij wrote:
> On Wed, Dec 9, 2015 at 4:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On 09/12/15 15:08, Linus Walleij wrote:
> >> On Fri, Nov 27, 2015 at 6:19 PM, Sudeep Holla <sudeep.holla@arm.com>
> >> wrote:
> >>
> >>> The PL061 supports interrupts and those can be wakeup interrupts. We
> >>> need to provide support for configuring those interrupts as wakeup
> >>> sources.
> >>>
> >>> This patch adds irq_set_wake callback for PL061 so that GPIO interrupts
> >>> can be configured as wakeup.
> >>>
> >>> Cc: Linus Walleij <linus.walleij@linaro.org>
> >>> Cc: Alexandre Courbot <gnurou@gmail.com>
> >>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>> ---
> >>>   drivers/gpio/gpio-pl061.c | 9 +++++++++
> >>>   1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> >>> index 4d4b37676702..8b1cbd5767f9 100644
> >>> --- a/drivers/gpio/gpio-pl061.c
> >>> +++ b/drivers/gpio/gpio-pl061.c
> >>> @@ -14,6 +14,7 @@
> >>>   #include <linux/module.h>
> >>>   #include <linux/io.h>
> >>>   #include <linux/ioport.h>
> >>> +#include <linux/interrupt.h>
> >>>   #include <linux/irq.h>
> >>>   #include <linux/irqchip/chained_irq.h>
> >>>   #include <linux/bitops.h>
> >>> @@ -269,12 +270,20 @@ static void pl061_irq_ack(struct irq_data *d)
> >>>          spin_unlock(&chip->lock);
> >>>   }
> >>>
> >>> +static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
> >>> +{
> >>> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> >>> +
> >>> +       return irq_set_irq_wake(gc->irq_parent, state);
> >>> +}
> >>> +
> >>>   static struct irq_chip pl061_irqchip = {
> >>>          .name           = "pl061",
> >>>          .irq_ack        = pl061_irq_ack,
> >>>          .irq_mask       = pl061_irq_mask,
> >>>          .irq_unmask     = pl061_irq_unmask,
> >>>          .irq_set_type   = pl061_irq_type,
> >>> +       .irq_set_wake   = pl061_irq_set_wake,
> >>>   };
> >>
> >>
> >> Is this really all that is needed? Don't you need to call
> >> device_wakeup_enable(&adev->dev, 1); on the amba (primecell)
> >> device providing this GPIO, lest it may be suspended itself
> >> and render this exercise pointless.
> >>
> >
> > Do you mean something like :
> >
> >
> > -->8--
> >
> > diff --git i/drivers/gpio/gpio-pl061.c w/drivers/gpio/gpio-pl061.c
> > index 4d4b37676702..467e0b278cf0 100644
> > --- i/drivers/gpio/gpio-pl061.c
> > +++ w/drivers/gpio/gpio-pl061.c
> > @@ -354,6 +354,7 @@ static int pl061_probe(struct amba_device *adev, const
> > struct amba_id *id)
> >         }
> >
> >         amba_set_drvdata(adev, chip);
> > +       dev_pm_set_wake_irq(&adev->dev, irq);
> 
> I don't really know :(
> 
> I was under the impression that we may need *both*, because if
> the GPIO line is wakeup-capable, the wakeup event will not be
> detected unless the GPIO controller is also online, simply.

I would think that the GPIO controller wouldn't be suspended in that case
and that its driver would decide.  So, it would return 0 from its system
suspend callbacks, but wouldn't actually suspend the device.

Of course, this means that its parent might need to do the same and
so on.

We don't really have a common way for handling that in the PM core.

Thanks,
Rafael

