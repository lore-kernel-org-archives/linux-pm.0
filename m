From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Date: Mon, 28 Jan 2019 09:48:49 +0200
Message-ID: <20190128074849.GB2030@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thanks again Guenter,

On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
> On 1/25/19 3:05 AM, Matti Vaittinen wrote:
> > +/*
> > + * We read regs RTC_SEC => RTC_YEAR
> > + * this struct is ordered according to chip registers.
> > + * Keep it u8 only to avoid padding issues.
> > + */
> > +struct bd70528_rtc_day {
> > +	u8 sec;
> > +	u8 min;
> > +	u8 hour;
> > +};
> > +
> > +struct bd70528_rtc_data {
> > +	struct bd70528_rtc_day time;
> > +	u8 week;
> > +	u8 day;
> > +	u8 month;
> > +	u8 year;
> > +};
> > +
> > +struct bd70528_rtc_wake {
> > +	struct bd70528_rtc_day time;
> > +	u8 ctrl;
> > +};
> > +
> > +struct bd70528_rtc_alm {
> > +	struct bd70528_rtc_data data;
> > +	u8 alm_mask;
> > +	u8 alm_repeat;
> > +};
> 
> At least some of the above are directly associated with chip registers.
> I don't think this will work for all architectures without explicit packed
> attribute.

Allright. I was thinking of that but thought that most of the
architectures using this PMIC would handle alignments fine if I used
only u8 members. I did consider using __attribute__((packed)) - but I'm
not sure if we hit into troubles with that too. I guess some people
would like to compile kernel with other compiler(s) but gcc - although
I'm not sure if this should be taken into account. I'll try doing some
study on this - unless someone replies to this and just tells how this
should be done. (I am pretty sure I can find the answer from mail
archives though). I'll try adding some packing hint for compiler at v3.

> > +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
> > +			return 0;
> 
> I think
> 		if (enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
> would be much better readable. Even if not, there are way too many ()
> in the above conditional.

Allright. I'll fix this
 
> > +	if (alm.alm_mask & BD70528_MASK_ALM_EN)
> > +		a->enabled = 0;
> > +	else
> > +		a->enabled = 1;
> > +
> Without conditional:
> 	a->enabled = !(alm.alm_mask & BD70528_MASK_ALM_EN);
> 

Right. Much nicer, thanks! I'll change this.

> > +static int bd70528_set_time(struct device *dev, struct rtc_time *t)
> > +{
> > +	int ret, old_states;
> > +	struct bd70528_rtc_data rtc_data;
> > +	struct bd70528_rtc *r = dev_get_drvdata(dev);
> > +	struct bd70528 *bd70528 = r->mfd;
> > +
> > +	ret = bd70528_disable_rtc_based_timers(r, &old_states);
> > +
> 
> AFAICS the disable/enable functions are only called once. Since they
> also apply set / clear a mutex, I find that a bit confusing. I think
> it would be better to fold the code into this function. If anything,
> I could imagine something like
> 
> 	mutex_lock();
> 	ret = bd70528_set_time_locked();
> 	mutex_unlock()
> 
> to simplify error handling.

Yep. Makes sense. I'll tidy this.

> > +	ret = regmap_bulk_read(bd70528->chip.regmap,
> > +			       BD70528_REG_RTC_START, &rtc_data,
> > +			       sizeof(rtc_data));
> > +
> > +	tm2rtc(t, &rtc_data);
> > +
> > +	ret = regmap_bulk_write(bd70528->chip.regmap,
> > +				BD70528_REG_RTC_START, &rtc_data,
> > +				sizeof(rtc_data));
> > +
> > +	ret = bd70528_re_enable_rtc_based_timers(r, old_states);
> > +
> 
> Kind of off that all the error returns are ignored here.

And I'll fix this too.

Br,
	Matti Vaittinen
