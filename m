From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Thu, 22 Mar 2018 05:05:29 +0000
Message-ID: <20180322050527.GA1559@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321123921.GB13951@e110439-lin>
 <20180321142630.GB2168@queper01-VirtualBox>
 <20180321155458.GD13951@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321155458.GD13951@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 Mar 2018 at 15:54:58 (+0000), Patrick Bellasi wrote:
> On 21-Mar 14:26, Quentin Perret wrote:
> > On Wednesday 21 Mar 2018 at 12:39:21 (+0000), Patrick Bellasi wrote:
> > > On 20-Mar 09:43, Dietmar Eggemann wrote:
> > > > From: Quentin Perret <quentin.perret@arm.com>

[...]

> > So actually, what I can do is add something like
> > 
> >     fdom_tot_util += util;
> > 
> > to this loop and compute
> > 
> >     energy = cs->power * fdom_tot_util / cs->cap;
> > 
> > only once, instead of having the second loop to compute the energy. We don't
> > have to scale the util for each and every CPU since they share the same
> > cap state. That would save some divisions and ensure the consistency
> > between the selection of the cap state and the associated energy
> > computation. What do you think ?
> 
> Right, would say that under the hypothesis the we are in the same
> frequency domain (and we are because of fdom->span), that's basically
> doing:
> 
>    sum_i(P_x * U_i / C_x) => P_x / C_x * sum_i(U_i)
> 
> Where (C_x, P_x) are the EM reported capacity and power for the
> expected frequency domain OPP.
> 

Yes that's exactly that. I'll do the change in v2.

> > Or maybe you were talking about consistency between several consecutive
> > calls to compute_energy() ?
> 
> Nope, the above +1
> 

[...]

> > I agree that it would be nice to document somewhere that
> > compute_energy() is unsafe to call without sched_energy_present.
> > I can simply add a proper doc comment to this function actually.
> > Would that work ?
> 
> Right, it's just that _maybe_ an explicit BUG_ON is improving the
> documentation by making more explicit the error on testing ?
> 
> Thus, I would probably add both... but Peter will tell you for sure ;)
> 

Right, but I'm still not sure if the BUG_ON is the right thing to do. I
mean, if we really want to make this check, then we could also try
to recover into a working state ... If we enter compute_energy() without
having an energy model, and if we detect it on time, we could bail out
and disable sched_energy_present ASAP with an error message for example.
That would let us know if EAS is broken without making the system
unusable.

Anyways, if there is a general agreement, or if the maintainers think
that the BUG_ON is the right thing to do here, I'm happy to change that
in future versions :)
