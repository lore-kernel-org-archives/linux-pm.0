From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Thu, 2 Aug 2018 17:21:34 +0100
Message-ID: <20180802162132.7ur5poka5m7r2io2@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-13-quentin.perret@arm.com>
 <20180802135426.GX2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802135426.GX2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 02 Aug 2018 at 15:54:26 (+0200), Peter Zijlstra wrote:
> On Tue, Jul 24, 2018 at 01:25:19PM +0100, Quentin Perret wrote:
> > @@ -6385,18 +6492,26 @@ static int
> >  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
> >  {
> >  	struct sched_domain *tmp, *sd = NULL;
> > +	struct freq_domain *fd;
> >  	int cpu = smp_processor_id();
> >  	int new_cpu = prev_cpu;
> > -	int want_affine = 0;
> > +	int want_affine = 0, want_energy = 0;
> >  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> >  
> > +	rcu_read_lock();
> >  	if (sd_flag & SD_BALANCE_WAKE) {
> >  		record_wakee(p);
> > -		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> > -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> > +		fd = rd_freq_domain(cpu_rq(cpu)->rd);
> > +		want_energy = fd && !READ_ONCE(cpu_rq(cpu)->rd->overutilized);
> > +		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
> > +			      cpumask_test_cpu(cpu, &p->cpus_allowed);
> > +	}
> > +
> > +	if (want_energy) {
> > +		new_cpu = find_energy_efficient_cpu(p, prev_cpu, fd);
> > +		goto unlock;
> >  	}
> >  
> 
> And I suppose you rely on the compiler to optimize that for the static
> key inside rd_freq_domain()... Does it do a good job of that?

I does for sure when CONFIG_ENERGY_MODEL=n since rd_freq_domain() is
stubbed to false, but that's an easy one ;-)

> 
> That is, would not something like:
> 
> 
> 	rcu_read_lock();
> 	if (sd_flag & SD_BALANCE_WAKE) {
> 		record_wakee(p);
> 
> 		if (static_branch_unlikely(&sched_energy_present)) {
> 			struct root_domain *rd = cpu_rq(cpu)->rd;
> 			struct freq_domain *fd = rd_freq_domain(rd);
> 
> 			if (fd && !READ_ONCE(rd->overutilized)) {
> 				new_cpu = find_energy_efficient_cpu(p, prev_cpu, fd);
> 				goto unlock;
> 			}
> 		}
> 
> 		/* ... */
> 	}
> 
> 
> Be far more clear ?

It is clearer. Having the static key check in rd_freq_domain() makes
the change to find_busiest_group() smaller, but I can totally change it
with something like the above.

I'll do that in v6.

Thanks,
Quentin
