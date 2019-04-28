From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2
Date: Sun, 28 Apr 2019 17:53:05 +0800
Message-ID: <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426211540.GA890@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mark.rutland@arm.com, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 27, 2019 at 5:15 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-microvolt-<name>: voltage in micro Volts.
> >   At runtime, the platform can pick a <name> and matching
> >   opp-microvolt-<name> property.
> >                       HW:             <name>:
> >                       sun50iw-h6      speed0 speed1 speed2
>
> We already have at least one way to support speed bins with QC kryo
> binding. Why do we need a different way?

For some SOCs, for some reason (making the CPU have approximate performance),
they use the same frequency but different voltage. In the case where
this speed bin
is not a lot and opp uses the same frequency, too many repeated opp
nodes are a bit
redundant and not intuitive enough.

So, I think it's worth the new method.

Yangtao

>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 168 ++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
