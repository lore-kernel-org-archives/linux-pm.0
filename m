From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Date: Thu, 28 Feb 2019 09:04:50 +0200
Message-ID: <20190228070450.GB3773@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mazziesaccount@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
List-Id: linux-pm@vger.kernel.org

Hello Lee and Mark,

On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> Patch series introducing support for ROHM BD70528 PMIC
> 
> ROHM BD70528 is a programmable Power Management IC for battery
> powered 'ultra low power' systems like the pre-announced NXP
> i.MX7 ULP. This patch series introduces support for the PMIC. Please
> note that this driver only supports HW setup where PMIC is connected
> to I2C on A7 core. The other scenario is to use M4 as a power manager
> and connect pmic to M4. On such setups the A7 can only access pmic
> via M4 core using RPMSG virtio. Such setup depends on RPMSG
> implementation on M4 core and is currently not supported by this
> patch series.
> 

I was wondering if there is anything that could be done to allow the MFD
part of this series to end up in upstream without having to wait the
regmap-irq changes
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
 to be merged from Linus' tree to MFD tree? If I see it correctly, the
regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
To me it looks like getting them to MFD via Linus' tree will take a while.

The MFD part depends on the regmap-irq changes and I think that most
other subsystems want to have the MFD changes in before taking rest of
the driver in their trees. So it will be a while untill all the changes
are in. It would really be nice to have the drive in-tree sooner - hence
I ask if theres a way. (I don't want to push, just ask if it is possible :])

Best Regards
	Matti Vaittinen
