From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: thermal: add binding document for h6
 thermal controller
Date: Fri, 17 May 2019 02:13:58 +0800
Message-ID: <CAEExFWvkM86ajB4io8yopkKEOfRE3UObRpqoi=Sq0RtDnuaRWA@mail.gmail.com>
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-4-tiny.windzz@gmail.com>
 <20190512134152.yrletgtiglxncyo4@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512134152.yrletgtiglxncyo4@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com, will.deacon@arm.com, David Miller <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan.Cameron@huawei.com, Nicolas Ferre <nicolas.ferre@microchip.com>, paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>, olof@lixom.net, bjorn.andersson@linaro.org, Jagan Teki <jagan@amarulasolutions.com>, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infra>
List-Id: linux-pm@vger.kernel.org

On Sun, May 12, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Sun, May 12, 2019 at 04:26:14AM -0400, Yangtao Li wrote:
> > This patch adds binding document for allwinner h6 thermal controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/thermal/sun50i-thermal.txt       | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
>
> We're starting to convert to YAML for binding descriptions that will
> allow to validate that all DT are properly using the binding. It would
> be great if you could use it as well.

What have been changed to this now?

>
> > diff --git a/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> > new file mode 100644
> > index 000000000000..67eda7794262
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> > @@ -0,0 +1,32 @@
> > +Binding for Thermal Sensor of Allwinner SOC.
> > +
> > +This describes the device tree binding for the Allwinner thermal controller
> > +which measures the on-SoC temperatures.
> > +
> > +Required properties:
> > +- compatible:
> > +  - "allwinner,sun50i-h6-ths" : For H6
> > +- reg: Address range of the thermal controller
> > +- clocks, clock-names: Clocks needed for the thermal controller.
> > +                    The required clocks for h6 are: "bus".
>
> If there's a single clock, then we don't need clock-names

Yeah, but, IIRC, H3 have two clk.
So I'd like to keep it.

>
> > +- resets, reset-names: Reference to the reset controller controlling
> > +                    the thermal controller.
>
> Ditto.

Done.

Thx,
Yangtao
>
> > +- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
> > +            unspecified default values shall be used.
> > +- nvmem-cell-names: Should be "calib"
>
> I thought you said that nvmem support was optional in the
> driver. Maybe we could make it optional in the DT too?
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
