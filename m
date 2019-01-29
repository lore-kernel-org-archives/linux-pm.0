From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Date: Tue, 29 Jan 2019 13:46:53 +0200
Message-ID: <20190129114653.GB2551@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <20190128212009.GE18309@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128212009.GE18309@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Alexandre,

Big thanks for the review!

On Mon, Jan 28, 2019 at 10:20:09PM +0100, Alexandre Belloni wrote:
> Hello,
> 
> On 25/01/2019 13:05:36+0200, Matti Vaittinen wrote:
> > +static const struct rtc_class_ops bd70528_rtc_ops = {
> > +	.read_time	= bd70528_get_time,
> > +	.set_time	= bd70528_set_time,
> > +	.read_alarm	= bd70528_read_alarm,
> > +	.set_alarm	= bd70528_set_alarm,
> 
> You actually need to provide a .alarm_irq_enable callback, else there is
> no way to disable a set alarm.

Glad that you pointed this out. I thought the RTC core would use
set_alarm with enabled in struct rtc_wkalrm being zero for disabling
the alarm. I'll add alarm_irq_enable for disabling alarm at v3.

> > +	rtc = devm_rtc_device_register(&pdev->dev, "bd70528-rtc",
> > +				       &bd70528_rtc_ops, THIS_MODULE);
> > +	if (IS_ERR(rtc)) {
> > +		dev_err(&pdev->dev, "Registering RTC failed\n");
> > +		return PTR_ERR(rtc);
> > +	}
> 
> Please use devm_rtc_allocate_device() and set rtc->range_min and
> rtc->range_max before registering with rtc_register_device() (which can
> be done after trying to request the irq).

Right. I should've noted that devm_rtc_device_register was marked
deprecated. I'll fix this too at v3.

Br,
	Matti Vaittinen
