From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v2 00/10] support ROHM BD70528 PMIC
Date: Mon, 28 Jan 2019 09:38:03 +0200
Message-ID: <20190128073803.GA2030@localhost.localdomain>
References: <20190125110110.GA29171@localhost.localdomain>
 <20190128071936.GD4678@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128071936.GD4678@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Lee, All

On Mon, Jan 28, 2019 at 07:19:36AM +0000, Lee Jones wrote:
> On Fri, 25 Jan 2019, Matti Vaittinen wrote:
> 
> > Patch series introducing support for ROHM BD70528 PMIC
> > 
> > Please note that patch 1 breaks compilation without patches 2 and 3
> > 
> > ROHM BD70528 is a programmable Power Management IC for battery
> > powered 'ultra low power' systems like the pre-announced NXP
> > i.MX7 ULP. This patch series introduces support for the PMIC.
> 
> It looks like you've sent this set un-threaded, which means as people
> reply to the patches, they are going to be spread out into the four
> winds (in Inbox terms).

Sigh. Sorry for trouble then. I must've forgotten the --thread from
git format-patch. You can skip the v2 if it's all scattered out, I
will address issues spotted by Guenter and send out the v3 - and this
time I make sure to use --thread =)

Br,
    Matti Vaittinen

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
