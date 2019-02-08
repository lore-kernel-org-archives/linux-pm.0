From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Fri, 8 Feb 2019 09:30:42 +0200
Message-ID: <20190208073042.GA3012@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140053.GG20638@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207140053.GG20638@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Again Lee,

After a good night sleep few things came to my mind =)

On Thu, Feb 07, 2019 at 02:00:53PM +0000, Lee Jones wrote:
> On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> 
> > +
> > +static struct mfd_cell bd70528_mfd_cells[] = {
> > +	{ .name = "bd70528-pmic", },
> > +	{ .name = "bd70528-gpio", },
> > +	/*
> > +	 * We use BD71837 driver to drive the clk block. Only differences to
> > +	 * BD70528 clock gate are the register address and mask.
> > +	 */
> > +	{ .name = "bd718xx-clk", },
> > +	{ .name = "bd70528-wdt", },
> > +	{
> > +		.name = "bd70528-power",
> > +		.resources = &charger_irqs[0],
> > +		.num_resources = ARRAY_SIZE(charger_irqs),
> > +	},
> > +	{
> 
> These should be on the same line.

I know I said 'Ok' yesterday. And I can change the styling to what ever
suits you - but I am not entirely sure what you mean by this? Do you
mean that the brackets should be on same line? After a quick look to
few other MFD devices it seems to be common convention to have these on
separate lines - and such style is used also at other locations
throughout this file. 

> > +static const struct regmap_access_table volatile_regs = {
> > +	.yes_ranges = &volatile_ranges[0],
> > +	.n_yes_ranges = ARRAY_SIZE(volatile_ranges),
> > +};
> > +
> > +static struct regmap_config bd70528_regmap = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.volatile_table = &volatile_regs,
> > +	.max_register = BD70528_MAX_REGISTER,
> > +	.cache_type = REGCACHE_RBTREE,
> > +};
> 
> '\n' here.
> 
> > +/* bit [0] - Shutdown register */
> > +unsigned int bit0_offsets[] = {0};
> > +/* bit [1] - Power failure register */
> > +unsigned int bit1_offsets[] = {1};
> > +/* bit [2] - VR FAULT register */
> > +unsigned int bit2_offsets[] = {2};
> > +/* bit [3] - PMU register interrupts */
> > +unsigned int bit3_offsets[] = {3};
> > +/* bit [4] - Charger 1 and Charger 2 registers */
> > +unsigned int bit4_offsets[] = {4, 5};
> > +/* bit [5] - RTC register */
> > +unsigned int bit5_offsets[] = {6};
> > +/* bit [6] - GPIO register */
> > +unsigned int bit6_offsets[] = {7};
> > +/* bit [7] - Invalid operation register */
> > +unsigned int bit7_offsets[] = {8};
> 
> What on earth is this?

Would this comment help:
/*
 * Mapping of main IRQ register bits to sub irq register offsets so
 * that we can access corect sub IRQ registers based on bits that
 * are set in main IRQ register.
 */

/* bit [0] - Shutdown register */
unsigned int bit0_offsets[] = {0};
/* bit [1] - Power failure register */
unsigned int bit1_offsets[] = {1};
/* bit [2] - VR FAULT register */
unsigned int bit2_offsets[] = {2};
/* bit [3] - PMU register interrupts */
unsigned int bit3_offsets[] = {3};
/* bit [4] - Charger 1 and Charger 2 registers */
unsigned int bit4_offsets[] = {4, 5};
/* bit [5] - RTC register */
unsigned int bit5_offsets[] = {6};
/* bit [6] - GPIO register */
unsigned int bit6_offsets[] = {7};
/* bit [7] - Invalid operation register */
unsigned int bit7_offsets[] = {8};

> > +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable, int *old_state)
> > +{
[..]
> > +}
> 
> Shouldn't this be one in the WDT driver?

Maybe I should explain it like this:

/*
 * Both the WDT and RTC drivers need to be able to control WDT. WDT uses
 * RTC for timeouts and setting the RTC may trigger watchdog. Thus the
 * RTC must disable the WDT when RTC time is set. We provide WDT disabling
 * code from the MFD parent as we don't want to make direct dependency
 * between RTC and WDT. Some may want to use only WDT or only RTC.
 */

#define WD_CTRL_MAGIC1 0x55
#define WD_CTRL_MAGIC2 0xAA

static int bd70528_wdt_set(struct bd70528 *bd70528, int enable, int *old_state)
{

> > +	/*
> > +	 * Disallow type setting for all IRQs by default as
> > +	 *  most of them do not support setting type.
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(irqs); i++)
> > +		irqs[i].type.types_supported = 0;
> > +
> > +	irqs[BD70528_INT_GPIO0].type.type_reg_offset = 0;
> > +	irqs[BD70528_INT_GPIO0].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO0].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO0].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO0].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO0].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > +	irqs[BD70528_INT_GPIO1].type.type_reg_offset = 2;
> > +	irqs[BD70528_INT_GPIO1].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO1].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO1].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO1].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO1].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > +	irqs[BD70528_INT_GPIO2].type.type_reg_offset = 4;
> > +	irqs[BD70528_INT_GPIO2].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO2].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO2].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO2].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO2].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > +	irqs[BD70528_INT_GPIO3].type.type_reg_offset = 6;
> > +	irqs[BD70528_INT_GPIO3].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO3].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO3].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO3].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO3].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> 
> Could you please explain:
> 
> a) what you're doing here
> b) why you don't mass assign them
>     - seeing as most of the data is identical.

I am not sure this is what you meant by mass assignment? Something like
below?

I think this makes the code slightly more confusing yet much shorter.
What would you say? Is this what you had in mind?

        /*
         * Set IRQ typesetting information for GPIO pins 0 - 3
         */
        for (i = 0; i < 4; i++) {
                struct regmap_irq_type *type;

                type = &irqs[BD70528_INT_GPIO0 + i].type;
                type->type_reg_offset = 2 * i;
                type-<type_rising_val = 0x20;
                type->type_falling_val = 0x10;
                type->type_level_high_val = 0x40;
                type->type_level_low_val = 0x50;
                type->types_supported = (IRQ_TYPE_EDGE_BOTH |
                                IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
        }

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
