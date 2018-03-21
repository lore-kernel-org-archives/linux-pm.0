From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 21 Mar 2018 15:54:58 +0000
Message-ID: <20180321155458.GD13951@e110439-lin>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321123921.GB13951@e110439-lin>
 <20180321142630.GB2168@queper01-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321142630.GB2168@queper01-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 21-Mar 14:26, Quentin Perret wrote:
> On Wednesday 21 Mar 2018 at 12:39:21 (+0000), Patrick Bellasi wrote:
> > On 20-Mar 09:43, Dietmar Eggemann wrote:
> > > From: Quentin Perret <quentin.perret@arm.com>
> > 
> > [...]
> > 
> > > +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> > > +{
> > > +	unsigned long util, fdom_max_util;
> > > +	struct capacity_state *cs;
> > > +	unsigned long energy = 0;
> > > +	struct freq_domain *fdom;
> > > +	int cpu;
> > > +
> > > +	for_each_freq_domain(fdom) {
> > > +		fdom_max_util = 0;
> > > +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> > > +			util = cpu_util_next(cpu, p, dst_cpu);
> > 
> > Would be nice to find a way to cache all these util and reuse them
> > below... even just to ensure data consistency between the "cs"
> > computation and its usage...
> 
> So actually, what I can do is add something like
> 
>     fdom_tot_util += util;
> 
> to this loop and compute
> 
>     energy = cs->power * fdom_tot_util / cs->cap;
> 
> only once, instead of having the second loop to compute the energy. We don't
> have to scale the util for each and every CPU since they share the same
> cap state. That would save some divisions and ensure the consistency
> between the selection of the cap state and the associated energy
> computation. What do you think ?

Right, would say that under the hypothesis the we are in the same
frequency domain (and we are because of fdom->span), that's basically
doing:

   sum_i(P_x * U_i / C_x) => P_x / C_x * sum_i(U_i)

Where (C_x, P_x) are the EM reported capacity and power for the
expected frequency domain OPP.

> Or maybe you were talking about consistency between several consecutive
> calls to compute_energy() ?

Nope, the above +1

> > > +			fdom_max_util = max(util, fdom_max_util);
> > > +		}
> > > +
> > > +		/*
> > > +		 * Here we assume that the capacity states of CPUs belonging to
> > > +		 * the same frequency domains are shared. Hence, we look at the
> > > +		 * capacity state of the first CPU and re-use it for all.
> > > +		 */
> > > +		cpu = cpumask_first(&(fdom->span));
> > > +		cs = find_cap_state(cpu, fdom_max_util);
> >                 ^^^^
> > 
> > The above code could theoretically return NULL, although likely EAS is
> > completely disabled if em->nb_cap_states == 0, right?
> 
> That's right. sched_energy_present cannot be enabled with
> em->nb_cap_states == 0, and compute_energy() is never called without
> sched_energy_present in the proposed implementation.
> 
> > 
> > If that's the case then, in the previous function, you can certainly
> > avoid the initialization of *cs and maybe also add an explicit:
> > 
> >     BUG_ON(em->nb_cap_states == 0);
> > 
> > which helps even just as "in code documentation".
> > 
> > But, I'm not sure if maintainers like BUG_ON in scheduler code :)
> 
> Yes, I'm not sure about the BUG_ON either :).

FWIW, there are already some BUG_ON in fair.c... thus, if they can
pinpoint a specific bug in case of errors, they should be acceptable ?

> I agree that it would be nice to document somewhere that
> compute_energy() is unsafe to call without sched_energy_present.
> I can simply add a proper doc comment to this function actually.
> Would that work ?

Right, it's just that _maybe_ an explicit BUG_ON is improving the
documentation by making more explicit the error on testing ?

Thus, I would probably add both... but Peter will tell you for sure ;)

-- 
#include <best/regards.h>

Patrick Bellasi
