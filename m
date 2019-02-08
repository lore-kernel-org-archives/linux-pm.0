From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Fri, 8 Feb 2019 14:41:11 +0200
Message-ID: <20190208124111.GB3012@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140053.GG20638@dell>
 <20190207162807.GB1920@localhost.localdomain>
 <20190208105743.GI20638@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208105743.GI20638@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Lee,

On Fri, Feb 08, 2019 at 10:57:43AM +0000, Lee Jones wrote:
> > 
> > This is needed by both RTC and WDT drivers as RTC driver must stop the
> > WDT when it sets RTC. WDT HW is using RTC counter and might trigger
> > timeout/reset when RTC is set. Options are to dublicate the
> > enable/disable to both drivers or to export a function or share a
> > function pointer. I didn't want dublication or dependency between RTC
> > and WDT drivers. Thus I thought that MFD is best place for this code as
> > both RTC and WDT require it anyways. Perhaps this should be commented
> > here?
> 
> I think an exported function with comments would be better.

So do you mean you would prefer exported function over the pointer from
MFD? I guess I can do it but I would still like to keep the code in the
MFD as I would rather not introduce dependency from WDT driver to RTC or
other way around. I can easily think of cases where WDT or RTC drivers
would be unnecessary and user might want to drop one of them out of
configuration. And I wonder if export actually makes any real
improvement as we need to share the mutex between RTC and WDT anyways.

> 
> [...]
> 
> > > > +	irqs[BD70528_INT_GPIO3].type.type_reg_offset = 6;
> > > > +	irqs[BD70528_INT_GPIO3].type.type_rising_val = 0x20;
> > > > +	irqs[BD70528_INT_GPIO3].type.type_falling_val = 0x10;
> > > > +	irqs[BD70528_INT_GPIO3].type.type_level_high_val = 0x40;
> > > > +	irqs[BD70528_INT_GPIO3].type.type_level_low_val = 0x50;
> > > > +	irqs[BD70528_INT_GPIO3].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > > > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > > 
> > > Could you please explain:
> > > 
> > > a) what you're doing here
> > 
> > Regmap-irq gained support for type-setting. On bd70528 the type setting
> > makes sense only for GPIO interrupts - so we must not populate type
> > setting information for the rest of the IRQs. The macro REGMAP_IRQ_REG
> > is nice and makes the irq struct initialization cleaner. Thus it is used.
> > It does not allow populating the type information - hence we do it here.
> > 
> > I can change this if you think some other way would be cleaner?
> 
> It's pretty fugly.  Can the REGMAP_IRQ_REG be expanded upon?

I was thinking of that but for vast majority of REGMAP_IRQ_REG users
initializing type regs would be just unnecessary burden (giving 6
zeroes for unsupported fields for each IRQ gets dull quite soon) I
was also thinking of adding another macro to be used in cases where
we have type setting supported - but macros with 9 parameters won't fit
on a line and (in my opinion) will not bring much improvement over
plain assignment.

> > > b) why you don't mass assign them
> > >     - seeing as most of the data is identical.
> > 
> > Maybe I am a bit slow today - but I don't know how the 'mass assignment'
> > should be done?
> 
> Something like (completely untested):
> 
> unsigned int type_reg_offset_inc = 0;
> for (i = BD70528_INT_GPIO0; i <=  BD70528_INT_GPIO3; i++) {
> 	irqs[i].type.type_reg_offset     = type_reg_offset_inc;
> 	irqs[i].type.type_rising_val     = 0x20;
> 	irqs[i].type.type_falling_val    = 0x10;
> 	irqs[i].type.type_level_high_val = 0x40;
> 	irqs[i].type.type_level_low_val  = 0x50;
> 	irqs[i].type.types_supported =
> 		(IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> 	type_reg_offset_inc += 2;
> }

Right. I did this this morning =)

> It's still fugly though.

Agree.

> If we can do this via MACROs, it would be better.

I just dont see how to do a nice macro for this. Truth is that there is
6 fields to initialize - and the values can't be guessed so each value
needs to be given. In best case the macro can somewhat shorten the
assignment (but no way it'd still fit nicely on one row) - in worst
case it just hides the meaning of values we are passing as arguments.
With raw assignment we at least have some idea what the 0x40 or 0x20 are
referring to =)

> [...]
> 
> > > > +subsys_initcall(bd70528_init);
> > > 
> > > Does it need to be initialised this early?
> > 
> > I think it may be required on some board(s). Is it a problem? I guess I
> > can change this for my purposes but guess it may become a problem later.
> 
> If you do this normally, you can use MACROs (see other drivers) and
> remove the boilerplate init code you have here.

Ok. I can change this. We can change it back if we need something
(regulators or GPIO or clk) to be ready at early stage. Currently my
setup does not require this.

> > > > +struct bd70528 {
> > > > +	/*
> > > > +	 * Please keep this as the first member here as some
> > > > +	 * drivers (clk) supporting more than one chip may only know this
> > > > +	 * generic struct 'struct rohm_regmap_dev' and assume it is
> > > > +	 * the first chunk of parent device's private data.
> > > > +	 */
> > > > +	struct rohm_regmap_dev chip;
> > > > +	/* wdt_set must be called rtc_timer_lock held */
> > > 
> > > This doesn't make sense.
> > 
> > Umm.. The comment does not make sense? Maybe I can explain it further.
> 
> "wdt_set must be called when the rtc_timer_lock is held"

Yes. I wanted to say that who-ever is calling the wdt_set function
below, should have locked the rtc_timer_lock mutex (last in this
struct). The function does not do locking inside because we want the RTC
to be able to perform:

lock
disable wdt (store original state)
set RTC
return wdt original state
unlock

Locking is needed so that we can exclude the watchdog enabling or
disabling the WDT timer between moments when RTC is getting the original
WDT state and re-turning back the old state. Without the lock we have a
risk that WDT-driver enables or disables the timer when RTC is being
set, and RTC overwrites the watchdog driver changes when writing back
the old state. I hope this makes sense now... Any suggestions how to
explain this nicely in english?

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
