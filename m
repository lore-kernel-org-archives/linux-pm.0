From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
Date: Thu, 18 Apr 2019 21:10:25 +0800
Message-ID: <CAEExFWvmpnJ8EyvAejVtvBQHdVVGFhpSn7zCMmx1BSre-gt+Ug@mail.gmail.com>
References: <20190416155209.24216-1-tiny.windzz@gmail.com> <20190416155209.24216-3-tiny.windzz@gmail.com>
 <20190417083000.cwzvhlpbxqoifosw@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417083000.cwzvhlpbxqoifosw@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 17, 2019 at 4:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 16, 2019 at 11:52:09AM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > The "allwinner,sun50i-h6-operating-points" DT extends the
> > "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-microvolt-<name>: voltage in micro Volts.
> >   At runtime, the platform can pick a <name> and matching
> >   opp-microvolt-<name> property.
> >                       HW:             <name>:
> >                       sun50iw-h6      speed0 speed1 speed2
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
> >  1 file changed, 167 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> > new file mode 100644
> > index 000000000000..3cb39c6caec3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> > @@ -0,0 +1,167 @@
> > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > +===================================
> > +
> > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > +varies based on the silicon variant in use. Allwinner Process Voltage
> > +Scaling Tables defines the voltage and frequency value based on the
> > +speedbin blown in the efuse combination. The sun50i-cpufreq-nvmem driver
> > +reads the efuse value from the SoC to provide the OPP framework with
> > +required information.
> > +
> > +Required properties:
> > +--------------------
> > +In 'cpus' nodes:
> > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > +
> > +In 'operating-points-v2' table:
> > +- compatible: Should be
> > +     - 'allwinner,sun50i-h6-operating-points'.
> > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > +             efuse registers that has information about the speedbin
> > +             that is used to select the right frequency/voltage value
> > +             pair. Please refer the for nvmem-cells bindings
> > +             Documentation/devicetree/bindings/nvmem/nvmem.txt and
> > +             also examples below.
> > +
> > +In every OPP node:
> > +- opp-microvolt-<name>: Voltage in micro Volts.
> > +                     At runtime, the platform can pick a <name> and
> > +                     matching opp-microvolt-<name> property.
> > +                     [See: opp.txt]
> > +                     HW:             <name>:
> > +                     sun50iw-h6      speed0 speed1 speed2
>
> There's a typo here (and in your commit log), it should be sun50i-h6
> instead of sun50iw-h6
>
> Once fixed:
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Another has been sent.

Regards,
Yangtao
