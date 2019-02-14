From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 8/8] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Date: Thu, 14 Feb 2019 08:18:49 +0000
Message-ID: <20190214081849.GI1863@dell>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <5aab97a1d68d131d0c5d37e0a78d3c8147a52e9e.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <f11554b9-1842-13bc-7ceb-ca7589eb4518@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f11554b9-1842-13bc-7ceb-ca7589eb4518@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Feb 2019, Guenter Roeck wrote:

> On 2/13/19 5:37 AM, Matti Vaittinen wrote:
> > Initial support for watchdog block included in ROHM BD70528
> > power management IC.
> > 
> > Configurations for low power states are still to be checked.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > 
> > I maintained the ack from Guenter as only change is to use function
> > exported by MFD instead of pointer to function provided by MFD. Please
> > let me know if this is not Ok.
> > 
> 
> NP. With functions exported by MFD, my choice would have been to handle
> locking there as well with respective locking/unlocking functions exported.
> But that is your call to make, not mine.

FWIW, I agree.

[...]

Lots of superfluous quoting here mate.  Better to snip it off IMHO.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
