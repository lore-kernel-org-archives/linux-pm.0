From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Thu, 5 Jul 2018 18:48:09 +0100
Message-ID: <20180705174809.GA21903@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-6-quentin.perret@arm.com>
 <20180705172922.GQ2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705172922.GQ2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 05 Jul 2018 at 19:29:22 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:36PM +0100, Quentin Perret wrote:
> >  static void free_rootdomain(struct rcu_head *rcu)
> >  {
> >  	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
> > @@ -211,6 +224,9 @@ static void free_rootdomain(struct rcu_head *rcu)
> >  	free_cpumask_var(rd->rto_mask);
> >  	free_cpumask_var(rd->online);
> >  	free_cpumask_var(rd->span);
> > +#ifdef CONFIG_ENERGY_MODEL
> > +	free_fd(rd->fd);
> > +#endif
> 
> If you provide a stub function, you can reduce #ifdef.

I cannot just stub free_fd since the 'fd' member of the root_domain is
also defined only for CONFIG_ENERGY_MODEL=y.

But I can introduce a free_rd_fd(fd) function that will be stubbed if
you think that's better. Or make sure to have 'fd' attached to the
root_domain even for CONFIG_ENERGY_MODEL=n.

> 
> >  	kfree(rd);
> >  }
> >  
> > @@ -1635,6 +1651,104 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> >  	return sd;
> >  }
> >  
> > +#ifdef CONFIG_ENERGY_MODEL
> 
>   < snip content >
> 
> > +#endif
> 
> And is there any reason this #ifdef cannot be merged with the one above?

Not really, it was just easier to keep build_freq_domains() close to
partition_sched_domains() while writing/reading the code but that is
a very weak argument, I agree. I'll move all of that to the ifdef above.

> That is, try and do a pass of #ifdef reduction on this file.

Ok I'll look into that.

Thanks,
Quentin
