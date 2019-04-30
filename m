From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Date: Tue, 30 Apr 2019 17:32:36 -0500
Message-ID: <20190430223236.GA10236@bogus>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-4-andrew.smirnov@gmail.com>
 <20190430161542.GB731@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430161542.GB731@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 09:15:42AM -0700, Guenter Roeck wrote:
> On Mon, Apr 29, 2019 at 11:45:57PM -0700, Andrey Smirnov wrote:
> > Add bindings for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation.
> > 
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > new file mode 100644
> > index 000000000000..021fd7aba75e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > @@ -0,0 +1,27 @@
> > +Microchip UCS1002 USB Port Power Controller
> > +
> > +Required properties:
> > +- compatible		: Should be "microchip,ucs1002";
> > +- reg			: I2C slave address
> > +
> > +Optional properties:
> > +- interrupts-extended	: A list of interrupts lines present (could be either
> > +			  corresponding to A_DET# pin, ALERT# pin, or both)

Just make this 'interrupts'. Support for 'interrupts-extended' is 
implied.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> > +- interrupt-names	: A list of interrupt names. Should contain (if
> > +			  present):
> > +			  - "a_det" for line connected to A_DET# pin
> > +			  - "alert" for line connected to ALERT# pin
> > +			  Both are expected to be IRQ_TYPE_EDGE_BOTH
> > +Example:
> > +
> > +&i2c3 {
> > +	charger@32 {
> > +		compatible = "microchip,ucs1002";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_ucs1002_pins>;
> 
> Document the above ? Or is that optional ?

I would have said to document this, but recently we had some discussion 
about allowing this to be implied when there's only a 'default' entry. 
We'll add it automatically for schemas.

Rob
