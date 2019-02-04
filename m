From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v4 06/10] devicetree: bindings: Document first ROHM
 BD70528 bindings
Date: Mon, 4 Feb 2019 12:25:41 +0100
Message-ID: <CACRpkdZOzacQ5Myb_wsHz5wUGvwQ1avhfY5gaR+3oqhNtArH-A@mail.gmail.com>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com> <127bd8d6765e35272ad174c59838d1374813c910.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <127bd8d6765e35272ad174c59838d1374813c910.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2019 at 1:04 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
(...)
> +Required properties:
> + - compatible          : Should be "rohm,bd70528"
> + - reg                 : I2C slave address.
> + - interrupts          : The interrupt line the device is connected to.
> + - interrupt-controller        : To indicate bd70528 acts as an interrupt controller.
> + - #interrupt-cells    : Should be 2. usage is compliant to the 2 cells
> +                         variant of ../interrupt-controller/interrupts.txt
> + - gpio-controller     : To indicate bd70528 acts as a gpio controller.
> + - #gpio-cells         : Should be 2. The first cell is the pin number and
> +                         the second cell is used to specify flags. See
> +                         ../gpio/gpio.txt for more information.
> + - #clock-cells                : Should be 0.
> + - regulators:         : List of child nodes that specify the regulators.
> +                         Please see ../regulator/rohm,bd70528-regulator.txt

So if I understand correctly, the clocks and GPIO does not spawn any
child nodes but are attached directly to the MFD node.
This works!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
