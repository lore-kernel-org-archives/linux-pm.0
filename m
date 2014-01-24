From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Fri, 24 Jan 2014 17:58:07 +0000
Message-ID: <20140124175806.GC23274@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140122192041.GA3709@e102568-lin.cambridge.arm.com>
 <CAKfTPtDHTs67qvoA6++zo4SZdZJj4T_BV2gVECOu-76-2kLbuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38189 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaAXR6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2014 12:58:13 -0500
In-Reply-To: <CAKfTPtDHTs67qvoA6++zo4SZdZJj4T_BV2gVECOu-76-2kLbuw@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

Hi Vincent,

On Fri, Jan 24, 2014 at 08:40:40AM +0000, Vincent Guittot wrote:

[...]

> Hi Lorenzo,
> 
> Sorry for the late reply,
> 
> 
> > I had an idea. To simplify things, I think that one possibility is to
> > add a parameter to the power domain specifier (platform specific, see
> > Tomasz bindings):
> 
> We can't use a simple boolean state (on/off) for defining the
> powerdomain state associated to a c-state so your proposal of being
> able to add a parameter that will define the power domain state is
> interesting.
> 
> >
> > Documentation/devicetree/bindings/power/power_domain.txt
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224928.html
> >
> > to represent, when that state is entered the behavior of the power
> > controller (ie cache RAM retention or cache shutdown or in general any
> > substate within a power domain). Since it is platform specific, and since
> > we are able to link caches to the power domain, the power controller will
> > actually define what happens to the cache when that state is entered
> > (basically we use the power domain specifier additional parameter to define
> > a "substate" in that power domain e.g.:
> >
> > Example:
> >
> > foo_power_controller {
> >         [...]
> >         /*
> >          * first cell is register index, second one is the state index
> >          * that in turn implies the state behavior - eg cache lost or
> >          * retained
> >          */
> >         #power-domain-cells = <2>;
> > };
> >
> > l1-cache {
> >         [...]
> >         /*
> >          * syntax: power-domains = list of power domain specifiers
> >                 <[&power_domain_phandle register-index state],[&power_domain_phandle register-index state]>;
> >                 The syntax is defined by the power controller du jour
> >                 as described by Tomasz bindings
> >         */
> >         power-domains =<&foo_power_controller 0 0 &foo_power_controller 0 1>;
> 
> Normally, power-domains describes a list of power domain specifiers
> that are necessary for the l1-cache to at least retain its state so
> i'm not sure understand your example above

> 
> If we take the example of system that support running, retention and
> powerdown state described as state 0, 1 and 2 for the power domain, i
> would have set the l1-cache like:
>        power-domains =<&foo_power_controller 0 1>;
> 
> for saying that the state is retained up to state 1
> 
> Please look below, i have modified the rest of your example accordingly
> 
> >
> > }:
> >
> > and then
> >
> > state0 {
> >         index = <2>;
> >         compatible = "arm,cpu-power-state";
> >         latency = <...>;
> >         /*
> >          * This means that when the state is entered, the power
> >          * controller should use register index 0 and state 0,
> >          * whose meaning is power controller specific. Since we
> >          * know all components affected (for every component
> >          * we declare its power domain(s) and states so we
> >          * know what components are affected by the state entry.
> >          * Given the cache node above and this phandle, the state
> >          * implies that the cache is retained, register index == 0 state == 0
> >          /*
> >         power-domain =<&foo_power_controller 0 0>;
> 
> for retention state we need to set the power domain in state 1
>         power-domain =<&foo_power_controller 0 1>;
> 
> > };
> >
> > state1 {
> >         index = <3>;
> >         compatible = "arm,cpu-power-state";
> >         latency = <...>;
> >         /*
> >          * This means that when the state is entered, the power
> >          * controller should use register index 0 and state 1,
> >          * whose meaning is power controller specific. Since we
> >          * know all components affected (for every component
> >          * we declare its power domain(s) and states so we
> >          * know what components are affected by the state entry.
> >          * Given the cache node above and this phandle, the state
> >          * implies that the cache is lost, register index == 0 state == 1
> >          /*
> >         power-domain =<&foo_power_controller 0 1>;
> 
> for power down mode, we need to set thge power domain in state 2
>         power-domain =<&foo_power_controller 0 2>;

Ok, what I meant was not what you got, but your approach looks sensible
too. What I do not like is that the power-domain specifier is power
controller specific (that was true even for my example). In theory
we can achieve something identical by forcing every component in a power
domain to specify the max C-state index that allows it to retain its
state (through a specific property). Same logic to your example applies.
Nice thing is that we do not change the power domain specifiers, bad thing
is that it adds two properties to each device (c-state index and
power-domain-specifier - but we can make it hierarchical so that device
nodes can inherit the maximum operating C-state by inheriting the value
from a parent node providing a common value).

In my example the third parameter was just a number that the power
controller would decode (eg 0 = cache retained, 1 = cache lost)
according to its implementation, it was not a "state index". The
power controller would know what to do with eg a cache component (that
declares to be in that power domain) when a C-state with that power
domain specifier was entered.

Not very different from what you are saying, let's get to the nub:

- Either we define it in a platform specific way through the power
  domain specifier
- Or we force a max-c-state-supported property for every device,
  possibly hierarchical

Thoughts ?

Thank you !
Lorenzo

