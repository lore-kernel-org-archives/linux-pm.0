From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v11 6/8] rtc: bd70528: Initial support for ROHM bd70528
 RTC
Date: Mon, 25 Mar 2019 18:04:51 +0100
Message-ID: <20190325170451.GQ30105@piout.net>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <901900e12e2a06865b3649ec94af511fcc6443a3.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <901900e12e2a06865b3649ec94af511fcc6443a3.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, heikki.haikola@fi.rohmeurope.com, mikko.muta
List-Id: linux-pm@vger.kernel.org

On 25/03/2019 14:06:42+0200, Matti Vaittinen wrote:
> Support RTC block in ROHM bd70528 power management IC. Support
> getting and setting the time and date as well as arming an alarm
> which can also be used to wake the PMIC from standby state.
> 
> HW supports wake interrupt only for the next 24 hours (sec, minute
> and hour information only) so we limit also the alarm interrupt to
> this 24 hours for the sake of consistency.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> +	r->time.hour |= BD70528_MASK_RTC_HOUR_24H;
> +	r->day |= bin2bcd(t->tm_mday);
> +	r->week |= bin2bcd(t->tm_wday);
> +	r->month |= bin2bcd(t->tm_mon + 1);
> +	r->year = bin2bcd(t->tm_year-100);

If you ever have to resend, please add spaces around that -


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
