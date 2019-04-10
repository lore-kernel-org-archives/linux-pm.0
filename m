From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
Date: Thu, 11 Apr 2019 01:49:39 +0800
Message-ID: <CAEExFWu60DZ2xY7qxpjGFq3f_u2G4p7y-wqmsj0HR7CQy24r7w@mail.gmail.com>
References: <20190409172558.18778-1-tiny.windzz@gmail.com> <20190409172558.18778-3-tiny.windzz@gmail.com>
 <20190410145659.62nl4o2jvkuggmpe@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410145659.62nl4o2jvkuggmpe@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 10, 2019 at 10:57 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 09, 2019 at 01:25:58PM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value  based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-microvolt-<name>: voltage in micro Volts.
> >   At runtime, the platform can pick a <name> and matching
> >   opp-microvolt-<name> property
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > new file mode 100644
> > index 000000000000..c81a2075b974
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > @@ -0,0 +1,166 @@
> > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > +===================================
> > +
> > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > +varies based on the silicon variant in use. Allwinner Process Voltage
> > +Scaling Tables defines the voltage and frequency value  based on the
> > +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
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
> > +     - 'operating-points-v2-sunxi-cpu'.
>
> Vendor-specific compatibles should have the vendor mentionned.
>
> Also, even though the H6 is the only SoC so far that has needed this,
> we can't really assume that it will be the only SoC to use it, or that
> it will always behave like that.
There is no doubt that many platforms need this.
>
> So having something like allwinner,sun50i-h6-operating-points would be
> great.
allwinner,cpu-operating-points-v2 Maybe better?
>
> > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > +             efuse registers that has information about the
> > +             speedbin that is used to select the right frequency/voltage
> > +             value pair.
> > +             Please refer the for nvmem-cells
> > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > +             and also examples below.
> > +
> > +In every OPP node:
> > +- opp-microvolt-<name>: Voltage in micro Volts.
> > +                     At runtime, the platform can pick a <name> and
> > +                     matching opp-microvolt-<name> property.
> > +                     [See: opp.txt]
>
> You need to document the valid names here.
OK.

Cheers,
Yangtao
