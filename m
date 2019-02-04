From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RFC PATCH v4 07/10] gpio: Initial support for ROHM bd70528 GPIO block
Date: Mon, 4 Feb 2019 13:53:12 +0100
Message-ID: <CAMpxmJXKmq29misG_zx9qeaQ11qzYSvWqNwcNpRGc3cv4AK8eg@mail.gmail.com>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <5f63684b62c7a320c514088bcf9091ed7efbd2cc.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDIN
List-Id: linux-pm@vger.kernel.org

pon., 4 lut 2019 o 12:30 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Thu, Jan 31, 2019 at 1:08 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
>
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> (...)
> > I dropped the review-by from Linus Walleij because I would like to
> > get a comment on if locking is required when we check the direction
> > in order to detect the correct register for getting the pin state.
>
> I don't know that. You isn't regmap locking inherently?
>

FYI you can disable regmap locking by setting the disable_locking
field in regmap_config to true.

Bart

> > My initial feeling is that locking makes no sense.
>
> Mine too.
>
> > +       bdgpio->gpio.get_direction =3D &bd70528_get_direction;
> > +       bdgpio->gpio.direction_input =3D &bd70528_direction_input;
> > +       bdgpio->gpio.direction_output =3D &bd70528_direction_output;
> > +       bdgpio->gpio.set_config =3D &bd70528_gpio_set_config;
> > +       bdgpio->gpio.can_sleep =3D true;
> > +       bdgpio->gpio.get =3D &bd70528_gpio_get;
> > +       bdgpio->gpio.set =3D &bd70528_gpio_set;
>
> Drop the &ampersand in from of the functions. All functions
> are pointers.
>
> With that:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
