From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v1 05/13] mfd: bd70528: Support ROHM bd70528 PMIC -
 core
Date: Tue, 22 Jan 2019 18:20:51 +0200
Message-ID: <20190122162051.GA2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <fea02522fe54190cfc7f3500f4e6540c8af82453.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <9abdc69e-6aea-e1a5-c170-ebcba7f5b20f@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9abdc69e-6aea-e1a5-c170-ebcba7f5b20f@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

Hello Guenter,

Thanks for taking the time and doing review!

On Tue, Jan 22, 2019 at 06:51:26AM -0800, Guenter Roeck wrote:
> On 1/22/19 1:44 AM, Matti Vaittinen wrote:
> > +static DEFINE_MUTEX(rtc_timer_mutex);

// snip

> > +static int bd70528_i2c_probe(struct i2c_client *i2c,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct bd70528 *bd70528;
> > +	struct regmap_irq_chip_data *irq_data;
> > +	int ret, i;
> > +
> > +	if (!i2c->irq) {
> > +		dev_err(&i2c->dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> > +	bd70528 = devm_kzalloc(&i2c->dev, sizeof(*bd70528), GFP_KERNEL);
> > +
> > +	if (!bd70528)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(&i2c->dev, bd70528);
> > +	bd70528->rtc_timer_lock = &rtc_timer_mutex;
> 
> One global mutex for all instances of this driver is odd.
> Why isn't this just part of struct bd70528 ?
> 

You are right. This was a brainfart from my side. I don't think there
is many cases where this would har though. I don't expect to see
many instances of PMIC drivers load. But you are correct nevertheless.
I will fix this in future version. Thanks for pointing it out!

Br,
	Matti Vaittinen


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
