From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v2 07/10] gpio: Initial support for ROHM bd70528 GPIO
 block
Date: Mon, 28 Jan 2019 16:04:45 +0200
Message-ID: <20190128140445.GB4156@localhost.localdomain>
References: <20190125110509.GA29310@localhost.localdomain>
 <CACRpkdYTUB8vPiCF=s5-TARhv=DsPDQHVyCwP7fMc27gyDvKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYTUB8vPiCF=s5-TARhv=DsPDQHVyCwP7fMc27gyDvKSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 01:55:48PM +0100, Linus Walleij wrote:
> Hi Matti!
> 
> Thanks for your patch!

No, thank you for the review =)

> On Fri, Jan 25, 2019 at 12:05 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> This is overall a very nicely written driver.
> 
> Just small comments:
> 
> > +#include <linux/gpio/driver.h>
> > +#include <linux/interrupt.h>
> 
> Why interrupt? You do not use it.

Right, I'd better to drop it.

> 
> > +static int bd70528_get_direction(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> > +       int val, ret;
> > +
> > +       /* Do we need to do something to IRQs here? */
> 
> Well you don't support IRQs yet so no problem as long as they're masked?

I may have not worded this correctly. These pins can be used for IRQs.
HW supports it and I added the irq registers in regmap-irq controller
(please see the MFD part). It's just that this GPIO driver is currently not
aware of that. This comment here is a reminder for me to figure out if
we should look whether the pin is used for I/O or for irqs here - and
what should we return if pin is configured to be used for IRQs.

> > +       ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
> > +       if (ret) {
> > +               dev_err(bdgpio->chip.dev, "Could not read gpio direction\n");
> > +               return ret;
> > +       }
> > +
> > +       return !(val & BD70528_GPIO_OUT_EN_MASK);
> > +}
> > +
> > +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> > +                                  unsigned long config)
> 
> This is very nice. With Thomas Petazzoni's ongoing work you will be
> able to also support pull up/down if you need it.
> 
> > +static int bd70528_direction_input(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> > +
> > +       /* Do we need to do something to IRQs here? */
> 
> Hmmm?

Same thing as with the get_direction. Should we allow setting the
direction if pin is already configured as an irq source? Should we
somehow try to warn user if it seems the pin is tried to be used for
both irqs and I/O?

> 
> Apart from that it looks good. Feel free to add:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> on the next iteration.

I will need to do some further testing on this before submitting next
version. I will gladly maintain your Reviewed-by if I don't do any
bigger changes to the driver - but if I do I'll drop your tag and ask
for re-review :)

Br,
	Matti Vaittinen
