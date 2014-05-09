From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v3 3/6] drivers: cpuidle: implement OF based idle
 states infrastructure
Date: Fri, 9 May 2014 13:04:19 +0100
Message-ID: <20140509120419.GA5040@e102568-lin.cambridge.arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-4-git-send-email-lorenzo.pieralisi@arm.com>
 <536c0f39.90ab420a.3da7.ffff86ca@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36532 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaEIME3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 08:04:29 -0400
In-Reply-To: <536c0f39.90ab420a.3da7.ffff86ca@mx.google.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sebastian Capella <capellas@>

On Fri, May 09, 2014 at 12:12:19AM +0100, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-05-06 11:04:40)
> 
> > diff --git a/drivers/cpuidle/of_idle_states.c b/drivers/cpuidle/of_idle_states.c
> > new file mode 100644
> > index 0000000..360b7ad
> > --- /dev/null
> > +++ b/drivers/cpuidle/of_idle_states.c
> > @@ -0,0 +1,293 @@
> ...
> > +static int __init add_state_node(cpumask_t *cpumask,
> > +                                struct device_node *state_node)
> > +{
> > +       struct state_elem *el;
> > +       u32 tmp, val = 0;
> > +
> > +       pr_debug(" * %s...\n", state_node->full_name);
> > +
> > +       if (!state_cpus_valid(cpumask, state_node))
> > +               return -EINVAL;
> > +       /*
> > +        * Parse just the properties required to sort the states.
> > +        * Since we are missing a value defining the energy
> > +        * efficiency of a state, for now the sorting code uses
> > +        *
> > +        * min-residency-us+exit-latency-us
> > +        *
> > +        * as sorting rank.
> > +        */
> > +       if (of_property_read_u32(state_node, "min-residency-us",
> > +                                &tmp)) {
> > +               pr_debug(" * %s missing min-residency-us property\n",
> > +                        state_node->full_name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       val += tmp;
> > +
> > +       if (of_property_read_u32(state_node, "exit-latency-us",
> > +                                &tmp)) {
> > +               pr_debug(" * %s missing exit-latency-us property\n",
> > +                            state_node->full_name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       val += tmp;
> 
> Sorry if i'm rehashing old stuff, but I prefer not to use the
> min-residency + exit-latency to sort.  I saw Rob's comment suggesting it
> and your reply.  I'm not sure when it was decided.
> 
> Would it be possible to sort instead based on the order in the
> cpus->cpu-idle-states?  If not, my preference would be to either use
> index like you had before, or specify another sort order / rank value.
> 
> I think there's potential for us to create lower power states that
> have lower min-residencies (reduced power consumption in the state,
> allowing us to more quickly recover the higher entrance cost)
> with higher exit latencies in such a way that the formula would not
> sort as we expect.  Having a separate value would allow us to control
> the sorting in those cases.

Ok, so adding to my previous comment, would exit_latency by itself be
enough ? Can we think of a system where ranking by exit_latency is wrong ?

If yes, we need a power rank, and this patch is wrong too:

http://marc.info/?l=linux-kernel&m=139924292401056&w=2

If answer is not, I can just rely on exit_latency to sort the states.

Lorenzo

