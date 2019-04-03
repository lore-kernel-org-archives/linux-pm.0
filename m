From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v11 4/8] dt-bindings: mfd: Document first ROHM BD70528
 bindings
Date: Wed, 3 Apr 2019 12:04:06 +0300
Message-ID: <20190403090406.GB3493@localhost.localdomain>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <c674ef76ca0a3298e6b13ade4ab29775edf36a76.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073426.GN4187@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403073426.GN4187@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, heikki.haikola@fi.rohmeurop
List-Id: linux-pm@vger.kernel.org

And thanks again for fixing the language. Appreciated!

On Wed, Apr 03, 2019 at 08:34:26AM +0100, Lee Jones wrote:
> On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> 
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > new file mode 100644
> > index 000000000000..120462c17904
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > @@ -0,0 +1,102 @@
> > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > +
> > +BD70528MWV is an ultra-low quiescet current general purpose single-chip
> 
> What does 'quiescet' mean?

I guess you knew what I meant =) Quiescent - I'll fix the typo.

> "general purpose, single-chip,"

Rules for using commas are far beyond my skills. I was bad in it at
Finnish classes. Not to even mention English. Actually, the teacher
suggested us to rather leave out the commas than trying to place them
correctly in English sentences. Guess the rules are not that simple =)

So I'll just add them as you suggested =)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
