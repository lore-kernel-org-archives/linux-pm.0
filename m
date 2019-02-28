From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Date: Thu, 28 Feb 2019 10:22:48 +0200
Message-ID: <20190228082248.GC3773@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228081055.GL4118@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228081055.GL4118@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
List-Id: linux-pm@vger.kernel.org

Hello Lee, Mark,

On Thu, Feb 28, 2019 at 08:10:55AM +0000, Lee Jones wrote:
> On Thu, 28 Feb 2019, Matti Vaittinen wrote:
> 
> > Hello Lee and Mark,
> > 
> > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > > Patch series introducing support for ROHM BD70528 PMIC
> > > 
> > I was wondering if there is anything that could be done to allow the MFD
> > part of this series to end up in upstream without having to wait the
> > regmap-irq changes
> > (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
> >  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> > regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> > To me it looks like getting them to MFD via Linus' tree will take a while.
> > 
> > The MFD part depends on the regmap-irq changes and I think that most
> > other subsystems want to have the MFD changes in before taking rest of
> > the driver in their trees. So it will be a while untill all the changes
> > are in. It would really be nice to have the drive in-tree sooner - hence
> > I ask if theres a way. (I don't want to push, just ask if it is possible :])
> 
> It's possible, so long as there aren't any build-time dependencies
> between the subsystems.  Immediate acceptance however isn't possible
> due to the impending merge-window which opens in 3 days.

Thanks for reply Lee. So merge-window is opening - meaning the 5.1 is
being baked now(?) 

Anyays to make it clear - there is build time dependency between MFD and
regmap-irq changes. MFD part won't compile without the changes in regmap
tree. And theres no new Kconfig to depend on or other compile time
checks. So REGMAP changes are required for this MFD portion to compile.

So my question actually is if the MFD portion must wait untill REGMAP
goes to Linus tree (at 5.2(?))- and then get merged to MFD tree later -
or if the regmap-irq changes can go to MFD via some other route (sorry -
I don't really know how you guys do maintain the trees - I really lack
of the insight/skills on that area :])

Rest of the subsystems (regulator, clk, watchdog, gpio) do all depend on
MFD - but they should have 'depends on' KConfig to MFD meaning they
won't be built without MFD.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
