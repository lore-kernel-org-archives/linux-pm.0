From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 07/10] gpio: Initial support for ROHM bd70528 GPIO block
Date: Mon, 28 Jan 2019 13:55:48 +0100
Message-ID: <CACRpkdYTUB8vPiCF=s5-TARhv=DsPDQHVyCwP7fMc27gyDvKSg@mail.gmail.com>
References: <20190125110509.GA29310@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125110509.GA29310@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

Hi Matti!

Thanks for your patch!

On Fri, Jan 25, 2019 at 12:05 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> controlled by GPIO framework.
>
> IRQs are handled by regmap-irq and GPIO driver is not
> aware of the irq usage.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This is overall a very nicely written driver.

Just small comments:

> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>

Why interrupt? You do not use it.

> +static int bd70528_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> +       int val, ret;
> +
> +       /* Do we need to do something to IRQs here? */

Well you don't support IRQs yet so no problem as long as they're masked?

> +       ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
> +       if (ret) {
> +               dev_err(bdgpio->chip.dev, "Could not read gpio direction\n");
> +               return ret;
> +       }
> +
> +       return !(val & BD70528_GPIO_OUT_EN_MASK);
> +}
> +
> +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> +                                  unsigned long config)

This is very nice. With Thomas Petazzoni's ongoing work you will be
able to also support pull up/down if you need it.

> +static int bd70528_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> +
> +       /* Do we need to do something to IRQs here? */

Hmmm?

Apart from that it looks good. Feel free to add:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
on the next iteration.

Yours,
Linus Walleij
