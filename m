From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v8 4/8] devicetree: bindings: Document first ROHM BD70528
 bindings
Date: Thu, 7 Feb 2019 18:33:42 +0200
Message-ID: <20190207163342.GC1920@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140418.GH20638@dell>
 <20190207153600.GA1920@localhost.localdomain>
 <20190207154229.GA19277@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207154229.GA19277@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee.jones@linaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 07, 2019 at 07:42:29AM -0800, Guenter Roeck wrote:
> On Thu, Feb 07, 2019 at 05:36:00PM +0200, Matti Vaittinen wrote:
> > Hello Lee,
> > 
> > Thanks for the reviews!
> > 
> > On Thu, Feb 07, 2019 at 02:04:18PM +0000, Lee Jones wrote:
> > > On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> > > 
> > > > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > > > drivers) and 4 GPIO pins which can be configured for I/O or
> > > > as interrupt sources withe configurable trigger levels.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
> > > >  1 file changed, 102 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > new file mode 100644
> > > > index 000000000000..f80be7e40184
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > @@ -0,0 +1,102 @@
> > > > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > > > +
> > > > +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> > > 
> > > What's an Iq?
> > 
> > http://www.ti.com/lit/an/slyt412/slyt412.pdf
> > Iq is an abbreviation of quiescet current. Do you think it's worth
> > writing the whole words instead of an abbreviation?
> > 
> https://acronyms.thefreedictionary.com/IQ lists 23 definitions.
> This one is not listed. Yes, I think it would be beneficial to use
> the whole word.

Allright. I'll change that too =)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
