From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Fri, 8 Feb 2019 10:57:43 +0000
Message-ID: <20190208105743.GI20638@dell>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140053.GG20638@dell>
 <20190207162807.GB1920@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207162807.GB1920@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Mark,

Something for you:

> > > +/* bit [0] - Shutdown register */
> > > +unsigned int bit0_offsets[] = {0};
> > > +/* bit [1] - Power failure register */
> > > +unsigned int bit1_offsets[] = {1};
> > > +/* bit [2] - VR FAULT register */
> > > +unsigned int bit2_offsets[] = {2};
> > > +/* bit [3] - PMU register interrupts */
> > > +unsigned int bit3_offsets[] = {3};
> > > +/* bit [4] - Charger 1 and Charger 2 registers */
> > > +unsigned int bit4_offsets[] = {4, 5};
> > > +/* bit [5] - RTC register */
> > > +unsigned int bit5_offsets[] = {6};
> > > +/* bit [6] - GPIO register */
> > > +unsigned int bit6_offsets[] = {7};
> > > +/* bit [7] - Invalid operation register */
> > > +unsigned int bit7_offsets[] = {8};
> > 
> > What on earth is this?
> 
> That's the mapping from main IRQ register bits to sub IRQ registers. The
> RFC version 1 had the patch which brough main irq register support. But
> good that you asked as I missed the fact that this commit is now only at
> the regmap tree - and this one depends on that.
>  
> > > +static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] = {
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
> > > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
> > > +};
> > 
> > This looks totally hairy.  What is it mean to look like?
> 
> Yes. Sorry. As explained above - this requires commit from regmap tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/include/linux/regmap.h?h=for-next&id=66fb181d6f824f7695417e8c19560c5b57dc8c2d

Mark, is this how this should be implemented?

The global arrays are hideous!

> > Shouldn't this be one in the WDT driver?
> 
> This is needed by both RTC and WDT drivers as RTC driver must stop the
> WDT when it sets RTC. WDT HW is using RTC counter and might trigger
> timeout/reset when RTC is set. Options are to dublicate the
> enable/disable to both drivers or to export a function or share a
> function pointer. I didn't want dublication or dependency between RTC
> and WDT drivers. Thus I thought that MFD is best place for this code as
> both RTC and WDT require it anyways. Perhaps this should be commented
> here?

I think an exported function with comments would be better.

[...]

> > > +	irqs[BD70528_INT_GPIO3].type.type_reg_offset = 6;
> > > +	irqs[BD70528_INT_GPIO3].type.type_rising_val = 0x20;
> > > +	irqs[BD70528_INT_GPIO3].type.type_falling_val = 0x10;
> > > +	irqs[BD70528_INT_GPIO3].type.type_level_high_val = 0x40;
> > > +	irqs[BD70528_INT_GPIO3].type.type_level_low_val = 0x50;
> > > +	irqs[BD70528_INT_GPIO3].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > 
> > Could you please explain:
> > 
> > a) what you're doing here
> 
> Regmap-irq gained support for type-setting. On bd70528 the type setting
> makes sense only for GPIO interrupts - so we must not populate type
> setting information for the rest of the IRQs. The macro REGMAP_IRQ_REG
> is nice and makes the irq struct initialization cleaner. Thus it is used.
> It does not allow populating the type information - hence we do it here.
> 
> I can change this if you think some other way would be cleaner?

It's pretty fugly.  Can the REGMAP_IRQ_REG be expanded upon?

> > b) why you don't mass assign them
> >     - seeing as most of the data is identical.
> 
> Maybe I am a bit slow today - but I don't know how the 'mass assignment'
> should be done?

Something like (completely untested):

unsigned int type_reg_offset_inc = 0;
for (i = BD70528_INT_GPIO0; i <=  BD70528_INT_GPIO3; i++) {
	irqs[i].type.type_reg_offset     = type_reg_offset_inc;
	irqs[i].type.type_rising_val     = 0x20;
	irqs[i].type.type_falling_val    = 0x10;
	irqs[i].type.type_level_high_val = 0x40;
	irqs[i].type.type_level_low_val  = 0x50;
	irqs[i].type.types_supported =
		(IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
	type_reg_offset_inc += 2;
}

It's still fugly though.

If we can do this via MACROs, it would be better.

[...]

> > > +subsys_initcall(bd70528_init);
> > 
> > Does it need to be initialised this early?
> 
> I think it may be required on some board(s). Is it a problem? I guess I
> can change this for my purposes but guess it may become a problem later.

If you do this normally, you can use MACROs (see other drivers) and
remove the boilerplate init code you have here.

> > > +struct bd70528 {
> > > +	/*
> > > +	 * Please keep this as the first member here as some
> > > +	 * drivers (clk) supporting more than one chip may only know this
> > > +	 * generic struct 'struct rohm_regmap_dev' and assume it is
> > > +	 * the first chunk of parent device's private data.
> > > +	 */
> > > +	struct rohm_regmap_dev chip;
> > > +	/* wdt_set must be called rtc_timer_lock held */
> > 
> > This doesn't make sense.
> 
> Umm.. The comment does not make sense? Maybe I can explain it further.

"wdt_set must be called when the rtc_timer_lock is held"

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
