From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v9 5/8] gpio: Initial support for ROHM bd70528 GPIO block
Date: Thu, 14 Feb 2019 14:38:06 +0200
Message-ID: <20190214123806.GH12247@localhost.localdomain>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
 <20190214082901.GG12247@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214082901.GG12247@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
List-Id: linux-pm@vger.kernel.org

Hello Linus,

On Thu, Feb 14, 2019 at 10:29:01AM +0200, Matti Vaittinen wrote:
> Thanks a bunch Linus,
> 
> On Thu, Feb 14, 2019 at 09:00:33AM +0100, Linus Walleij wrote:
> > On Wed, Feb 13, 2019 at 2:34 PM Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com> wrote:
> > 
> > Just spotted this:
> > 
> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/gpio.h>
> > 
> > A driver should only need <linux/gpio/driver.h>
> > the <linux/gpio.h> should not be used at all in new code,
> > it is a legacy header.
> 
> Allright. I'll do v10 and drop the header. Thanks for pointing this out

It seems to me the GPIOF_DIR_XXX are defined in linux/gpio.h. It would
be nice to refer to these flags when interpreting the return value
from the bd70528_get_direction (used in bd70528_gpio_get) - and actually
it might be nice to use those as a return value from bd70528_get_direction.

But I'll go with raw values for now and leave possible definition
moving/header refactoring to you who know the direction of code better :)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
