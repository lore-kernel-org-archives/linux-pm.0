From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Date: Tue, 29 Jan 2019 09:01:03 +0200
Message-ID: <20190129070103.GA2551@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
 <20190128202656.GA17466@anatevka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128202656.GA17466@anatevka>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 01:26:56PM -0700, Jerry Hoemann wrote:
> On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
> > On 1/25/19 3:05 AM, Matti Vaittinen wrote:
> > > +static int bd70528_set_wake(struct bd70528 *bd70528,
> > > +			    int enable, int *old_state)
> > > +{
> > > +	int ret;
> > > +	unsigned int ctrl_reg;
> > > +
> > > +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WAKE_EN, &ctrl_reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (old_state) {
> > > +		if (ctrl_reg & BD70528_MASK_WAKE_EN)
> > > +			*old_state |= BD70528_WAKE_STATE_BIT;
> > > +		else
> > > +			*old_state &= ~BD70528_WAKE_STATE_BIT;
> > > +
> > > +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
> > > +			return 0;
> > 
> > I think
> > 		if (enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
> > would be much better readable. Even if not, there are way too many ()
> > in the above conditional.
> > 
> 
> The substitution is not equivalent to original.  I think you mean:
> 
>  		if (!!enable == !!(*old_state & BD70528_WAKE_STATE_BIT))

Thanks Jerry! Good catch! I originally wanted that all non-zero values
of 'enable' would be 'true'. So maybe I just use the original approach
but get rid of extra parenthesis which were pointed out by Guenter.

		if (!enable == !(*old_state & BD70528_WAKE_STATE_BIT))
should do it just fine, right?

Br,
	Matti
