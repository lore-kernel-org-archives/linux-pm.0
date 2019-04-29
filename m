From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2
Date: Mon, 29 Apr 2019 11:18:29 -0500
Message-ID: <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com>
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus> <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Miller <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 28, 2019 at 4:53 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Sat, Apr 27, 2019 at 5:15 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > frequency value based on the speedbin blown in the efuse combination.
> > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > provide the OPP framework with required information.
> > > This is used to determine the voltage and frequency value for each
> > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > >
> > > The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> > > with following parameters:
> > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > - opp-microvolt-<name>: voltage in micro Volts.
> > >   At runtime, the platform can pick a <name> and matching
> > >   opp-microvolt-<name> property.
> > >                       HW:             <name>:
> > >                       sun50iw-h6      speed0 speed1 speed2
> >
> > We already have at least one way to support speed bins with QC kryo
> > binding. Why do we need a different way?
>
> For some SOCs, for some reason (making the CPU have approximate performance),
> they use the same frequency but different voltage. In the case where
> this speed bin
> is not a lot and opp uses the same frequency, too many repeated opp
> nodes are a bit
> redundant and not intuitive enough.
>
> So, I think it's worth the new method.

Well, I don't.

We can't have every SoC vendor doing their own thing just because they
want to. If there are technical reasons why existing bindings don't
work, then maybe we need to do something different. But I haven't
heard any reasons.

Rob
