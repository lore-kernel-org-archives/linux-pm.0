From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
Date: Wed, 19 Mar 2014 17:23:39 +0000
Message-ID: <20140319172338.GA31368@e102568-lin.cambridge.arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
 <20140318180856.GB792@e102568-lin.cambridge.arm.com>
 <CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44490 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759340AbaCSRXr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 13:23:47 -0400
In-Reply-To: <CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <t.figa@samsu>

On Tue, Mar 18, 2014 at 09:49:12PM +0000, Sebastian Capella wrote:
> On 18 March 2014 11:08, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >> > +        * When we reach the max number of CPU idle states or
> >> > +        * head_idx == curr_idx (empty nodes queue) we are done.
> >> > +        */
> >> > +       head_idx = curr_idx = cnt;
> >> > +
> >> > +       do {
> >> > +               curr_idx = parse_idle_states_node(curr, curr_idx, cpus);
> >> > +               if (curr_idx == CPUIDLE_STATE_MAX || head_idx == curr_idx)
> >> > +                       break;
> >> > +               /*
> >> > +                * idle_states array is updated by parse_idle_states_node(),
> >> > +                * we can use the initialized states as a queue of nodes
> >> > +                * that need to be checked for their idle states siblings.
> >> > +                * head_idx works as a pointer into the queue to get the
> >> > +                * next node to be parsed.
> >> > +                */
> >> > +               curr = idle_states[head_idx++].node;
> >> > +       } while (curr);
> >>
> >> I still object to index property and this is why. You need to be able
> >> to determine state order by actual h/w properties. That is what you
> >> are doing in your head when you define the indexes.
> >>
> >> You really want a linked list here that you can sort as you go and not
> >> care what order you parse DT nodes. Not to mention you don't know how
> >> many states you will have.
> >
> > This code does not care about the order of nodes, the index is just there
> > to keep track of nodes that have still to be parsed. Sorting is done later,
> > using the index property (totally unrelated to the {head/curr}_idx) which I
> > understand is frowned upon in DT world (but in this case I think it could be
> > accepted, certainly it would make my life easier).
> >
> > Having said that, I like the idea of implementing it with a linked list and
> > sorting states while parsing them. I will remove that index property and
> > replace it with an actual hw property: power_consumption ? Or should I just
> > use min_residency (the higher the required residency the deeper the idle
> > state) ? Defining the power consumption (or better savings) for a state is
> > an _outright_ can of worms, that's why using an index is easier.
> >
> > Thoughts ?
> 
> How about something like rank, power_rank or power_score since it's
> neither an index nor a physical value but a value for sorting states
> relative to each other?

Well, if it is just a renaming issue we can use index just as well.

I hope that by now it is understood that the index property is not
the state index, it is a value representing relative power consumption.

Rob is asking a property describing hw, and honestly unless we define
a power consumption property value (defining what it means will be rather
complicated though) I'd rather remove index altogether and use min_residency
as a comparison value instead.

Lorenzo

