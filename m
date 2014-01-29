From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 29 Jan 2014 12:42:54 +0000
Message-ID: <20140129124254.GB10396@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140122192041.GA3709@e102568-lin.cambridge.arm.com>
 <CAKfTPtDHTs67qvoA6++zo4SZdZJj4T_BV2gVECOu-76-2kLbuw@mail.gmail.com>
 <20140124175806.GC23274@e102568-lin.cambridge.arm.com>
 <CAKfTPtAEekg_KHhLikJK=njC-b5F=MOmAmSP8P96+j_23-iu3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53726 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaA2Mm7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2014 07:42:59 -0500
In-Reply-To: <CAKfTPtAEekg_KHhLikJK=njC-b5F=MOmAmSP8P96+j_23-iu3Q@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

On Tue, Jan 28, 2014 at 08:24:54AM +0000, Vincent Guittot wrote:
> On 24 January 2014 18:58, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
[...]

> >> Please look below, i have modified the rest of your example accordingly
> >>
> >> >
> >> > }:
> >> >
> >> > and then
> >> >
> >> > state0 {
> >> >         index = <2>;
> >> >         compatible = "arm,cpu-power-state";
> >> >         latency = <...>;
> >> >         /*
> >> >          * This means that when the state is entered, the power
> >> >          * controller should use register index 0 and state 0,
> >> >          * whose meaning is power controller specific. Since we
> >> >          * know all components affected (for every component
> >> >          * we declare its power domain(s) and states so we
> >> >          * know what components are affected by the state entry.
> >> >          * Given the cache node above and this phandle, the state
> >> >          * implies that the cache is retained, register index == 0 state == 0
> >> >          /*
> >> >         power-domain =<&foo_power_controller 0 0>;
> >>
> >> for retention state we need to set the power domain in state 1
> >>         power-domain =<&foo_power_controller 0 1>;
> >>
> >> > };
> >> >
> >> > state1 {
> >> >         index = <3>;
> >> >         compatible = "arm,cpu-power-state";
> >> >         latency = <...>;
> >> >         /*
> >> >          * This means that when the state is entered, the power
> >> >          * controller should use register index 0 and state 1,
> >> >          * whose meaning is power controller specific. Since we
> >> >          * know all components affected (for every component
> >> >          * we declare its power domain(s) and states so we
> >> >          * know what components are affected by the state entry.
> >> >          * Given the cache node above and this phandle, the state
> >> >          * implies that the cache is lost, register index == 0 state == 1
> >> >          /*
> >> >         power-domain =<&foo_power_controller 0 1>;
> >>
> >> for power down mode, we need to set thge power domain in state 2
> >>         power-domain =<&foo_power_controller 0 2>;
> >
> > Ok, what I meant was not what you got, but your approach looks sensible
> > too. What I do not like is that the power-domain specifier is power
> 
> sorry for the misconception of your example
> 
> > controller specific (that was true even for my example). In theory
> > we can achieve something identical by forcing every component in a power
> > domain to specify the max C-state index that allows it to retain its
> 
> I'm not sure that we should force a component to set an opaque (for
> the component) max c-state. The device should describe its power
> domain requirements and the correlation of the latter with the
> description of the c-state binding should be enough to deduct the max
> c-state.

I agree, that was an option, I just loathe the idea of implementing it.
Using power domain specifiers is ways cleaner IMHO, the only drawback is
that, it is up to the power domain documentation to define what a state
means in terms of save/restore and cache behavior. I think that makes
perfect sense, at least for me.

> > state (through a specific property). Same logic to your example applies.
> > Nice thing is that we do not change the power domain specifiers, bad thing
> > is that it adds two properties to each device (c-state index and
> > power-domain-specifier - but we can make it hierarchical so that device
> > nodes can inherit the maximum operating C-state by inheriting the value
> > from a parent node providing a common value).
> >
> > In my example the third parameter was just a number that the power
> > controller would decode (eg 0 = cache retained, 1 = cache lost)
> > according to its implementation, it was not a "state index". The
> > power controller would know what to do with eg a cache component (that
> > declares to be in that power domain) when a C-state with that power
> > domain specifier was entered.
> >
> > Not very different from what you are saying, let's get to the nub:
> >
> > - Either we define it in a platform specific way through the power
> >   domain specifier
> > - Or we force a max-c-state-supported property for every device,
> >   possibly hierarchical
> 
> As explained above, adding a max-cstate property for a device that
> only know the power-domain is not a good thing IMHO.

I agree, if nobody complains that's the way I will define the bindings.

Thank you,
Lorenzo

