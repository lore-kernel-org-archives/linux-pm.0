From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH RESEND v13 7/8] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Date: Thu, 2 May 2019 10:35:39 +0300
Message-ID: <20190502073539.GB7864@localhost.localdomain>
References: <cover2.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
 <resend.d5ba82b3d674d237d62a5e1768c9fa81cde2cf4e.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
 <20190501222535.yt4ofrlf6wfwfmz7@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501222535.yt4ofrlf6wfwfmz7@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, heikki.haikola@fi.rohmeurope.
List-Id: linux-pm@vger.kernel.org

Hello Sebastian,

Thanks for the review. This is highly appreciated as charger subsystem
is new to me =)

On Thu, May 02, 2019 at 12:25:35AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Apr 25, 2019 at 02:16:51PM +0300, Matti Vaittinen wrote:
> > ROHM BD70528 PMIC includes battery charger block. Support charger
> > staus queries and doing few basic settings like input current limit
> > and charging current.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---

//snip

> > +struct irq_name_pair {
> > +	const char *n;
> > +	irqreturn_t (*h)(int irq, void *arg);
> > +};
> > +
> > +static int bd70528_get_irqs(struct platform_device *pdev,
> > +			    struct bd70528_psy *bdpsy)
> > +{
> > +	int irq, i, ret;
> > +	unsigned int mask;
> > +	struct irq_name_pair bd70528_chg_irqs[] = {
> > +		{ .n = "bd70528-bat-ov-res", .h = BD_IRQ_HND(BAT_OV_RES) },
> > +		{ .n = "bd70528-bat-ov-det", .h = BD_IRQ_HND(BAT_OV_DET) },
> > +		{ .n = "bd70528-bat-dead", .h = BD_IRQ_HND(DBAT_DET) },
> > +		{ .n = "bd70528-bat-warmed", .h = BD_IRQ_HND(COLD_RES) },
> > +		{ .n = "bd70528-bat-cold", .h = BD_IRQ_HND(COLD_DET) },
> > +		{ .n = "bd70528-bat-cooled", .h = BD_IRQ_HND(HOT_RES) },
> > +		{ .n = "bd70528-bat-hot", .h = BD_IRQ_HND(HOT_DET) },
> > +		{ .n = "bd70528-chg-tshd", .h = BD_IRQ_HND(CHG_TSD) },
> > +		{ .n = "bd70528-bat-removed", .h = BD_IRQ_HND(BAT_RMV) },
> > +		{ .n = "bd70528-bat-detected", .h = BD_IRQ_HND(BAT_DET) },
> > +		{ .n = "bd70528-dcin2-ov-res", .h = BD_IRQ_HND(DCIN2_OV_RES) },
> > +		{ .n = "bd70528-dcin2-ov-det", .h = BD_IRQ_HND(DCIN2_OV_DET) },
> > +		{ .n = "bd70528-dcin2-removed", .h = BD_IRQ_HND(DCIN2_RMV) },
> > +		{ .n = "bd70528-dcin2-detected", .h = BD_IRQ_HND(DCIN2_DET) },
> > +		{ .n = "bd70528-dcin1-removed", .h = BD_IRQ_HND(DCIN1_RMV) },
> > +		{ .n = "bd70528-dcin1-detected", .h = BD_IRQ_HND(DCIN1_DET) },
> > +	};
> 
> static const?

Const seems appropriate but I don't see the benefits of static? I think
it's just fine to have this at stack?

> > +
> > +struct linear_range {
> > +	int min;
> > +	int step;
> > +	int vals;
> > +	int low_sel;
> > +};
> > +
> > +struct linear_range current_limit_ranges[] = {
> > +	{
> > +		.min = 5,
> > +		.step = 1,
> > +		.vals = 36,
> > +		.low_sel = 0,
> > +	},
> > +	{
> > +		.min = 40,
> > +		.step = 5,
> > +		.vals = 5,
> > +		.low_sel = 0x23,
> > +	},
> > +	{
> > +		.min = 60,
> > +		.step = 20,
> > +		.vals = 8,
> > +		.low_sel = 0x27,
> > +	},
> > +	{
> > +		.min = 200,
> > +		.step = 50,
> > +		.vals = 7,
> > +		.low_sel = 0x2e,
> > +	}
> > +};
> 
> static const?

Definitely static, can be const too. Thanks.

> > +/*
> > + * BD70528 would support setting and getting own charge current/
> > + * voltage for low temperatures. The driver currently only reads
> > + * the charge current at room temperature. We do set both though.
> > + */
> > +struct linear_range warm_charge_curr[] = {
> > +	{
> > +		.min = 10,
> > +		.step = 10,
> > +		.vals = 20,
> > +		.low_sel = 0,
> > +	},
> > +	{
> > +		.min = 200,
> > +		.step = 25,
> > +		.vals = 13,
> > +		.low_sel = 0x13,
> > +	},
> > +};
> 
> static const?

Yes. I agree. Thanks =)
 
