From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 06/10] devicetree: bindings: Document first ROHM
 BD70528 bindings
Date: Thu, 31 Jan 2019 08:40:51 +0200
Message-ID: <20190131064050.GC23791@localhost.localdomain>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
 <eb5d03f3adc72db580a10f95ff6cb07aefce5b47.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
 <20190130185344.GA14789@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130185344.GA14789@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Rob,

Thanks for taking the carefull look once again =)

On Wed, Jan 30, 2019 at 12:53:44PM -0600, Rob Herring wrote:
> On Wed, Jan 30, 2019 at 11:09:55AM +0200, Matti Vaittinen wrote:
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 +++++++++++++++++++++

snip

> > + - interrupt-parent	: Phandle to the parent interrupt controller.
> 
> Don't document this. It is implied and could be in a parent node.

Allright. I'll remove this then.

> > + - clock-frequency	: Should be 32768
> 
> Forget to drop this?

Well spotted. The rate should come from parent clock. I'll drop this
too.

> > +Example:
> > +/* external oscillator */
> > +osc: oscillator {
> > +	compatible = "fixed-clock";
> > +	#clock-cells = <1>;
> > +	clock-frequency  = <32768>;
> > +	clock-output-names = "osc";
> > +};
> > +
> > +pmic: bd70528@4b {
> 
> pmic@4b
> 
> Node names should be generic.

Ok. I will change this.

Br,
	Matti

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
