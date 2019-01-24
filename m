From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v1 13/13] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Date: Thu, 24 Jan 2019 12:44:35 +0200
Message-ID: <20190124104434.GF2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190122154750.GB1705@roeck-us.net>
 <20190122171023.GC2559@localhost.localdomain>
 <20190122174056.GB4964@roeck-us.net>
 <20190122180309.GD2559@localhost.localdomain>
 <20190123174728.uu7zhno5xea2bga7@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123174728.uu7zhno5xea2bga7@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 23, 2019 at 06:47:28PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jan 22, 2019 at 08:03:09PM +0200, Matti Vaittinen wrote:
> > On Tue, Jan 22, 2019 at 09:40:56AM -0800, Guenter Roeck wrote:
> > > On Tue, Jan 22, 2019 at 07:10:23PM +0200, Matti Vaittinen wrote:
> > > > On Tue, Jan 22, 2019 at 07:47:50AM -0800, Guenter Roeck wrote:
> > > > > On Tue, Jan 22, 2019 at 11:48:36AM +0200, Matti Vaittinen wrote:
> > > > > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct bd70528 *tmp;
> > > > > > +	struct bd70528 *bd70528;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	tmp = dev_get_drvdata(pdev->dev.parent);
> > > > > > +	if (!tmp) {
> > > > > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
> > > > > > +	if (!bd70528)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	*bd70528 = *tmp;
> > > > > > +	bd70528->chip.dev = &pdev->dev;
> > > > > 
> > > > > This is wrong.
> > > > > You should not copy the parent's driver data but have local driver
> > > > > data as needed which then points to the parent's driver data if
> > > > > needed. I assume this is why the mutex is a pointer, but that
> > > > > just shows that the whole approach is wrong.
> > > > 
> > > > Mutex is a pointer because we want to use same mutex from WDT and RTC.
> > > > We can sure point to parent data but then we still need our own dev
> > > > pointer. So we can have a struct with pointer to parent data and dev
> > > > pointer - but I'm not at all sure it is any clearer.
> > > 
> > > As I said, that is wrong. To say it in plaintext, I won't accept
> > > the driver if it copies the parent's driver data. The driver should
> > > have and use its own driver data, and only maintain a pointer to
> > > its parent's driver data. And most definitely you don't want to
> > > copy and use any device data structure from the parent.
> > 
> > Allright. At the moment the WDT driver only needs regmap pointer from
> > parent. I'm not sure if it will later need DT or "chip type" - but I
> > will change this.
> 
> You probably want to use this:
> 
> dev_get_regmap(pdev->dev.parent, NULL);

Thanks a bunch Sebastian. All help is highly appreciated!! =)

Unfortunately I forgot to mention the key thing - the RTC mutex. We also
need that because RTC needs to stop WDT when RTC is adjusted as the WDT
uses RTC as counter - and jumping the RTC WDT enabled might trigger WDT
or have other consequences.

Se even if we used dev_get_regmap (which is slightly heavier than
accessing direct pointer) - we would still need at least the mutex from
parent data, possibly also the chip type and if we want to avoid code
dublication - then also the WDT start/stop function.

Thus I guess we can as well keep the regmap in parent data because we
need the parent data anyways, right?

Br
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
