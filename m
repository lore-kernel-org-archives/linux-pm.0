From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Mon, 27 Jan 2014 15:59:37 +0000
Message-ID: <20140127155924.GA2178@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:54212 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753657AbaA0QBM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 11:01:12 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Amit Kucheria <amit.kucheria@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, LAK <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@>

On Fri, Jan 24, 2014 at 05:58:07PM +0000, Lorenzo Pieralisi wrote:
> Hi Vincent,
> 
> On Fri, Jan 24, 2014 at 08:40:40AM +0000, Vincent Guittot wrote:
> 
> [...]
> 
> > Hi Lorenzo,
> > 
> > Sorry for the late reply,
> > 
> > 
> > > I had an idea. To simplify things, I think that one possibility is to
> > > add a parameter to the power domain specifier (platform specific, see
> > > Tomasz bindings):
> > 
> > We can't use a simple boolean state (on/off) for defining the
> > powerdomain state associated to a c-state so your proposal of being
> > able to add a parameter that will define the power domain state is
> > interesting.
> > 
> > >
> > > Documentation/devicetree/bindings/power/power_domain.txt
> > >
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224928.html
> > >
> > > to represent, when that state is entered the behavior of the power
> > > controller (ie cache RAM retention or cache shutdown or in general any
> > > substate within a power domain). Since it is platform specific, and since
> > > we are able to link caches to the power domain, the power controller will
> > > actually define what happens to the cache when that state is entered
> > > (basically we use the power domain specifier additional parameter to define
> > > a "substate" in that power domain e.g.:
> > >
> > > Example:
> > >
> > > foo_power_controller {
> > >         [...]
> > >         /*
> > >          * first cell is register index, second one is the state index
> > >          * that in turn implies the state behavior - eg cache lost or
> > >          * retained
> > >          */
> > >         #power-domain-cells = <2>;
> > > };
> > >
> > > l1-cache {
> > >         [...]
> > >         /*
> > >          * syntax: power-domains = list of power domain specifiers
> > >                 <[&power_domain_phandle register-index state],[&power_domain_phandle register-index state]>;
> > >                 The syntax is defined by the power controller du jour
> > >                 as described by Tomasz bindings
> > >         */
> > >         power-domains =<&foo_power_controller 0 0 &foo_power_controller 0 1>;
> > 
> > Normally, power-domains describes a list of power domain specifiers
> > that are necessary for the l1-cache to at least retain its state so
> > i'm not sure understand your example above
> 
> > 
> > If we take the example of system that support running, retention and
> > powerdown state described as state 0, 1 and 2 for the power domain, i
> > would have set the l1-cache like:
> >        power-domains =<&foo_power_controller 0 1>;
> > 
> > for saying that the state is retained up to state 1
> > 
> > Please look below, i have modified the rest of your example accordingly
> > 
> > >
> > > }:
> > >
> > > and then
> > >
> > > state0 {
> > >         index = <2>;
> > >         compatible = "arm,cpu-power-state";
> > >         latency = <...>;
> > >         /*
> > >          * This means that when the state is entered, the power
> > >          * controller should use register index 0 and state 0,
> > >          * whose meaning is power controller specific. Since we
> > >          * know all components affected (for every component
> > >          * we declare its power domain(s) and states so we
> > >          * know what components are affected by the state entry.
> > >          * Given the cache node above and this phandle, the state
> > >          * implies that the cache is retained, register index == 0 state == 0
> > >          /*
> > >         power-domain =<&foo_power_controller 0 0>;
> > 
> > for retention state we need to set the power domain in state 1
> >         power-domain =<&foo_power_controller 0 1>;

The name "power-domain" probably needs changing if the specifier contains
state information too.

Instead, we could call it "power-state" or similar.


Key issues I see:

1) How to describe platforms where there is no "power controller" as such,
   just a bunch of clocks and regulators that Linux has to poke directly.

2) Two devices might have the same power controller (in terms of IP and
   revision), but integrated in different ways.  So, maybe thinking of
   the referenced thing as a power controller is not correct.  We can
   thing in terms of referring to individual power domains, or maybe
   to a "power model" for the SoC.

   The power domain or model becomes a container for power (domains and)
   states, and refers to the IP blocks (power controllers, regulators,
   clocks, clamps, whatever) required to implement it.

   This change of abstraction might map more naturally onto "bunch
   of clocks and regulators" situations: the power model or domain
   binding can make symbolic references to clocks and regulators etc.,
   so that the binding becomes less dependent on the exact content of
   the rest of the DT.

3) We need to be very clear that the power state specifier needs to be
   defined in terms of the actual hardware effects in the relevant SoC-
   specific binding -- at the "what" level, rather than "how".

   There's a fair chance of people getting lazy: they'll just stuff
   indices in the DT which map to random LUTs in the Linux driver.  In
   that case, the DT would be describing the Linux driver, not the
   hardware -- that's not what we want.

   Delegating the job of defining power states to the SoC documentation
   seems acceptable, though.


Cheers
---Dave
