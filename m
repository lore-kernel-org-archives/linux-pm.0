From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Date: Mon, 28 Jan 2019 22:20:09 +0100
Message-ID: <20190128212009.GE18309@piout.net>
References: <20190125110536.GA29321@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125110536.GA29321@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On 25/01/2019 13:05:36+0200, Matti Vaittinen wrote:
> +static const struct rtc_class_ops bd70528_rtc_ops = {
> +	.read_time	= bd70528_get_time,
> +	.set_time	= bd70528_set_time,
> +	.read_alarm	= bd70528_read_alarm,
> +	.set_alarm	= bd70528_set_alarm,

You actually need to provide a .alarm_irq_enable callback, else there is
no way to disable a set alarm.

> +	rtc = devm_rtc_device_register(&pdev->dev, "bd70528-rtc",
> +				       &bd70528_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc)) {
> +		dev_err(&pdev->dev, "Registering RTC failed\n");
> +		return PTR_ERR(rtc);
> +	}

Please use devm_rtc_allocate_device() and set rtc->range_min and
rtc->range_max before registering with rtc_register_device() (which can
be done after trying to request the irq).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