> > +static const struct power_supply_desc bd70528_charger_desc = {
> > +	.name		= "bd70528-charger",
> > +	.type		= POWER_SUPPLY_TYPE_BATTERY,
> 
> charge should use POWER_SUPPLY_TYPE_MAINS (or
> POWER_SUPPLY_TYPE_USB for USB chargers).

I'll check this. Thanks.
 
> > +	.properties	= bd70528_charger_props,
> > +	.num_properties	= ARRAY_SIZE(bd70528_charger_props),
> > +	.get_property	= bd70528_charger_get_property,
> > +	.set_property	= bd70528_charger_set_property,
> > +	.property_is_writeable	= bd70528_prop_is_writable,
> > +};
> > +
> > +static int bd70528_power_probe(struct platform_device *pdev)
> > +{
> > +	struct rohm_regmap_dev *mfd;
> > +	struct bd70528_psy *bdpsy;
> > +	struct power_supply_config cfg = {};
> > +
> > +	mfd = dev_get_drvdata(pdev->dev.parent);
> > +	if (!mfd) {
> > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > +		return -EINVAL;
> > +	}
> 
> There is absolutley no need for this hack. Just get the regmap
> for the parent device and store the regmap and the device pointer
> directly in bdpsy.

So I guess you suggest just using the dev_get_regmap(pdev->dev.parent)
instead of using the platform data from parent? This is fine now as we
don't care about the chip_type just now as the only PMIC thic charger
driver supports for now is BD70528. So I can drop reading the parent's
drvdata - although we may get back to this when I work with next ROHM
PMIC with (almost) similar charger block.. :) But I'll switch to the
dev_get_regmap() for now.
 
> > +	bdpsy = devm_kzalloc(&pdev->dev, sizeof(*bdpsy), GFP_KERNEL);
> > +	if (!bdpsy)
> > +		return -ENOMEM;
> > +	bdpsy->chip = *mfd;
> > +	bdpsy->chip.dev = &pdev->dev;
> > +
> > +	platform_set_drvdata(pdev, bdpsy);
> > +	cfg.drv_data = bdpsy;
> > +	cfg.of_node = pdev->dev.parent->of_node;
> > +
> > +	bdpsy->psy = devm_power_supply_register(&pdev->dev,
> > +						&bd70528_charger_desc, &cfg);
> > +	if (IS_ERR(bdpsy->psy)) {
> > +		dev_err(&pdev->dev, "failed: power supply register\n");
> > +		return PTR_ERR(bdpsy->psy);
> > +	}
> > +
> > +	return bd70528_get_irqs(pdev, bdpsy);
> > +}
> > +
> > +static struct platform_driver bd70528_power = {
> > +	.driver = {
> > +		.name = "bd70528-power"
> > +	},
> > +	.probe = bd70528_power_probe,
> > +};
> > +
> > +module_platform_driver(bd70528_power);
> > +
> > +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> > +MODULE_DESCRIPTION("BD70528 power-supply driver");
> > +MODULE_LICENSE("GPL");
> 
> Otherwise looks ok to me.

Thanks. I'll fix issues you pointed (except the static struct in
function) and translate this to ack. Please let me know if this is not
Ok or if you really think the array bd70528_chg_irqs (which is local to
function) should be static.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
