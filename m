From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Date: Wed, 6 Mar 2019 12:38:16 +0200
Message-ID: <20190306103816.GA23959@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228114026.GA6802@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228114026.GA6802@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 28, 2019 at 11:40:26AM +0000, Mark Brown wrote:
> On Thu, Feb 28, 2019 at 09:04:50AM +0200, Matti Vaittinen wrote:
> > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> 
> >> Patch series introducing support for ROHM BD70528 PMIC
> > 
> > I was wondering if there is anything that could be done to allow the MFD
> > part of this series to end up in upstream without having to wait the
> > regmap-irq changes
> > (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
> >  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> > regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> > To me it looks like getting them to MFD via Linus' tree will take a while.
> 
> They're targeted for v5.1 and I sent a pull request to Lee for that
> branch IIRC.
Thanks Mark. I think I have misunderstood how you deliver changes to 5.1
- or then I have done some other mistake. I thought these changes were
  not going to 5.1 as I did not see them in your for-5.1 branch. But I
probably did some error there. Thanks for explaining this :)

Br,
	Matti Vaittinen



-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
