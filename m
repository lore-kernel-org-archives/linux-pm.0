From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
Date: Tue, 25 Mar 2014 11:51:33 +0000
Message-ID: <20140325115133.GA17526@e102568-lin.cambridge.arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
 <20140318180856.GB792@e102568-lin.cambridge.arm.com>
 <CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
 <20140319172338.GA31368@e102568-lin.cambridge.arm.com>
 <CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
 <CAL_JsqJikdsna7KUjEwZ0qj-fdcC50M7e3e1D0LgfQuUuJQ0SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57405 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbaCYLvk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Mar 2014 07:51:40 -0400
In-Reply-To: <CAL_JsqJikdsna7KUjEwZ0qj-fdcC50M7e3e1D0LgfQuUuJQ0SA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz

On Mon, Mar 24, 2014 at 05:46:47PM +0000, Rob Herring wrote:
> On Thu, Mar 20, 2014 at 1:19 PM, Sebastian Capella
> <sebastian.capella@linaro.org> wrote:
> > On 19 March 2014 10:23, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >> Rob is asking a property describing hw, and honestly unless we define
> >> a power consumption property value (defining what it means will be rather
> >> complicated though) I'd rather remove index altogether and use min_residency
> >> as a comparison value instead.
> >
> > I like having a separate ranking for power to sort the states.  To me
> > it seems that min residency could be ambiguous for this.  We could
> > have states with inverted min_residencies: where a lower consumption
> > state has a lower target residency because the cost is recovered more
> > quickly.  Such a state might have higher latency for exit, so even
> > though the lower min_residency/lower power state is clearly
> > preferable, selection of the lower power state may be prevented by
> > kernel latency constraints.
> 
> Perhaps you can add the min residency and exit latency times.

I do not think we should mix exit latency with power consumption
ranking, they are used and define different things.

The problem is that min_residency is extremely hard to define (see
discussion below).

http://www.spinics.net/lists/arm-kernel/msg316147.html

What should min_residency represent ? As Anti correctly pointed out, it should
be compared to a shallower idle state, but to define "shallower" we need
a ranking, do not we ?

If we say "min_residency is the time required for the processor to stay
in the idle state in order to maximize power savings" (and I tried to do that),
that's wrong by definition, because there might be a deeper idle state saving
more power when entered for a time within the next event.

state 1 - min residency 10 us
state 2 - min residency 20 us

If we sleep for 1 second, state 2 must be entered, not 1 and the problem
is always the same, state 1 10us compares to state 0 (break even time
against state 0).

So, we are back to square one. How should min_residency be defined ?
If it is the break even time against a shallower idle state, we have
to know what's the shallower idle state, so we need a power ranking for
idle states.

> Another piece to consider is the affinity level of the state should
> probably be the basis for 1st order sorting.

I would like to see the idle states as a flat list, when you say
affinity you mean a cpumask ? Affinity level in the PSCI power state
parameter ? In the MPIDR ?

Thanks,
Lorenzo

