From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v7 05/10] clk: bd718x7: Support ROHM BD70528 clk block
Date: Thu, 7 Feb 2019 08:01:04 +0200
Message-ID: <20190207060104.GB5798@localhost.localdomain>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
 <88c49b30bbb4b1f3ecc24d333647585e2c82f4e4.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
 <154947428734.74891.4523492147164733315@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154947428734.74891.4523492147164733315@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 06, 2019 at 09:31:27AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2019-02-06 01:39:38)
> > @@ -86,9 +87,21 @@ static int bd71837_clk_probe(struct platform_device *pdev)
> >                 dev_err(&pdev->dev, "No parent clk found\n");
> >                 return -EINVAL;
> >         }
> > -
> > -       c->reg = BD718XX_REG_OUT32K;
> > -       c->mask = BD718XX_OUT32K_EN;
> > +       switch (mfd->chip_type) {
> > +       case ROHM_CHIP_TYPE_BD71837:
> > +       case ROHM_CHIP_TYPE_BD71847:
> > +
> 
> Nitpick: why the extra newline above?
For no obvious reason. I'll fix this as I need to create new version
anyways. I'll squash the first 3 patches and fix some issues pointed out
by the 0-Day test suite.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
