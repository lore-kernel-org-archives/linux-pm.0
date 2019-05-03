From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Date: Fri, 3 May 2019 11:17:03 -0700
Message-ID: <20190503181703.GA5088@roeck-us.net>
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
 <20190503170042.19334-4-andrew.smirnov@gmail.com>
 <20190503170326.GB32529@roeck-us.net>
 <CAHQ1cqGkcOHnW1S8QGGcgY3qV6ErCq5gbYgGwspVeoEt_ce6tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGkcOHnW1S8QGGcgY3qV6ErCq5gbYgGwspVeoEt_ce6tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 03, 2019 at 12:33:40PM -0500, Andrey Smirnov wrote:
> On Fri, May 3, 2019 at 12:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Fri, May 03, 2019 at 10:00:42AM -0700, Andrey Smirnov wrote:
> > > Add bindings for Microchip UCS1002 Programmable USB Port Power
> > > Controller with Charger Emulation.
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Reviewed-by: Rob Herring <robh+dt@kernel.org>
> > > Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > ---
> > >  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > > new file mode 100644
> > > index 000000000000..1d284ad816bf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > > @@ -0,0 +1,27 @@
> > > +Microchip UCS1002 USB Port Power Controller
> > > +
> > > +Required properties:
> > > +- compatible         : Should be "microchip,ucs1002";
> > > +- reg                        : I2C slave address
> > > +
> > > +Optional properties:
> > > +- interrupts         : A list of interrupts lines present (could be either
> > > +                       corresponding to A_DET# pin, ALERT# pin, or both)
> > > +- interrupt-names    : A list of interrupt names. Should contain (if
> > > +                       present):
> > > +                       - "a_det" for line connected to A_DET# pin
> > > +                       - "alert" for line connected to ALERT# pin
> > > +                       Both are expected to be IRQ_TYPE_EDGE_BOTH
> > > +Example:
> > > +
> > > +&i2c3 {
> > > +     charger@32 {
> > > +             compatible = "microchip,ucs1002";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_ucs1002_pins>;
> > > +             reg = <0x32>;
> > > +             interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> > > +                                   <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
> >
> > interrupts ?
> 
> Can't really use it here since it assumes single "interrupt-parent"
> (we have gpio5 and gpio3 as parents above)
> 
Ah, ok. Thanks for the clarification.

Guenter
