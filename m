From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v9 5/8] gpio: Initial support for ROHM bd70528 GPIO block
Date: Thu, 14 Feb 2019 09:00:33 +0100
Message-ID: <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com> <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 13, 2019 at 2:34 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> controlled by GPIO framework.
>
> IRQs are handled by regmap-irq and GPIO driver is not
> aware of the irq usage.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(...)

Just spotted this:

> +#include <linux/gpio/driver.h>
> +#include <linux/gpio.h>

A driver should only need <linux/gpio/driver.h>
the <linux/gpio.h> should not be used at all in new code,
it is a legacy header.

> +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> +                                  unsigned long config)
> +{
> +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> +
> +       switch (pinconf_to_config_param(config)) {
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               return regmap_update_bits(bdgpio->chip.regmap,
> +                                         GPIO_OUT_REG(offset),
> +                                         BD70528_GPIO_DRIVE_MASK,
> +                                         BD70528_GPIO_OPEN_DRAIN);
> +               break;
> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> +               return regmap_update_bits(bdgpio->chip.regmap,
> +                                         GPIO_OUT_REG(offset),
> +                                         BD70528_GPIO_DRIVE_MASK,
> +                                         BD70528_GPIO_PUSH_PULL);
> +               break;
> +       case PIN_CONFIG_INPUT_DEBOUNCE:
> +               return bd70528_set_debounce(bdgpio, offset,
> +                                           pinconf_to_config_argument(config));
> +               break;
> +       default:
> +               break;
> +       }
> +       return -ENOTSUPP;
> +}

BTW I just merged code from Thomas Petazzoni that make it possible to
also support pull-up and pull-down from GPIO here if you want to enable
it.

Yours,
Linus Walleij
