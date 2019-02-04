From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v4 07/10] gpio: Initial support for ROHM bd70528 GPIO
 block
Date: Mon, 4 Feb 2019 14:25:11 +0200
Message-ID: <20190204122511.GG23791@localhost.localdomain>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <5f63684b62c7a320c514088bcf9091ed7efbd2cc.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 04, 2019 at 12:29:53PM +0100, Linus Walleij wrote:
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

This direction fetching and then the value reading are two separate
operations at regmap-level. I guess the regmap can't be holding any
locks during two indpendent operations.

> 
> > My initial feeling is that locking makes no sense.
> 
> Mine too.

Yep. I change the comment to explain why I think this race condition
is Ok. We can fix it if it ever turns out to be an issue.

> 
> > +       bdgpio->gpio.get_direction = &bd70528_get_direction;
> > +       bdgpio->gpio.direction_input = &bd70528_direction_input;
> > +       bdgpio->gpio.direction_output = &bd70528_direction_output;
> > +       bdgpio->gpio.set_config = &bd70528_gpio_set_config;
> > +       bdgpio->gpio.can_sleep = true;
> > +       bdgpio->gpio.get = &bd70528_gpio_get;
> > +       bdgpio->gpio.set = &bd70528_gpio_set;
> 
> Drop the &ampersand in from of the functions. All functions
> are pointers.

Yes they are. This & in front of functions when initializing a pointer
with their addresss is my old habit. I liked to consistently use & when
taking address of any beast, whether it was a variable or function.
Getting rid of old habits is not so easy :/ I'll clean thisi at v5 and
put back your Reviewed-by =) Thanks
> 
> With that:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
