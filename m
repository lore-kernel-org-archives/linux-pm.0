From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT idle states bindings
Date: Fri, 27 Jun 2014 11:53:45 +0100
Message-ID: <20140627105345.GA3626@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625145849.GC15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33314 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbaF0Kxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 06:53:53 -0400
In-Reply-To: <20140625145849.GC15240@leverpostej>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel>

On Wed, Jun 25, 2014 at 03:58:49PM +0100, Mark Rutland wrote:

[...]

> > +===========================================
> > +4 - state node
> > +===========================================
> > +
> > +A state node represents an idle state description and must be defined as
> > +follows:
> > +
> > +- state node
> > +
> > +       Description: must be child of the idle-states node
> > +
> > +       The state node name shall follow standard device tree naming
> > +       rules ([5], 2.2.1 "Node names"), in particular state nodes which
> > +       are siblings within a single common parent must be given a unique name.
> > +
> > +       The idle state entered by executing the wfi instruction (idle_standby
> > +       SBSA,[3][4]) is considered standard on all ARM platforms and therefore
> > +       must not be listed.
> > +
> > +       With the definitions provided above, the following list represents
> > +       the valid properties for a state node:
> > +
> > +       - compatible
> > +               Usage: Required
> > +               Value type: <stringlist>
> > +               Definition: Must be "arm,idle-state".
> > +
> > +       - logic-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present logic is retained on state entry,
> > +                           otherwise it is lost.
> 
> What logic state is retained? All system registers?
> 
> > +       - cache-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present cache memory is retained on state entry,
> > +                           otherwise it is lost.
> 
> Likewise, how much of the cache hierarchy is affected? Any of it? All of
> it?
> 
> > +       - timer-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present the timer control logic is retained on
> > +                            state entry, otherwise it is lost.
> 
> The architected generic timers? Any CPU-local timers? Or any timers
> whatsoever?

Ok, as I mentioned this timer property is a blocking point for the
entire set. I gave it more thought, and it is a very hard nut to crack,
even if we resort to power domains (tick devices do not even contain
struct device or device node pointers, even if I added a list of
phandles to timers that are lost on idle state entry I would not be able
to figure out if the tick device is lost on idle state entry).

I am reasoning in kernel terms, I know it is bad but I can't help it
in this case.

Would a boolean property like the following one be deemed acceptable, eg:

- local-timer-stop

I want to be 100% honest here, this might turn out a Linux specific
thing, or might be not, but I still think it is representative of how HW
works.

Comments welcome and would be very appreciated on this specific detail.

Thanks,
Lorenzo

