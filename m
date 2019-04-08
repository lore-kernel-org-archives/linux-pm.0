From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
Date: Tue, 9 Apr 2019 00:13:58 +0800
Message-ID: <CAEExFWuDjD2Ur6UuCPD_m=hvUYJj7Z=NqQ7KXXR+tmnVtDqfbQ@mail.gmail.com>
References: <20190405102455.15311-1-tiny.windzz@gmail.com> <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190405145532.cstvbv3mxbzrmpxp@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405145532.cstvbv3mxbzrmpxp@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 5, 2019 at 10:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Fri, Apr 05, 2019 at 06:24:55AM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value  based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > This change adds documentation for the DT bindings.
> > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-supported-hw: A single 32 bit bitmap value,
> >   representing compatible HW:
> >                       0:      speedbin 0
> >                       1:      speedbin 1
> >                       2:      speedbin 2
> >                       3-31:   unused
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
> >  1 file changed, 235 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > new file mode 100644
> > index 000000000000..80201d4e5147
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > @@ -0,0 +1,235 @@
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
> > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > +             efuse registers that has information about the
> > +             speedbin that is used to select the right frequency/voltage
> > +             value pair.
> > +             Please refer the for nvmem-cells
> > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > +             and also examples below.
> > +
> > +In every OPP node:
> > +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> > +                 Bitmap:
> > +                     0:      speedbin 0
> > +                     1:      speedbin 1
> > +                     2:      speedbin 2
> > +                     3-31:   unused
>
> I'm wondering if that's the right approach.
>
> I guess we could also have three different OPP tables, and pass them
> all three through a phandle array, and have the kernel code select
> which one is relevant based on the SID content

It's ok. But why not use the way we already have?
Is it necessary to introduce new helper?

>
> Another option would be to use the OF_DYNAMIC code to fill
> operating-points-v2 at kernel boot, before (or when) cpufreq kicks in.

My thought is to keep the same with others. And this situation may
make thingis complex though it works.

Hi  vireshk,

I want to hear from you.

Yours,
Yangtao

>
> ATF could also do that work.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
