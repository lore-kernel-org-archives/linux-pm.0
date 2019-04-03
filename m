From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Wed, 3 Apr 2019 12:25:59 +0100
Message-ID: <20190403112559.GP11301@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403101003.GC3493@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, heikki.haikola@fi.rohmeurop
List-Id: linux-pm@vger.kernel.org

On Wed, 03 Apr 2019, Matti Vaittinen wrote:

> On Wed, Apr 03, 2019 at 10:30:15AM +0100, Lee Jones wrote:
> > On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> > 
> > > Hello Lee,
> > > 
> > > Thanks for taking a look on this again =) I agree with most of the
> > > comments and correct them at next version.
> > > 
> > > On Wed, Apr 03, 2019 at 08:31:52AM +0100, Lee Jones wrote:
> > > > On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> > > > 
> > > > > ROHM BD70528MWV is an ultra-low quiescent current general
> > > > > purpose single-chip power management IC for battery-powered
> > > > > portable devices.
> > > > > 
> > > > > Add MFD core which enables chip access for following subdevices:
> > > > > 	- regulators/LED drivers
> > > > > 	- battery-charger
> > > > > 	- gpios
> > > > > 	- 32.768kHz clk
> > > > > 	- RTC
> > > > > 	- watchdog
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > > + * Mapping of main IRQ register bits to sub irq register offsets so
> > > > 
> > > > "sub-IRQ"
> > > > 
> > > > > + * that we can access corect sub IRQ registers based on bits that
> > > > 
> > > > "sub IRQ" is also fine, but please standardise.
> > > > 
> > > > I do prefer "sub-IRQ" though.
> > > 
> > > I'll go with "sub-IRQ" then
> > > 
> > > > > +
> > > > > +#define WD_CTRL_MAGIC1 0x55
> > > > > +#define WD_CTRL_MAGIC2 0xAA
> > > > > +/**
> > > > > + * bd70528_wdt_set - arm or disarm watchdog timer
> > > > > + *
> > > > > + * @data:	device data for the PMIC instance we want to operate on
> > > > > + * @enable:	new state of WDT. zero to disable, non zero to enable
> > > > > + * @old_state:	previous state of WDT will be filled here
> > > > > + *
> > > > > + * Arm or disarm WDT on BD70528 PMIC. Expected to be called only by
> > > > > + * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock must be taken
> > > > > + * by calling bd70528_wdt_lock before calling bd70528_wdt_set.
> > > > > + */
> > > > > +int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state)
> > > > 
> > > > Why doesn't this reside in the watchdog driver?
> > > 
> > > If my memory serves me right we shortly discussed this already during v8
> > > review ;) Cant blame you though as I have seen some of the mail traffic
> > > going through your inbox :D
> > > 
> > > The motivation to have the functions exported from MFD is to not create
> > > sirect dependency between RTC and WDT. There may be cases where we want
> > > to leave either RTC or WDT out of compilation. MFD is always needed so
> > > the dependency from MFD to RTC/WDT does not harm.
> > > 
> > > (Here's some discussion necromancy if you are interested in re-reading
> > > how we did end up with this implementation:
> > > https://lore.kernel.org/lkml/20190212091723.GZ20638@dell/)
> > > 
> > > I hope you are still Ok with having the WDT control functions in MFD.
> > 
> > OOI, why does the RTC need to control the WDT?
> 
> I thought I had a comment about this somewhere in code... O_o Must have
> been in some development branch I had :/
> 
> Anyways, setting the RTC counter may cause watchdog to trigger. It is not
> further explained why but I would guess watchdog uses RTC counter to check
> if it should've been pinged already. So RTC needs to disable watch dog for
> the duration of hwclock setting and enable it again after the new time is
> set. I can add a comment about this to MFD driver if it helps :)

How does the user select between using the RTC and the WDT?

Or are the generally both enabled at the same time?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
