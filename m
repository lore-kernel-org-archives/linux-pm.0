From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v9 5/8] gpio: Initial support for ROHM bd70528 GPIO block
Date: Thu, 14 Feb 2019 10:29:01 +0200
Message-ID: <20190214082901.GG12247@localhost.localdomain>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

Thanks a bunch Linus,

On Thu, Feb 14, 2019 at 09:00:33AM +0100, Linus Walleij wrote:
> On Wed, Feb 13, 2019 at 2:34 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> (...)
> 
> Just spotted this:
> 
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio.h>
> 
> A driver should only need <linux/gpio/driver.h>
> the <linux/gpio.h> should not be used at all in new code,
> it is a legacy header.

Allright. I'll do v10 and drop the header. Thanks for pointing this out

> > +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> > +                                  unsigned long config)
> > +{
> > +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> > +
> > +       switch (pinconf_to_config_param(config)) {
> > +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > +               return regmap_update_bits(bdgpio->chip.regmap,
> > +                                         GPIO_OUT_REG(offset),
> > +                                         BD70528_GPIO_DRIVE_MASK,
> > +                                         BD70528_GPIO_OPEN_DRAIN);
> > +               break;
> > +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> > +               return regmap_update_bits(bdgpio->chip.regmap,
> > +                                         GPIO_OUT_REG(offset),
> > +                                         BD70528_GPIO_DRIVE_MASK,
> > +                                         BD70528_GPIO_PUSH_PULL);
> > +               break;
> > +       case PIN_CONFIG_INPUT_DEBOUNCE:
> > +               return bd70528_set_debounce(bdgpio, offset,
> > +                                           pinconf_to_config_argument(config));
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +       return -ENOTSUPP;
> > +}
> 
> BTW I just merged code from Thomas Petazzoni that make it possible to
> also support pull-up and pull-down from GPIO here if you want to enable
> it.

Thanks for heads up Linus! I'll check it out although I don't want to
add up more changes in this series... But my initial feeling is that
this will deserve another patch (set) when initial support for BD70528
is available. (This answer is not locked, it may be I will fit the
change in this series if I am not buried under other duties ;] )

Br,
	Matti Vaittinen


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
