From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Date: Mon, 25 Mar 2019 08:02:06 +0000
Message-ID: <20190325080206.GZ4731@dell>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228081055.GL4118@dell>
 <20190228082248.GC3773@localhost.localdomain>
 <20190325073640.GB6208@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325073640.GB6208@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Mar 2019, Matti Vaittinen wrote:

> Hello again Lee & all,
> 
> On Thu, Feb 28, 2019 at 10:22:48AM +0200, Matti Vaittinen wrote:
> > On Thu, Feb 28, 2019 at 08:10:55AM +0000, Lee Jones wrote:
> > > On Thu, 28 Feb 2019, Matti Vaittinen wrote:
> > > 
> > > > Hello Lee and Mark,
> > > > 
> > > > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > > > > Patch series introducing support for ROHM BD70528 PMIC
> 
> //snip
> 
> > > > 
> > > > The MFD part depends on the regmap-irq changes and I think that most
> > > > other subsystems want to have the MFD changes in before taking rest of
> > > > the driver in their trees. So it will be a while untill all the changes
> > > > are in. It would really be nice to have the drive in-tree sooner - hence
> > > > I ask if theres a way. (I don't want to push, just ask if it is possible :])
> > > 
> > > It's possible, so long as there aren't any build-time dependencies
> > > between the subsystems.  Immediate acceptance however isn't possible
> > > due to the impending merge-window which opens in 3 days.
> > 
> > Thanks for reply Lee. So merge-window is opening - meaning the 5.1 is
> > being baked now(?) 
> > 
> > Anyays to make it clear - there is build time dependency between MFD and
> > regmap-irq changes. MFD part won't compile without the changes in regmap
> > tree. And theres no new Kconfig to depend on or other compile time
> > checks. So REGMAP changes are required for this MFD portion to compile.
> 
> //snip
> 
> > Rest of the subsystems (regulator, clk, watchdog, gpio) do all depend on
> > MFD - but they should have 'depends on' KConfig to MFD meaning they
> > won't be built without MFD.
> 
> I see the 5.1-rc1 and 5.1-rc2 are out. Those contain the regmap-irq
> changes the BD70528 MFD driver depends on. Would you like me to rebase
> the series to some other tree (which tree/branch? I don't see updated
> for-mfd-next branch in kernel.org yet) and resend it? Original patch
> series was created on top of the regulator tree.

If you could rebase and resend, that would be great.

You should (very nearly) always base on an upstream tag, so v5.1-rc2
would be best in this case.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
