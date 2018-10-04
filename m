From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Thu, 4 Oct 2018 12:41:07 +0200
Message-ID: <20181004104107.GN19272@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-13-quentin.perret@arm.com>
 <20181004094412.GD19252@hirez.programming.kicks-ass.net>
 <20181004102722.izp7y42cvayq4pqg@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004102722.izp7y42cvayq4pqg@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 11:27:22AM +0100, Quentin Perret wrote:
> > > +		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
> > 
> > Which of the two masks do we expect to be the smallest?
> 
> Typically, perf_domain_span is smaller.

OK, then the above expression is in the right order :-)

> > > +			if (spare_cap > max_spare_cap) {
> > > +				max_spare_cap = spare_cap;
> > > +				max_spare_cap_cpu = cpu;
> > > +			}
> > 
> > Sometimes I wonder if something like:
> > 
> > #define min_filter(varp, val)		\
> > ({					\
> > 	typeof(varp) _varp = (varp);	\
> > 	typeof(val)  _val  = (val);	\
> > 	bool f = false;			\
> > 					\
> > 	if (_val < *_varp) {		\
> > 		*_varp = _val;		\
> > 		f = true;		\
> > 	}				\
> > 					\
> > 	f;				\
> > })
> > 
> > and the corresponding max_filter() are worth the trouble; it would allow
> > writing:
> > 
> > 	if (max_filter(&max_spare_cap, spare_cap))
> > 		max_spare_cap_cpu = cpu;
> > 
> > and:
> > 
> > > +		}
> > > +
> > > +		/* Evaluate the energy impact of using this CPU. */
> > > +		if (max_spare_cap_cpu >= 0) {
> > > +			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
> > > +			if (cur_energy < best_energy) {
> > > +				best_energy = cur_energy;
> > > +				best_energy_cpu = max_spare_cap_cpu;
> > > +			}
> > 
> > 	if (min_filter(&best_energy, cur_energy))
> > 		best_energy_cpu = max_spare_cap_cpu;
> > 
> > But then I figure, it is not... dunno. We do lots of this stuff.
> 
> If there are occurrences of this stuff all over the place, we could do
> that in a separate clean-up patch that does just that, for the entire
> file. Or maybe more ?

Sure, not something that needs done now. I just always think of this
when I see this pattern repeated, but never seem to get around to doing
anything about it.

I figured I'd mention it ;-)

> > I would much prefer this to be something like:
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a8f601edd958..5475a885ec9f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6299,12 +6299,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >  {
> >  	struct sched_domain *tmp, *sd = NULL;
> >  	int cpu = smp_processor_id();
> > -	int new_cpu = prev_cpu;
> > +	unsigned int new_cpu = prev_cpu;
> >  	int want_affine = 0;
> >  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> >  
> >  	if (sd_flag & SD_BALANCE_WAKE) {
> >  		record_wakee(p);
> > +
> > +		if (static_branch_unlikely(sched_eas_balance)) {
> > +			new_cpu = select_task_rq_eas(p, prev_cpu, sd_flags, wake_flags);
> > +			if (new_cpu < nr_cpu_ids)
> > +				return new_cpu;
> > +		}
> > +
> >  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> >  			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> >  	}
> > and then hide everything (including that giant comment) in
> > select_task_rq_eas().
> 
> So you think we should rename find_energy_efficient_cpu and put all the
> checks in there ? Or should select_task_rq_eas do the checks and then
> call find_energy_efficient_cpu ?
> 
> Not a huge deal, but that'll save some time if we agree on that one
> upfront.

Not sure, see what it looks like ;-) My main concern here was to get rid
of that giant blob in select_task_rq_fair().
