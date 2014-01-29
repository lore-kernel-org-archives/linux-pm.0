From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 29 Jan 2014 12:33:03 +0000
Message-ID: <20140129123303.GA10396@e102568-lin.cambridge.arm.com>
References: <20140127155924.GA2178@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58389 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaA2MdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2014 07:33:12 -0500
In-Reply-To: <20140127155924.GA2178@e103592.cambridge.arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Amit Kucheria <amit.kucheria@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, LAK <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@>

On Mon, Jan 27, 2014 at 03:59:37PM +0000, Dave Martin wrote:
> On Fri, Jan 24, 2014 at 05:58:07PM +0000, Lorenzo Pieralisi wrote:

[...]

> > > > state0 {
> > > >         index = <2>;
> > > >         compatible = "arm,cpu-power-state";
> > > >         latency = <...>;
> > > >         /*
> > > >          * This means that when the state is entered, the power
> > > >          * controller should use register index 0 and state 0,
> > > >          * whose meaning is power controller specific. Since we
> > > >          * know all components affected (for every component
> > > >          * we declare its power domain(s) and states so we
> > > >          * know what components are affected by the state entry.
> > > >          * Given the cache node above and this phandle, the state
> > > >          * implies that the cache is retained, register index == 0 state == 0
> > > >          /*
> > > >         power-domain =<&foo_power_controller 0 0>;
> > > 
> > > for retention state we need to set the power domain in state 1
> > >         power-domain =<&foo_power_controller 0 1>;
> 
> The name "power-domain" probably needs changing if the specifier contains
> state information too.
> 
> Instead, we could call it "power-state" or similar.
> 
> 
> Key issues I see:
> 
> 1) How to describe platforms where there is no "power controller" as such,
>    just a bunch of clocks and regulators that Linux has to poke directly.
> 
> 2) Two devices might have the same power controller (in terms of IP and
>    revision), but integrated in different ways.  So, maybe thinking of
>    the referenced thing as a power controller is not correct.  We can
>    thing in terms of referring to individual power domains, or maybe
>    to a "power model" for the SoC.

The example was misleading. There is no link to a power controller as
such, the phandle is to a power domain, which fits with what you are
saying, basically the C-state does not care about how the power domain
is implemented, it just defines that that specific power domain is
affected. I am not sure we should change the naming either, a C-state
defines a power-domain specifier, which implies a certain behaviour
for a power domain. It is platform specific, so for certain platforms
the cells represent a state for others they do not.

>    The power domain or model becomes a container for power (domains and)
>    states, and refers to the IP blocks (power controllers, regulators,
>    clocks, clamps, whatever) required to implement it.
> 
>    This change of abstraction might map more naturally onto "bunch
>    of clocks and regulators" situations: the power model or domain
>    binding can make symbolic references to clocks and regulators etc.,
>    so that the binding becomes less dependent on the exact content of
>    the rest of the DT.

Exactly, I agree, the complexity is in the power-domain (how states are
handled, what components should be programmed, etc) the C-state just
defines what power-domain it affects, with power domain specifier cells
providing additional, power domain specific, semantics (ie retention vs.
shutdown).

> 3) We need to be very clear that the power state specifier needs to be
>    defined in terms of the actual hardware effects in the relevant SoC-
>    specific binding -- at the "what" level, rather than "how".
> 
>    There's a fair chance of people getting lazy: they'll just stuff
>    indices in the DT which map to random LUTs in the Linux driver.  In
>    that case, the DT would be describing the Linux driver, not the
>    hardware -- that's not what we want.
> 
>    Delegating the job of defining power states to the SoC documentation
>    seems acceptable, though.

I agree, and I think we are pretty close to a general agreement on this
specific subject.

Thank you,
Lorenzo

