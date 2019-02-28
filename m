From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v1 07/13] devicetree: bindings: Document first ROHM
 BD70528 bindings
Date: Thu, 28 Feb 2019 08:49:23 +0200
Message-ID: <20190228064923.GA3773@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <80de7a2b537ae3f414b0281736652256f38cf94c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190223003041.GA16670@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190223003041.GA16670@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

Hello Rob, All

Sorry for long delay - I was ill for a few days. Back at the business
now =)

Rob, maybe dropping the RFC tag has messed your book keeping? This
is the latest version:
https://lore.kernel.org/lkml/90c3b820baf072a7cc3a21aa50c661774a045158.1550148989.git.matti.vaittinen@fi.rohmeurope.com/
and I thought it already had the Reviewed-by tag from you :)

On Fri, Feb 22, 2019 at 06:30:41PM -0600, Rob Herring wrote:
> On Tue, Jan 22, 2019 at 11:45:38AM +0200, Matti Vaittinen wrote:
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> 
> 'dt-bindings: mfd: ...' for the subject.

I see at least the patch subject comment is still valid though. Do you
want me to change it and resubmit the series?

> 
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 +++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > new file mode 100644
> > index 000000000000..21801440a53a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > @@ -0,0 +1,104 @@
> > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > +
> > +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> > +for battery-powered portable devices. The IC integrates 3 ultra-low current
> > +consumption buck converters, 3 LDOs and 2 LED Drivers. Also included are 4
> > +GPIOs, a real-time clock (RTC), a 32kHz clock gate, high-accuracy VREF
> > +for use with an external ADC, flexible dual-input power path, 10 bits SAR ADC
> > +for battery temperature monitor and 1S battery charger with scalable charge
> > +currents.

Br,
	Matti Vaittinen


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
