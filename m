From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Date: Wed, 10 Apr 2019 01:49:23 +0800
Message-ID: <CAEExFWs8jn1-Ht6Rq0ukL=Kz0sTwgf+kJzxw3Js=6hX+2OjYTA@mail.gmail.com>
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
 <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190405145532.cstvbv3mxbzrmpxp@flea>
 <CAEExFWuDjD2Ur6UuCPD_m=hvUYJj7Z=NqQ7KXXR+tmnVtDqfbQ@mail.gmail.com>
 <20190409080931.5x36pgtwhdjh2lkq@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190409080931.5x36pgtwhdjh2lkq@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: nm@ti.com, mark.rutland@arm.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, vireshk@kernel.org, rjw@rjwysocki.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mchehab+samsung@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 9, 2019 at 4:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 09, 2019 at 12:13:58AM +0800, Frank Lee wrote:
> > On Fri, Apr 5, 2019 at 10:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Apr 05, 2019 at 06:24:55AM -0400, Yangtao Li wrote:
> > > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > > frequency value  based on the speedbin blown in the efuse combination.
> > > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > > provide the OPP framework with required information.
> > > > This is used to determine the voltage and frequency value for each
> > > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > > >
> > > > This change adds documentation for the DT bindings.
> > > > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > > > with following parameters:
> > > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > > - opp-supported-hw: A single 32 bit bitmap value,
> > > >   representing compatible HW:
> > > >                       0:      speedbin 0
> > > >                       1:      speedbin 1
> > > >                       2:      speedbin 2
> > > >                       3-31:   unused
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
> > > >  1 file changed, 235 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > > new file mode 100644
> > > > index 000000000000..80201d4e5147
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > > @@ -0,0 +1,235 @@
> > > > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > > > +===================================
> > > > +
> > > > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > > > +varies based on the silicon variant in use. Allwinner Process Voltage
> > > > +Scaling Tables defines the voltage and frequency value  based on the
> > > > +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
> > > > +reads the efuse value from the SoC to provide the OPP framework with
> > > > +required information.
> > > > +
> > > > +Required properties:
> > > > +--------------------
> > > > +In 'cpus' nodes:
> > > > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > > > +
> > > > +In 'operating-points-v2' table:
> > > > +- compatible: Should be
> > > > +     - 'operating-points-v2-sunxi-cpu'.
> > > > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > > > +             efuse registers that has information about the
> > > > +             speedbin that is used to select the right frequency/voltage
> > > > +             value pair.
> > > > +             Please refer the for nvmem-cells
> > > > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > > > +             and also examples below.
> > > > +
> > > > +In every OPP node:
> > > > +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> > > > +                 Bitmap:
> > > > +                     0:      speedbin 0
> > > > +                     1:      speedbin 1
> > > > +                     2:      speedbin 2
> > > > +                     3-31:   unused
> > >
> > > I'm wondering if that's the right approach.
> > >
> > > I guess we could also have three different OPP tables, and pass them
> > > all three through a phandle array, and have the kernel code select
> > > which one is relevant based on the SID content
> >
> > It's ok. But why not use the way we already have?
> > Is it necessary to introduce new helper?
>
> My main concern is that it becomes quite difficult to differentiate
> the various OPPs, and to which bin a particular OPP is belonging to,
> while the more traditional OPPv2 makes it much more obvious.
Hi Maxime,

How about the newer patch ?
I think it is clearer. Just add a printk and people will know the opp
information used.

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
